---
date: 2018-02-13
title: Handle animations
description: How to move and animate entities in your scene
categories:
  - development-guide
type: Document
---

3D models in _.glTF_ and _.glb_ format can include as many animations as you want in them. Animations tell the mesh how to move, by specifying a series of _keyframes_ that are laid out over time, the mesh then blends from one pose to the other to simulate continuous movement.

Most 3D model animations are [_skeletal animations_](https://en.wikipedia.org/wiki/Skeletal_animation). These animations simplify the complex geometry of the model into a "stick figure", linking every vertex in the mesh to the closest _bone_ in the _skeleton_. Modelers adjust the skeleton into different poses, and the mesh stretches and bends to follow these movements.

As an alternative, _vertex animations_ animate a model without the need of a skeleton. These animations specify the position of each vertex in the model directly. Decentraland supports these animations as well.

See [Animations]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-13-animations %}) for details on how to create animations for a 3D model. Read [Shape components]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}) for instructions on how to import a 3D model to a scene.

> Tip: Animations are usually better for moving something in place, not for changing the position of an entity. For example, you can set an animation to move a character's feet in place, but to change the location of the entity it's best to use the Transform component. See [Positioning entities]({{ site.baseurl }}{% post_url /development-guide/2018-02-12-move-entities %}) for more details.

## Check a 3D model for animations

Not all _glTF_ files include animations. To see if there are any available, you can do the following:

- If using [VS Code](https://code.visualstudio.com/)(recommended), install the _GLTF Tools_ extension and view the contents of a glTF file there.
- Open the [Babylon Sandbox](https://sandbox.babylonjs.com/) site and drag the glTF file (and any _.jpg_ or _.bin_ dependencies) to the browser.
- Open the _.glTF_ file with a text editor and scroll down till you find _"animations":_.

> Tip: In _skeletal_ animations, an animation name is often comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

## Automatic playing

If a 3d model includes any animations, the default behavior is that the first of these is always played on a loop.

To avoid this behavior, add an `Animator` component to the entity that has the model, and then handle the playing of animations explicitly. If an `Animator` component is present in the entity, all animations default to a `stopped` state, and need to be manually played.

## Handle animations explicitly

An `Animator` component is used to access all the animations of the entity and can be used to explicitly tell the entity to play or stop an animation. Each animation is handled by an `AnimationState` object.

![]({{ site.baseurl }}/images/media/ecs-animations.png)

```ts
// Create entity
let shark = new Entity()

// Add a 3D model to it
shark.addComponent(new GLTFShape("models/shark.gltf"))

// Create animator component
let animator = new Animator()

// Add animator component to the entity
shark.addComponent(animator)

// Instance animation clip object
const clipSwim = new AnimationState("swim")

// Add animation clip to Animator component
animator.addClip(clipSwim)

// Add entity to engine
engine.addEntity(shark)
```

You can also achieve the same with less statements:

```ts
// Create and add animator component
shark.addComponent(new Animator())

// Instance and add a clip
shark.getComponent(Animator).addClip(new AnimationState("swim"))
```

You can retrieve an `AnimationState` object from an `Animator` component with the `getClip()` function.

```ts
// Create and get a clip
let clipSwim = animator.getClip("swim")
```

The `AnimationState` object doesn't store the actual transformations that go into the animation, that's all in the .glTF file. Instead, the `AnimationState` object has a state that keeps track how far it has advanced along the animation.

## Fetch an animation

If you don't have a pointer to refer to the clip object directly, you can fetch a clip from the `Animator` by name using `getClip()`.

```ts
// Create and add a clip
shark.getComponent(Animator).addClip(new AnimationState("swim"))

// Fetch the clip
shark.getComponent(Animator).getClip("swim")
```

<!--
... which one is true?

> Note: If you attempt to use `getClip()` to fetch a clip that doesn't exist in the Animator component, it returns `null`.

If you try to get an `AnimationState` that was never added to the `Animator` component, the clip is created and added automatically.
-->

## Play an animation

When an `AnimationState` is created, it starts as paused by default.

The simplest way to play or pause it is to use the `play()` and `pause()` methods of the `AnimationState`.

```ts
// Create animation clip
const clipSwim = new AnimationState("swim")

// Start playing the clip
clipSwim.play()

// Pause the playing of the clip
clipSwim.pause()
```

The `play()` function on an `AnimationState` object has one optional parameter:

- `reset`: If true, it always plays the animation from the start. Default: _false_.

```ts
clipSwim.play(true)
```

The following table summarizes how `play()` behaves, using different values for the `reset` property:

|                            | `reset` = _false_ (default)     | `reset` = _true_      |
| -------------------------- | ------------------------------- | --------------------- |
| **Currently playing**      | Has no effect.                  | Plays from the start. |
| **Paused**                 | Resumes from last frame played. | Plays from the start. |
| **Finished (Non-looping)** | Plays from the start.           | Plays from the start. |

You can also play an animation from the `Animator` component of an entity.

```ts
shark.getComponent(Animator).play(clipSwim)
```

When calling the `play()` function on the Animator component, there are two parameters to set:

- `clip`: An AnimationState object to play
- `reset`:_(optional)_ If true, it always plays the animation plays from the start. Default: _false_.

## Looping animations

By default, animations are played in a loop that keeps repeating the animation forever.

Change this setting by setting the `looping` property in the `AnimationState` object.

```ts
// Create animation clip
const biteClip = new AnimationState("bite")

// Set loop to false
biteClip.looping = false

// Start playing the clip
biteClip.play()
```

If `looping` is set to _false_, the animation plays just once and then stops.

## Reset an animation

When an animation finishes playing or is paused, the 3D model remains in the last posture it had.

To stop an animation and set the posture back to the first frame in the animation, use the `stop()` function of the `AnimationState` object.

```ts
clipSwim.stop()
```

To play an animation from the start, regardless of what frame the animation is currently in, set the `reset` property on the `play()` function to _true_.

```ts
clipSwim.play(true)
```

> Note: Resetting the posture is an abrupt change. If you want to make the model transition smoothly tinto another posture, you can either:

    - apply an animation with a `weight` property of 0 and gradually increase the `weight`
    - create an animation clip that describes a movement from the posture you want to transition from to the default posture you want.

## Handle multiple animations

If a 3D model has multiple animations packed into it, a single `Animator` component can deal with all of them.

Animations exist in _layers_ in an `Animator` component. If two animations are in the same layer, only one of them can play at a time. Starting one will stop the other. If two animations exist on separate layers, they can play at the same time, given that their _weight_ values add up, or if they each control different bones or vertexes from the model.

```ts
let shark = new Entity()
shark.addComponent(new GLTFShape("models/shark.gltf"))

// Create animator component
let animator = new Animator()

// Add animator component to the entity
shark.addComponent(animator)

// Crete animation state objects
const clipSwim = new AnimationState("swim", { layer: 0 })
const biteClip = new AnimationState("bite", { layer: 1 })

// Add animation state objects to the Animator component
shark.getComponent(Animator).addClip(clipSwim)
shark.getComponent(Animator).addClip(biteClip)

clipSwim.play()
biteClip.play()

engine.addEntity(shark)
```

In the example above, two animations are handled by separate `AnimationState` objects, and they are then both assigned to the same `Animator` component.

> Note: If the layer of an animation isn't specified, it's assigned to layer 0.

Each bone in an animation can only be affected by one animation at a time, unless these animations have a `weight` that adds up to a value of 1 or less.

If one animation only affects a character's legs, and another only affects a character's head, then they can be played at the same time without any issue. But if they both affect the character's legs, then you must either only play one at a time, or play them with lower `weight` values.

If in the above example, the `bite` animation only affects the shark's mouth, and the `swim` animation only affects the bones of the shark's spine, then they can both be played at the same time if they're on separate layers.

## Animation speed

Change the speed at which an animation is played by changing the `speed` property. The value of the speed is 1 by default.

```ts
// Create animation clip
const clipSwim = new AnimationState("swim")

// Set speed to twice as fast
clipSwim.speed = 2

// Start playing the clip
clipSwim.play()
```

Set the speed lower than 1 to play it slower, for example to 0.5 to play it at half the speed. Set it higher than 1 to play it faster, for example to 2 to play it at double the speed.

## Animation weight

The `weight` property allows a single model to carry out multiple animations on different layers at once, calculating a weighted average of all the movements involved in the animation. The value of `weight` determines how much importance that animation will be given in the average.

By default, `weight` is equal to _1_, it can't be any higher than _1_.

```ts
// Create animation clip
const clipSwim = new AnimationState("swim")

// Set weight
clipSwim.weight = 0.5

// Start playing the clip
clipSwim.play()
```

The `weight` value of all active animations in an entity should add up to 1 at all times. If it adds up to less than 1, the weighted average will be using the default position of the armature for the remaining part of the calculation.

```ts
const clipSwim = new AnimationState("swim")
clipSwim.weight = 0.2

animator.addClip(clipSwim)

clipSwim.play()
```

For example, in the code example above, we're playing the _swim_ animation, that only has a `weight` of _0.2_. This swimming movement will be quite subtle: only 20% of the intensity that the animation defines. The remaining 80% of the calculation takes values from the default posture of the armature.

The `weight` property can be used in interesting ways, for example the `weight` property of _swim_ could be set in proportion to how fast the shark is swimming, so you don't need to create multiple animations for fast and slow swimming.

You could also change the `weight` value gradually when starting and stopping an animation to give it a more natural transition and to avoid jumps from the default pose to the first pose in the animation.

> Note: The added `weight` value of all animations that are acting on a 3D model's bone can't be more than 1. If more than one animation is affecting the same bones at the same time, they need to have their weight set to values that add to less than 1.

## Set clip parameters in bulk

Use the `setParams()` function of the `AnimationState` object to set multiple parameters at once.

You can configure the following parameters:

- `playing`: Boolean to determine if the animation is currently being played.
- `looping`: Boolean to determine if the animation is played in a continuous loop.
- `speed`: A number that determines how fast the animation is played.
- `layer`: The layer of the animation. To play multiple animations at once, they must be on separate layers in the `Animator` component. By default, animations are added to layer 0.
- `weight`: Used to blend animations using weighted average.

```ts
const clipSwim = new AnimationState("swim")

clipSwim.setParams({
  playing: true,
  looping: true,
  speed: 2,
  layer: 1,
  weight: 0.5,
})
```

## Animations on shared shapes

You can use a same instance of a `GLTFShape` component on multiple entities to save resources. If each entity has both its own `Animator` component and its own `AnimationState` objects, then they can each be animated independently.

```ts
//create entities
let shark1 = new Entity()
let shark2 = new Entity()

// create reusable shape component
let sharkShape = new GLTFShape("models/shark.gltf")

// Add the same GLTFShape instance to both entities
shark1.addComponent(sharkShape)
shark2.addComponent(sharkShape)

// Create separate animator components
let animator1 = new Animator()
let animator2 = new Animator()

// Add separate animator components to the entities
shark1.addComponent(animator1)
shark2.addComponent(animator2)

// Instance separate animation clip objects
const clipSwim1 = new AnimationState("swim")
const clipSwim2 = new AnimationState("swim")

// Add animation clips to Animator components
animator1.addClip(clipSwim1)
animator2.addClip(clipSwim2)

engine.addEntity(shark1)
engine.addEntity(shark2)
```

> Note: If you define a single `AnimationState` object instance and add it to multiple `Animator` components from different entities, all entities using the `AnimationState` instance will be animated together at the same time.

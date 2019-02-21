---
date: 2018-02-13
title: 3D model animations
description: How to move and animate entities in your scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 13
---

3D models in _.glTF_ and _.glb_ format can include as many animations as you want in them. Animations tell the mesh how to move, by specifying a series of _keyframes_ that are laid out over time, the mesh then blends from one pose to the other to simulate continuous movement. 

Most 3D model animations are [_skeletal animations_](https://en.wikipedia.org/wiki/Skeletal_animation). These animations simplify the complex geometry of the model into a "stick figure", linking every vertex in the mesh to the closest _bone_ in the _skeleton_. Modelers adjust the skeleton into different poses, and the mesh stretches and bends to follow these movements.

As an alternative, _vertex animations_ animate a model without the need of a skeleton. These animations specify the position of each vertex in the model directly. Decentraland supports these animations as well.

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for details on how to create animations for a 3D model. Read [Shape components]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}) for instructions on how to import a 3D model to a scene.

> Tip: Animations are usually better for moving something in place, not for changing the position of an entity. For example, you can set an animation to move a character's feet in place, but to change the location of the entity it's best to use the Transform component. See [Positioning entities]({{ site.baseurl }}{% post_url /development-guide/2018-02-12-move-entities %}) for more details.

## Check a 3D model for animations

Not all _glTF_ files include animations. To see if there are any available, you can do the following:

- If using [VS Code](https://code.visualstudio.com/)(recommended), install the _GLTF Tools_ extension and view the contents of a glTF file there.
- Open the [Babylon Sandbox](https://sandbox.babylonjs.com/) site and drag the glTF file (and any _.jpg_ or _.bin_ dependencies) to the browser.
- Open the _.glTF_ file with a text editor and scroll down till you find _"animations":_.

> Tip: In _skeletal_ animations, an animation name is often comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

## Add animations

An `Animator` component manages all the animations of the entity. Each animation is handled by an `AnimationClip` object.


![](/images/media/ecs-animations.png)

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
const clipSwim = new AnimationClip("swim")

// Add animation clip to Animator component
animator.addClip(clipSwim)
```

You can also achieve the same with less statements:

```ts
// Create and add animator component
shark.addComponent(new Animator())

// Instance and add a clip
shark.getComponent(Animator).addClip(new AnimationClip("swim"))
```

You can retrieve an `AnimationClip` object from an `Animator` component with the `getClip()` function. 

```ts
// Create and get a clip
let clipSwim = animator.getClip("swim")
```

The `AnimationClip` object doesn't store the actual transformations that go into the animation, that's all in the .glTF file. Instead, the `AnimationClip` object has a state that keeps track how far it has advanced along the animation. 

## Fetch an animation


If you don't have a pointer to refer to the clip object directly, you can fetch a clip from the `Animator` by name using `getClip()`.

```ts
// Create and add a clip
shark.getComponent(Animator).addClip(new AnimationClip("swim"))

// Fetch the clip
shark.getComponent(Animator).getClip("swim")
```

<!--
... which one is true?

> Note: If you attempt to use `getClip()` to fetch a clip that doesn't exist in the Animator component, it returns `null`.

If you try to get an `AnimationClip` that was never added to the `Animator` component, the clip is created and added automatically.
-->

## Play an animation

When an `AnimationClip` is created, it starts as paused by default.

The simplest way to play or pause it is to use the `play()` and `pause()` methods of the `AnimationClip`.

```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Start playing the clip
clipSwim.play()

// Pause the playing of the clip
clipSwim.pause()
```

The `AnimationClip` object also has a `playing` boolean parameter. You can start or stop the animation by changing the value of this parameter.

```ts
clipSwim.playing = true
```

## Looping animations

By default, animations are played in a loop that keeps repeating the animation forever.

Change this setting by setting the `looping` property in the `AnimationClip` object.

```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Set loop to false
clipSwim.looping = false

// Start playing the clip
clipSwim.play()
```

If `looping` is set to _false_, the animation plays just once and then stops.


## Play an animation once

Trigger an animation to play only once by using the `playOnce()` function of the `AnimationClip` object. When the animation finishes playing, the 3D model will remain in the final posture of the animation.

If the animation was already playing, the `playOnce()` function disables looping and resets the animation to play one more time from the start.

```ts

```

## Reset a model's posture

When an animation finishes playing or is interrupted, the 3D model remains in the last posture it had. If you want the model to return to the first posture in the animation and stay there, you can reset the animation clip.

To do this, use the `reset()` function of the `AnimationClip` object.

```ts


```

> Note: Resetting the posture is an abrupt change. If you want to make the model transition smoothly tinto the default posture, create an animation clip (in an external modeling tool) that describes a movement from the posture you want to transition from to the default posture you want.


## Animation speed

Change the speed at which an animation is played by changing the `speed` property. The value of the speed is 1 by default. 


```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Set speed to twice as fast
clipSwim.speed = 2

// Start playing the clip
clipSwim.play()
```

Set the speed lower than 1 to play it slower, for example to 0.5 to play it at half the speed. Set it higher than 1 to play it faster, for example to 2 to play it at double the speed.

## Animation weight

The `weight` property allows a single model to carry out multiple animations at once, calculating a weighted average of all the movements involved in the animation. The value of `weight` determines how much importance that animation will be given in the average. 

By default, `weight` is equal to _1_, it can't be any higher than _1_.


```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Set weight
clipSwim.weight = 0.5

// Start playing the clip
clipSwim.play()
```

The `weight` value of all active animations in an entity should add up to 1 at all times. If it adds up to less than 1, the weighted average will be using the default position of the armature for the remaining part of the calculation.

```ts
const clipSwim = new AnimationClip("swim")
clipSwim.weight = 0.2

animator.addClip(clipSwim)

clipSwim.play()
```

For example, in the code example above, we're playing the _swim_ animation, that only has a `weight` of _0.2_. This swimming movement will be quite subtle: only 20% of what the animation defines. The remaining 80% of the calculation takes values from the default posture of the armature.

The `weight` property can be used in interesting ways, for example the `weight` property of _swim_ could be set in proportion to how fast the shark is swimming, so you don't need to create multiple animations for fast and slow swimming.

You could also change the `weight` value gradually when starting and stopping an animation to give it a more natural transition and to avoid jumps from the default pose to the first pose in the animation.

## Set clip parameters in bulk

Use the `setParams()` function of the `AnimationClip` object to set multiple parameters at once.

You can configure the following parameters:

- `playing`: Boolean to determine if the animation is currently being played.
- `looping`: Boolean to determine if the animation is played in a continuous loop.
- `speed`: A number that determines how fast the animation is played.
- `weight`: Used to blend animations using weighted average.


```ts
const clipSwim = new AnimationClip("swim")

clipSwim.setParams({playing:true, looping:true, speed: 2, weight: 0.5})
```

## Animations on shared shapes

You can use a same instance of a `GLTFShape` component on multiple entities to save resources. If each entity has both its own `Animator` component and its own `AnimationClip` objects, then they can each be animated independently.

If you define a single `AnimationClip` object instance and add it to multiple `Animator` components from different entities, all entities using the `AnimationClip` instance will be animated together at the same time.

```ts
//create entities
let shark1 = new Entity()
let shark2 = new Entity()

// create reusable shape component
let sharkShape = new GLTFShape('models/shark.gltf')

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
const clipSwim1 = new AnimationClip("swim")
const clipSwim2 = new AnimationClip("swim")

// Add animation clips to Animator components
animator1.addClip(clipSwim1)
animator2.addClip(clipSwim2)

engine.addEntity(shark1)
engine.addEntity(shark2)
```

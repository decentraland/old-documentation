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

3D models in _.glTF_ and _.glb_ format can include as many animations as you want in them. Animations tell the mesh how to move, by specifying a series of poses that are laid out over time, the mesh then blends from one pose to the other to simulate continuous movement. 

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for details on how to create models and animations for them. Read [Shape components]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}) for instructions on how to import a 3D model to a scene.

> Tip: Animations are more suited for moving in place, not to change the position of an entity in the scene. For example, can set an animation to move a character's feet in place, but to change the location of the entity use the Transform component. See [Positioning entities]({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %}) for more details.

## Check a 3D model for animations

Not all _glTF_ files include animations. To see if there are any available, you can do the following:

- If using [VS Code](https://code.visualstudio.com/)(recommended), install the _GLTF Tools_ extension and view the contents of a glTF file there.
- Open the [Babylon Sandbox](https://sandbox.babylonjs.com/) and drag the glTF file (and any _.jpg_ or _.bin_ dependencies) there.
- Open the _.glTF_ file with a text editor and scroll down till you find _"animations":_.

Typically, an animation name is comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

## Instance and add an animation clip

To use one of the animations in a 3D model, you must create an `AnimationClip` object and add it to a `GLTFShape` component.

![](/images/media/ecs-animations.png)

```ts
let shark = new Entity()
shark.add(new GLTFShape("models/shark.gltf"))

// Instance animation clip
const clipSwim = new AnimationClip("swim")

// Add animation clip to GLTFShape component
shark.get(GLTFShape).addClip(clipSwim)
```

You can also create and add an `AnimationClip` in a single statement:

```ts
// Instance and add a clip
shark.get(GLTFShape).addClip(new AnimationClip("swim"))

// Retrieve a clip that was added to a component
let swim = swim.get(GLTFShape).getClip("swim")
```

The steps of creating and adding an `AnimationClip` can also be avoided. If you try to get an `AnimationClip` that was never added to the component, the clip is created and added automatically:

```ts
// Create and get a clip
let swim = swim.get(GLTFShape).getClip("swim")
```

Each instance of an `AnimationClip` object has a state of its own that keeps track how far it has advanced along the animation. If you add a same `AnimationClip` instance to multiple `GLTFShape` components from different entities, they will all reference this same state. This means that if you play the clip, all entities using the instance will be animated together at the same time.

If you want to independently animate several entities using a same animation, you must instance multiple an `AnimationClip` objects, one for each entity using it.

```ts
// Create an entity
let shark1 = new Entity()
shark1.add(new GLTFShape("models/shark.gltf"))

// Instance and add a clip
shark1.get(GLTFShape).addClip(new AnimationClip("swim"))

// Create a second entity
let shark2 = new Entity()
shark2.add(new GLTFShape("models/shark.gltf"))

// Instance and add a new clip
shark2.get(GLTFShape).addClip(new AnimationClip("swim"))
```

## Play an animation

Once an an `AnimationClip` is added to a `GLTFShape` component, it starts out as paused by default.

The simplest way to play or pause it is to use the `play()` and `pause()` methods of the `AnimationClip`.

```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Start playing the clip
clipSwim.play()

// Pause the playing of the clip
clipSwim.pause()
```

If your scene's code doesn't have a pointer to refer to the clip object directly, you can fetch a clip from the `GLTFShape` by name using `getClip()`.

```ts
// Create and add clip
shark.get(GLTFShape).addClip(new AnimationClip("swim"))

// Start playing the clip
shark
  .get(GLTFShape)
  .getClip("swim")
  .play()

// Pause the playing of the clip
shark
  .get(GLTFShape)
  .getClip("swim")
  .pause()
```

> Note: If you attempt to use `getClip()` to fetch a clip that doesn't exist in the component, it returns `null`.

The `AnimationClip` object also has a `playing` boolean parameter. You can start or stop the animation by changing the value of this parameter.

```ts
clipSwim.playing = true
```

## Set clip parameters

You can configure the following parameters for an `AnimationClip`:

- `loop`: Boolean to determine if the animation is played in a continuous loop. If set to _false_, the animation plays just once and stops.
- `playing`: Boolean to determine if the animation is currently being played.
- `speed`: A number that determines how fast the animation is played, by default equal to _1_. Set it higher or lower to make the animation play faster or slower.
- `weight`: Allows a single model to carry out multiple animations at once, calculating a weighted average of all the movements involved in the animation. The value of `weight` determines how much importance that animation will be given in the average. By default equal to _1_, it can't be any higher than _1_.

When creating an `AnimationClip`, the constructor has a second optional parameter to pass all the values for the clip's parameters as an object:

```ts
const clipSwim = new AnimationClip("swim", {
  loop: true,
  speed: 3,
  weight: 0.2
})
```

You can also modify the parameters of an existing `AnimationClip`, by using the `setParams()` function and passing an object with the parameter values you want to change:

```ts
clipSwim.setParams({ loop: true, speed: 3, weight: 0.2 })
```

#### About the weight parameter

The `weight` value of all active animations should add up to 1 at all times. If it adds up to less than 1, the weighted average will be referencing the default position of the armature for the remaining part of the calculation.

```ts
const clipSwim = new AnimationClip("swim", {
  weight: 0.2
})
const clipBite = new AnimationClip("bite", {
  weight: 0.8
})
shark.get(GLTFShape).addClip(clipSwim)
shark.get(GLTFShape).addClip(clipBite)

clipSwim.play()
```

For example, in the code example above, we're only playing the _swim_ animation, that has a `weight` of _0.2_. In this case the swimming movement is quite subtle: only 20% of what the animation says it should move. The other 80% of what's being averaged to get the final armature position is the default posture of the armature.

The `weight` property can be used in interesting ways, for example the `weight` property of _swim_ could be set in proportion to how fast the shark is swimming, so you don't need to create multiple animations for fast and slow swimming.

You could also change the `weight` value gradually when starting and stopping an animation to give it a more natural transition and avoid jumps from the default pose to the first pose in the animation.

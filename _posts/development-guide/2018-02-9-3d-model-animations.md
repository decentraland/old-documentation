---
date: 2018-02-9
title: 3D model animations
description: How to move and animate entities in your scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 2
---

3D models in _.glTF_ and _.glb_ format can include as many animations as you want in them. Animations tell the mesh how to move, by specifying a series of poses that are laid out over time, the mesh then blends from one pose to the other to simulate continuous movement. See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for details on how to create models and animations for them. Read [Shape components]() for instructions on how to import a 3D model to a scene.

> Tip: Animations are more suited for moving in place, not to change the position of an entity in the scene. For example, can set an animation to move a character's feet in place, but to change the location of the entity use the Transform component. See [Positioning entities]() for more details.

## Check a 3D model for animations

Not all _glTF_ files include animations. To see if there are any available, you can do the following:

- If using [VS Code](https://code.visualstudio.com/)(recommended), install the _GLTF Tools_ extension and view the contents of a glTF file there.
- Open the [Babylon Sandbox](https://sandbox.babylonjs.com/) and drag the glTF file (and any _.jpg_ or _.bin_ dependencies) there.
- Open the _.glTF_ file with a text editor and scroll down till you find _"animations":_.

Typically, an animation name is comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

## Add an animation clip

To use an animation, you must first add it to a `GLTFShape` component. This step is needed even when the animation is already embedded in the _.glTF_ file.

```ts
let shark = new Entity()
shark.set(new GLTFShape("models/shark.gltf"))

// Create animation clip
const clipSwim = new AnimationClip("swim", { speed: 1 })

// Add animation clip to GLTFShape component
shark.get(GLTFShape).addClip(clipSwim)
```

You can also create and add a clip in a single statement:

```ts
shark.get(GLTFShape).addClip(new AnimationClip("swim", { speed: 1 }))
```

## Play an animation

Once an animation clip is added to a _GLTFShape_ component, it starts out as paused by default.

The simplest way to play or pause it is to use the `play()` and `pause()` methods of the `AnimationClip`.

```ts
// Create animation clip
const clipSwim = new AnimationClip("swim", { speed: 1 })

// Start playing the clip
clipSwim.play()

// Pause the playing of the clip
clipSwim.pause()
```

If your scene's code doesn't have a pointer to refer to the clip object directly (for example if you created and assigned the clip in a single statement) you can fetch a clip from the GLTFShape by name using `getClip()`.

```ts
// Create and add clip
shark.get(GLTFShape).addClip(new AnimationClip("swim", { speed: 1 }))

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

## Set a clip's parameters

You can configure the following parameters for an animation clip:

- `loop`: Boolean to determine if the animation is played in a continuous loop. If set to _false_, the animation plays just once and stops.
- `playing`: Boolean to determine if the animation is currently being played.
- `speed`: A number that determines how fast the animation is played, by default equal to _1_. Set it higher or lower to make the animation play faster or slower.
- `weight`: Allows a single model to carry out multiple animations at once, calculating a weighted average of all the movements involved in the animation. The value of `weight` determines how much importance that animation will be given in the average. By default equal to _1_, it can't be any higher than _1_.

These parameters can all be set when creating the clip:

```ts
const clipSwim = new AnimationClip("swim", {
  loop: true,
  speed: 3,
  weight: 0.2
})
```

You can also modify the parameters of an existing clip:

```ts
clipSwim.setParams({ loop: true, speed: 3, weight: 0.2 })
```

The `weight` value of all active animations should add up to 1 at all times. If it adds up to less than 1, the weighted average will be referencing the default position of the armature for the remaining part of the calculation.

For example, in the code example above, if only the _swim_ animation is playing and has a `weight` of _0.2_, then the swimming movement is quite subtle, only 20% of what the animation says it should move. The other 80% of what's averaged represents the default position of the armature.

The `weight` property can be used in interesting ways, for example the `weight` property of _swim_ could be set in proportion to how fast the shark is swimming, so you don't need to create multiple animations for fast and slow swimming.

You could also change the `weight` value gradually when starting and stopping an animation to give it a more natural transition and avoid jumps from the default position to the first pose in the animation if these are different.

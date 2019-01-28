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

Most 3D model animations are [_skeletal animations_](https://en.wikipedia.org/wiki/Skeletal_animation), where the complex geometry of the model is simplified into a "stick figure". Modelers shift the skeleton frame into different poses, and the position of each vertex is calculated based on that of its closest _bone_.

You can also use _vertex animations_ to animate a model without the need of a skeleton. These animations specify the position of each vertex in the model directly.

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for details on how to create models and animations for them. Read [Shape components]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}) for instructions on how to import a 3D model to a scene.

> Tip: Animations are more suited for moving in place, not to change the position of an entity in the scene. For example, you can set an animation to move a character's feet in place, but to change the location of the entity it's best to use the Transform component. See [Positioning entities]({{ site.baseurl }}{% post_url /development-guide/2018-02-12-move-entities %}) for more details.

## Check a 3D model for animations

Not all _glTF_ files include animations. To see if there are any available, you can do the following:

- If using [VS Code](https://code.visualstudio.com/)(recommended), install the _GLTF Tools_ extension and view the contents of a glTF file there.
- Open the [Babylon Sandbox](https://sandbox.babylonjs.com/) and drag the glTF file (and any _.jpg_ or _.bin_ dependencies) there.
- Open the _.glTF_ file with a text editor and scroll down till you find _"animations":_.

> Tip: In _skeletal_ animations, an animation name is typically comprised of its armature name, an underscore and its animation name. For example `myArmature_animation1`.

## Add animations

An `Animator` component handles all the animations of the entity. Each animation is stored as an `AnimationClip` object.


![](/images/media/ecs-animations.png)

```ts
// Create entity
let shark = new Entity()

// Add a 3D model to it
shark.add(new GLTFShape("models/shark.gltf"))

// Create animator component
let animator = new Animator()

// Add animator component to the entity
shark.add(animator)

// Instance animation clip object
const clipSwim = new AnimationClip("swim")

// Add animation clip to Animator component
animator.addClip(clipSwim)
```

You can also achieve the same with less statements:

```ts
// Create and add animator component
shark.add(new Animator())

// Instance and add a clip
shark.get(Animator).addClip(new AnimationClip("swim"))
```

You can retrieve an `AnimationClip` object from an `Animator` component with the `getClip()` function. 

```ts
// Create and get a clip
let swim = animator.getClip("swim")
```

If you try to get an `AnimationClip` that was never added to the component, the clip is created and added automatically.

Each instance of an `AnimationClip` object has a state of its own that keeps track how far it has advanced along the animation. 

The object doesn't store the actual transformations that go into the animation, that's all in the .glTF file.


## Play an animation

Once an an `AnimationClip` is added to a `Animator` component, it starts out as paused by default.

The simplest way to play or pause it is to use the `play()` and `pause()` methods of the `AnimationClip`.

```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Start playing the clip
clipSwim.play()

// Pause the playing of the clip
clipSwim.pause()
```

If your scene's code doesn't have a pointer to refer to the clip object directly, you can fetch a clip from the `Animator` by name using `getClip()`.

```ts
// Create and add clip
shark.get(Animator).addClip(new AnimationClip("swim"))

// Start playing the clip
shark
  .get(Animator)
  .getClip("swim")
  .play()

// Pause the playing of the clip
shark
  .get(Animator)
  .getClip("swim")
  .pause()
```

> Note: If you attempt to use `getClip()` to fetch a clip that doesn't exist in the Animator component, it returns `null`.

The `AnimationClip` object also has a `playing` boolean parameter. You can start or stop the animation by changing the value of this parameter.

```ts
clipSwim.playing = true
```

## Looping animations

Animations are played forever in a loop by default.

Change this setting by setting the `loop` property in the `AnimationClip` object.

```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Set loop to false
clipSwim.loop = false

// Start playing the clip
clipSwim.play()
```

If `loop` is set to _false_, the animation plays just once and stops.

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

Set the speed lower than 1 to play it slower, set it higher than 1 to play it faster.

## Animation weight

The `weight` property allows a single model to carry out multiple animations at once, calculating a weighted average of all the movements involved in the animation. The value of `weight` determines how much importance that animation will be given in the average. 

By default, `weight` is equal to _1_, it can't be any higher than _1_.


```ts
// Create animation clip
const clipSwim = new AnimationClip("swim")

// Set speed to twice as fast
clipSwim.weight = 0.5

// Start playing the clip
clipSwim.play()
```

The `weight` value of all active animations in an entity should add up to 1 at all times. If it adds up to less than 1, the weighted average will be using the default position of the armature for the remaining part of the calculation.

```ts
const clipSwim = new AnimationClip("swim")
clipSwim.weight = 0.2
const clipBite = new AnimationClip("bite")
clipBite.weight = 0.8

shark.get(Animator).addClip(clipSwim)
shark.get(Animator).addClip(clipBite)

clipSwim.play()
```

For example, in the code example above, we're only playing the _swim_ animation, that has a `weight` of _0.2_. In this case the swimming movement is quite subtle: only 20% of what the animation defines. The remaining 80% of the calculation takes values from the default posture of the armature.

The `weight` property can be used in interesting ways, for example the `weight` property of _swim_ could be set in proportion to how fast the shark is swimming, so you don't need to create multiple animations for fast and slow swimming.

You could also change the `weight` value gradually when starting and stopping an animation to give it a more natural transition and avoid jumps from the default pose to the first pose in the animation.

## Set clip parameters in bulk

Use the `setParams()` function of the `AnimationClip` object to set multiple parameters in one statement.


You can configure the following parameters for an `AnimationClip`:

- `playing`: Boolean to determine if the animation is currently being played.
- `loop`: Boolean to determine if the animation is played in a continuous loop.
- `speed`: A number that determines how fast the animation is played, _1_ by default.
- `weight`: Used to blend animations using weighted average.



```ts
const clipSwim = new AnimationClip("swim")

clipSwim.setParams({playing:true, looping:true, speed: 2, weight: 0.5})
```


## Reuse shapes instead of animations

You can use a same instance of a `GLTFShape` component on multiple entities to save resources. If each entity has its own `Animator` component and its own `AnimationClip` objects, then they can move independently.

If you add a same `AnimationClip` instance to multiple `Animator` components from different entities, they will all reference this same state. This means that if you play the clip, all entities using the instance will be animated together at the same time.

If you want to independently animate several entities using a same animation, you must instance multiple `AnimationClip` objects, one for each entity using it.

```ts
//create entities
let shark1 = new Entity()
let shark2 = new Entity()

// create reusable shape component
let sharkShape = new GLTFShape('models/shark.gltf')

// Add the same GLTFShape instance to both entities
shark1.add(sharkShape)
shark2.add(sharkShape)

// Create separate animator components
let animator1 = new Animator()
let animator2 = new Animator()

// Add separate animator components to the entities
shark1.add(animator1)
shark2.add(animator2)

// Instance separate animation clip objects
const clipSwim1 = new AnimationClip("swim")
const clipSwim2 = new AnimationClip("swim")

// Add animation clips to Animator components
animator1.addClip(clipSwim1)
animator2.addClip(clipSwim2)

engine.addEntity(shark1)
engine.addEntity(shark2)
```

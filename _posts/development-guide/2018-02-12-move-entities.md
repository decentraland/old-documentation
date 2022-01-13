---
date: 2018-02-12
title: Move entities
description: How to move, rotate and scale an entity gradually over time, with incremental changes.
categories:
  - development-guide
type: Document
---

To move, rotate or resize an entity in your scene, change the _position_, _rotation_ and _scale_ values stored in an entity's `Transform` component incrementally, frame by frame. This can be used on primitive shapes (cubes, spheres, planes, etc) as well as on 3D models (glTF).

You can easily perform these incremental changes by moving entities a small amount each time the `update()` function of a [system]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) is called.

> Tip: You can use the helper functions in the [utils library](https://www.npmjs.com/package/decentraland-ecs-utils) to achieve most of the tasks described in this doc. The code shown in these examples is handled in the background by the library, so in most cases it only takes a single line of code to use them.

## Move

The easiest way to move an entity is to use the `translate()` function to change the _position_ value stored in the `Transform` component.

```ts
export class SimpleMove implements ISystem {
  update() {
    let transform = myEntity.getComponent(Transform)
    let distance = Vector3.Forward().scale(0.1)
    transform.translate(distance)
  }
}

engine.addSystem(new SimpleMove())

const myEntity = new Entity()
myEntity.addComponent(new Transform())
myEntity.addComponent(new BoxShape())

engine.addEntity(myEntity)
```

In this example we're moving an entity by 0.1 meters per frame.

`Vector3.Forward()` returns a vector that faces forward and measures 1 meter in length. In this example we're then scaling this vector down to 1/10 of its length with `scale()`. If our scene has 30 frames per second, the entity is moving at 3 meters per second in speed.

 <img src="{{ site.baseurl }}/images/media/gifs/move.gif" alt="Move entity" width="300"/>

## Rotate

The easiest way to rotate an entity is to use the `rotate()` function to change the values in the Transform component incrementally, and run this as part of the `update()` function of a system.

The `rotate()` function takes two arguments:

- The direction in which to rotate (as a _Vector3_)
- The amount to rotate, in [euler](https://en.wikipedia.org/wiki/Euler_angles) degrees (from 0 to 360)

```ts
export class SimpleRotate implements ISystem {
  update() {
    let transform = myEntity.getComponent(Transform)
    transform.rotate(Vector3.Left(), 3)
  }
}

engine.addSystem(new SimpleRotate())

const myEntity = new Entity()
myEntity.addComponent(new Transform())
myEntity.addComponent(new BoxShape())

engine.addEntity(myEntity)
```

> Tip: To make an entity always rotate to face the player, you can add a [`Billboard` component]({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %}#face-the-user).

 <img src="{{ site.baseurl }}/images/media/gifs/rotate.gif" alt="Move entity" width="300"/>

## Rotate over a pivot point

When rotating an entity, the rotation is always in reference to the entity's center coordinate. To rotate an entity using another set of coordinates as a pivot point, create a second (invisible) entity with the pivot point as its position and make it a parent of the entity you want to rotate.

When rotating the parent entity, its children will be all rotated using the parent's position as a pivot point. Note that the `position` of the child entity is in reference to that of the parent entity.

```ts
// Create entity you wish to rotate
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

// Create the pivot entity
const pivot = new Entity()

// Position the pivot entity on the pivot point of the rotation
pivot.addComponent(
  new Transform({
    position: new Vector3(3, 2, 3),
  })
)

// add pivot entity
engine.addEntity(pivot)

// Set pivot as the parent
myEntity.setParent(pivot)

// Position child in reference to parent
myEntity.addComponent(
  new Transform({
    position: new Vector3(0, 0.5, 0.5),
  })
)

// Define a system that updates the rotation on every frame
export class PivotRotate implements ISystem {
  update() {
    let transform = pivot.getComponent(Transform)
    transform.rotate(Vector3.Left(), 3)
  }
}

// Add the system
engine.addSystem(new PivotRotate())
```

Note that in this example, the system is rotating the `pivot` entity, that's a parent of the `door` entity.

 <img src="{{ site.baseurl }}/images/media/gifs/pivot-rotate.gif" alt="Move entity" width="300"/>

> Note: Child entities should not be explicitly added to the engine, as they are already added via their parent entity.

## Adjust movement to delay time

Suppose that the player visiting your scene is struggling to keep up with the pace of the frame rate. That could result in the movement appearing jumpy, as not all frames are evenly timed but each moves the entity in the same amount.

You can compensate for this uneven timing by using the `dt` parameter to adjust the scale the movement.

```ts
export class SimpleMove implements ISystem {
  update(dt: number) {
    let transform = myEntity.getComponent(Transform)
    let distance = Vector3.Forward.scale(dt * 3)
    transform.translate(distance)
  }
}
// (...)
```

The example above keeps movement at approximately the same speed as the movement example above, even if the frame rate drops. When running at 30 frames per second, the value of `dt` is 1/30.

You can also smoothen rotations in the same way by multiplying the rotation amount by `dt`.

## Move between two points

If you want an entity to move smoothly between two points, use the _lerp_ (linear interpolation) algorithm. This algorithm is very well known in game development, as it's really useful.

The `lerp()` function takes three parameters:

- The vector for the origin position
- The vector for the target position
- The amount, a value from 0 to 1 that represents what fraction of the translation to do.

```ts
const originVector = Vector3.Zero()
const targetVector = Vector3.Forward()

let newPos = Vector3.Lerp(originVector, targetVector, 0.6)
```

The linear interpolation algorithm finds an intermediate point in the path between both vectors that matches the provided amount.

For example, if the origin vector is _(0, 0, 0)_ and the target vector is _(10, 0, 10)_:

- Using an amount of 0 would return _(0, 0, 0)_
- Using an amount of 0.3 would return _(3, 0, 3)_
- Using an amount of 1 would return _(10, 0, 10)_

To implement this `lerp()` in your scene, we recommend creating a custom component to store the necessary information. You also need to define a system that implements the gradual movement in each frame.

```ts
@Component("lerpData")
export class LerpData {
  origin: Vector3 = Vector3.Zero()
  target: Vector3 = Vector3.Zero()
  fraction: number = 0
}

// a system to carry out the movement
export class LerpMove implements ISystem {
  update(dt: number) {
    let transform = myEntity.getComponent(Transform)
    let lerp = myEntity.getComponent(LerpData)
    if (lerp.fraction < 1) {
      transform.position = Vector3.Lerp(lerp.origin, lerp.target, lerp.fraction)
      lerp.fraction += dt / 6
    }
  }
}

// Add system to engine
engine.addSystem(new LerpMove())

const myEntity = new Entity()
myEntity.addComponent(new Transform())
myEntity.addComponent(new BoxShape())

myEntity.addComponent(new LerpData())
myEntity.getComponent(LerpData).origin = new Vector3(1, 1, 1)
myEntity.getComponent(LerpData).target = new Vector3(8, 1, 3)

engine.addEntity(myEntity)
```

 <img src="{{ site.baseurl }}/images/media/gifs/lerp-move.gif" alt="Move entity" width="300"/>

## Rotate between two angles

To rotate smoothly between two angles, use the _slerp_ (_spherical_ linear interpolation) algorithm. This algorithm is very similar to a _lerp_, but it handles quaternion rotations.

The `slerp()` function takes three parameters:

- The [quaternion](https://en.wikipedia.org/wiki/Quaternion) angle for the origin rotation
- The [quaternion](https://en.wikipedia.org/wiki/Quaternion) angle for the target rotation
- The amount, a value from 0 to 1 that represents what fraction of the translation to do.

> Tip: You can pass rotation values in [euler](https://en.wikipedia.org/wiki/Euler_angles) degrees (from 0 to 360) by using `Quaternion.Euler()`.

```ts
const originRotation = Quaternion.Euler(0, 90, 0)
const targetRotation = Quaternion.Euler(0, 0, 0)

let newRotation = Quaternion.Slerp(originRotation, targetRotation, 0.6)
```

To implement this in your scene, we recommend storing the data that goes into the `Slerp()` function in a custom component. You also need to define a system that implements the gradual rotation in each frame.

```ts
@Component("slerpData")
export class SlerpData {
  originRot: Quaternion = Quaternion.Euler(0, 90, 0)
  targetRot: Quaternion = Quaternion.Euler(0, 0, 0)
  fraction: number = 0
}

// a system to carry out the rotation
export class SlerpRotate implements ISystem {
  update(dt: number) {
    let slerp = myEntity.getComponent(SlerpData)
    let transform = myEntity.getComponent(Transform)
    if (slerp.fraction < 1) {
      let rot = Quaternion.Slerp(
        slerp.originRot,
        slerp.targetRot,
        slerp.fraction
      )
      transform.rotation = rot
      slerp.fraction += dt / 5
    }
  }
}

// Add system to engine
engine.addSystem(new SlerpRotate())

const myEntity = new Entity()
myEntity.addComponent(new Transform())
myEntity.addComponent(new BoxShape())

myEntity.addComponent(new SlerpData())
myEntity.getComponent(SlerpData).originRot = Quaternion.Euler(0, 90, 0)
myEntity.getComponent(SlerpData).targetRot = Quaternion.Euler(0, 0, 0)

engine.addEntity(myEntity)
```

> Note: You could instead represent the rotation with `Vector3` values and use a `Lerp()` function, but that would imply a conversion from `Vector3` to `Quaternion` on each frame. Rotation values are internally stored as quaternions in the `Transform` component, so it's more efficient to work with quaternions.

 <img src="{{ site.baseurl }}/images/media/gifs/lerp-rotate.gif" alt="Move entity" width="300"/>

## Change scale between two sizes

If you want an entity to change size smoothly and without changing its proportions, use the _lerp_ (linear interpolation) algorithm of the `Scalar` object.

Otherwise, if you want to change the axis in different proportions, use `Vector3` to represent the origin scale and the target scale, and then use the _lerp_ function of the `Vector3`.

The `lerp()` function of the `Scalar` object takes three parameters:

- A number for the origin scale
- A number for the target scale
- The amount, a value from 0 to 1 that represents what fraction of the scaling to do.

```ts
const originScale = 1
const targetScale = 10

let newScale = Scalar.Lerp(originScale, targetScale, 0.6)
```

To implement this lerp in your scene, we recommend creating a custom component to store the necessary information. You also need to define a system that implements the gradual scaling in each frame.

```ts
@Component("lerpData")
export class LerpSizeData {
  origin: number = 0.1
  target: number = 2
  fraction: number = 0
}

// a system to carry out the movement
export class LerpSize implements ISystem {
  update(dt: number) {
    let transform = myEntity.getComponent(Transform)
    let lerp = myEntity.getComponent(LerpSizeData)
    if (lerp.fraction < 1) {
      let newScale = Scalar.Lerp(lerp.origin, lerp.target, lerp.fraction)
      transform.scale.setAll(newScale)
      lerp.fraction += dt / 6
    }
  }
}

// Add system to engine
engine.addSystem(new LerpSize())

const myEntity = new Entity()
myEntity.addComponent(new Transform())
myEntity.addComponent(new BoxShape())

myEntity.addComponent(new LerpSizeData())
myEntity.getComponent(LerpSizeData).origin = 0.1
myEntity.getComponent(LerpSizeData).target = 2

engine.addEntity(myEntity)
```

 <img src="{{ site.baseurl }}/images/media/gifs/lerp-scale.gif" alt="Move entity" width="300"/>

## Move at irregular speeds between two points

While using the lerp method, you can make the movement speed non-linear. In the previous example we increment the lerp amount by a given amount each frame, but we could also use a mathematical function to increase the number exponentially or in other measures that give you a different movement pace.

You could also use a function that gives recurring results, like a sine function, to describe a movement that comes and goes.

```ts
@Component("lerpData")
export class LerpData {
  origin: Vector3 = Vector3.Zero()
  target: Vector3 = Vector3.Zero()
  fraction: number = 0
}

export class LerpMove implements ISystem {
  update(dt: number) {
    let transform = myEntity.getComponent(Transform)
    let lerp = myEntity.getComponent(LerpData)
    lerp.fraction += (dt + lerp.fraction) / 10
    transform.position = Vector3.Lerp(lerp.origin, lerp.target, lerp.fraction)
  }
}

// Add system to engine
engine.addSystem(new LerpMove())
```

The example above is just like the linear lerp example we've shown before, but the `fraction` field is increased in a non-linear way, resulting in a curve moves the entity by greater increments on each frame.

 <img src="{{ site.baseurl }}/images/media/gifs/lerp-speed-up.gif" alt="Move entity" width="300"/>

## Follow a path

A `Path3` object stores a series of vectors that describe a path. You can have an entity loop over the list of vectors, performing a lerp movement between each.

```ts
const point1 = new Vector3(1, 1, 1)
const point2 = new Vector3(8, 1, 3)
const point3 = new Vector3(8, 4, 7)
const point4 = new Vector3(1, 1, 7)

const myPath = new Path3D([point1, point2, point3, point4])

@Component("pathData")
export class PathData {
  origin: Vector3 = myPath.path[0]
  target: Vector3 = myPath.path[1]
  fraction: number = 0
  nextPathIndex: number = 1
}

export class PatrolPath implements ISystem {
  update(dt: number) {
    let transform = myEntity.getComponent(Transform)
    let path = myEntity.getComponent(PathData)
    if (path.fraction < 1) {
      transform.position = Vector3.Lerp(path.origin, path.target, path.fraction)
      path.fraction += dt / 6
    } else {
      path.nextPathIndex += 1
      if (path.nextPathIndex >= myPath.path.length) {
        path.nextPathIndex = 0
      }
      path.origin = path.target
      path.target = myPath.path[path.nextPathIndex]
      path.fraction = 0
    }
  }
}

engine.addSystem(new PatrolPath())

const myEntity = new Entity()
myEntity.addComponent(new Transform())
myEntity.addComponent(new BoxShape())
myEntity.addComponent(new PathData())

engine.addEntity(myEntity)
```

The example above defines a 3D path that's made up of four 3D vectors. We also define a custom `PathData` component, that includes the same data used by the custom component in the _lerp_ example above, but adds a `nextPathIndex` field to keep track of what vector to use next from the path.

The system is very similar to the system in the _lerp_ example, but when a lerp action is completed, it sets the `target` and `origin` fields to new values. If we reach the end of the path, we return to the first value in the path.

 <img src="{{ site.baseurl }}/images/media/gifs/lerp-path.gif" alt="Move entity" width="300"/>

<!--

## Move along curves

... investigate

-->

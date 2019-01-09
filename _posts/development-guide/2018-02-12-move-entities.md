---
date: 2018-02-12
title: Move entities
description: How to move, rotate and scale an entity gradually over time, with incremental changes.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 12
---

To move, rotate or resize an entity in your scene, change the  _position_, _rotation_ and _scale_ values stored in an entity's `Transform` component incrementally, frame by frame. This can be used on primitive shapes (cubes, spheres, planes, etc) as well as on 3D models (glTF).

You can easily perform these incremental changes by moving entities a small amount each time the `update()` function of a [system]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) is called.

## Move

The easiest way to move an entity is to use the `translate()` function to change the _position_ value stored in the `Transform` component.

```ts
export class SimpleMove {
  update() {
    let transform = myEntity.get(Transform)
    let distance = Vector3.Forward.scale(0.1)
    transform.translate(distance)
  }
}

engine.addSystem(new SimpleMove())

const myEntity = new Entity()
myEntity.set(new Transform())
myEntity.set(new BoxShape())

engine.addEntity(myEntity)
```

## Scale movement based on delay time

Suppose that the user running your scene is struggling to keep up with the pace of the frame rate. That could result in the movement appearing jumpy, as not all frames are evenly timed but each moves the entity in the same amount.

You can compensate for this uneven timing by using the `dt` parameter to adjust the scale the movement.

```ts
export class SimpleMove {
  update(dt: number) {
    let transform = myEntity.get(Transform)
    let distance = Vector3.Forward.scale(dt * 3)
    transform.translate(distance)
  }
}
// (...)
```

## Rotate

The easiest way to rotate an entity is to use the `rotate()` function to change the values in the Transform component incrementally, and run this as part of the `update()` function of a system.

The `rotate()` function takes two arguments:

- The direction in which to rotate (as a _Vector3_)
- The amount to rotate, in euler degrees

```ts
export class SimpleRotate {
  update() {
    let transform = myEntity.get(Transform)
    let distance = dt * 3
    transform.rotate(Vector3.Left(), distance)
  }
}

engine.addSystem(new SimpleRotate())
```

> Tip: To make an entity always rotate to face the user, you can use the `billboardMode` setting. See [Set entity poision]({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %}#face-the-user) for details.

## Rotate over a pivot point

When rotating an entity, the rotation is always in reference to the entity's center coordinate. To rotate an entity using another set of coordinates as a pivot point, create a second (invisible) entity with the pivot point as its position and make it a parent of the entity you with to rotate.

When rotating the parent entity, its children will be all rotated using the parent's position as a pivot point. Note that the position of the child entity is in reference to that of the parent entity.

```ts
// Create entity you wish to rotate
const door = new Entity()
door.set(new Transform())

// Create the pivot entity
const pivot = new Entity()
pivot.set(new Transform())
pivot.get(Transform).position.set(4, 1, 3)

// Set pivot as the parent
door.setParent(pivot)

// Position child in reference to parent
door.get(Transform).position.set(0.5, 0, 0)

// Rotate the parent. The child rotates using the parent's location as a pivot point.
pivot.get(Transform).rotation.set(0, 90, 0)

engine.addEntity(door)
engine.addEntity(pivot)

export class PivotRotate {
  update() {
    let transform = myEntity.get(pivot)
    let distance = dt * 3
    transform.rotate(Vector3.Left(), distance )
  }
}

engine.addSystem(new PivotRotate())
```
Note that in this example, the system is rotating the `pivot` entity, that's a parent of the `door` entity.

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

To implement this in your scene, you should store the data that goes into the lerp function in a component. We recommend creating a specific component to store the necessary information for the lerp to happen. You also need to define a system that implements the gradual movement in each frame.

```ts
@Component("lerpData")
export class LerpData {
  origin: Vector3 = Vector3.Zero()
  target: Vector3 = Vector3.Zero()
  fraction: number = 0
}

// a system to carry out the movement
export class LerpMove {
  update(dt: number) {
    let transform = myEntity.get(Transform)
    let lerp = myEntity.get(LerpData)
    if (lerp.fraction < 1) {
      transform.position = Vector3.Lerp(
        lerp.origin,
        lerp.target,
        lerp.fraction
      )
      lerp.fraction += dt / 6
    }
  }
}

// Add system to engine
engine.addSystem(new LerpMove())

const myEntity = new Entity()
myEntity.set(new Transform())
myEntity.set(new BoxShape())

myEntity.set(new LerpData())
myEntity.get(LerpData).origin = new Vector3(1, 1, 1)
myEntity.get(LerpData).target = new Vector3(8, 1, 3)

engine.addEntity(myEntity)
```

## Rotate between two angles

To rotate smoothly between two angles, use the _slerp_ (_spherical_ linear interpolation) algorithm. This algorithm is very similar to a _lerp_, but it handles quaternion rotations.

The `slerp()` function takes three parameters:

- The quaternion for the origin rotation
- The quaternion for the target rotation
- The amount, a value from 0 to 1 that represents what fraction of the translation to do.

```ts
const originRotation = Quaternion.Euler(0, 90, 0)
const targetRotation = Quaternion.Euler(0, 0, 0)

let newRotation = Scalar.Lerp(originRotation, targetRotation, 0.6)
```
To implement this in your scene, you should store the data that goes into the slerp function in a component. We recommend creating a specific component to store the necessary information for the lerp to happen. You also need to define a system that implements the gradual rotation in each frame.

```ts
@Component('slerpData')
export class SlerpData {
  originRot: Quaternion = Quaternion.Euler(0, 90, 0)
  targetRot: Quaternion = Quaternion.Euler(0, 0, 0)
  fraction: number = 0
}

// a system to carry out the rotation
export class SlerpRotate implements ISystem {
 
  update(dt: number) {
      let slerp = myEntity.get(SlerpData)
      let transform = myEntity.get(Transform)

      slerp.fraction += dt
      let rot = Quaternion.Slerp(slerp.originRot, slerp.targetRot, slerp.fraction)
      transform.rotation = rot   
  }
}

// Add system to engine
engine.addSystem(new SlerpRotate())

const myEntity = new Entity()
myEntity.set(new Transform())
myEntity.set(new BoxShape())

myEntity.set(new SlerpData())
myEntity.get(SlerpData).originRot = Quaternion.Euler(0, 90, 0)
myEntity.get(SlerpData).targetRot = Quaternion.Euler(0, 0, 0)

engine.addEntity(myEntity)
```

> Note: You could instead represent the rotation with Vector3 values and carry out a normal `lerp` function, but that would imply a conversion from Vector3 to Quaternions on each frame, as rotation values are stored as Quaternions in the Transform component.


## Change scale between two sizes

If you want an entity to change size move smoothly and you want it to keep its axis in proportion, use the _lerp_ (linear interpolation) algorithm of the `Scalar` object. Otherwise, you can represent scale as a `Vector3` and lerp between two vectors just as you would for changing the position.

The `lerp()` function of the `Scalar` object takes three parameters:

- An origin number
- A target number
- The amount, a value from 0 to 1 that represents what fraction of the scaling to do.

```ts
const originScale = 1
const targetScale = 10

let newScale = Scalar.Lerp(originScale, targetScale, 0.6)
```
To implement this in your scene, you should store the data that goes into the lerp function in a component. We recommend creating a specific component to store the necessary information for the lerp to happen. You also need to define a system that implements the gradual scaling in each frame.


## Move at irregular speeds between two points

While using the lerp method, you can make the movement speed non-linear. In the previous example we increment the lerp amount by a given amount each frame, but we could also use a mathematical function to increase the number exponentially or in other measures that give you a different movement pace.

You could also use a function that gives recurring results, like a sine function, to describe a movement that comes and goes.

```ts
@Component("lerpData")
export class LerpData {
  origin: Vector3 = Vector3.Zero()
  target: Vector3 = Vector3.Zero()
  fraction: number = 0
  time: number = 0
}

export class LerpMove {
  update(dt: number) {
    let transform = lerpEntity.get(Transform)
    let lerp = lerpEntity.get(LerpData)
    lerp.time += dt / 6
    lerp.fraction = Math.sin(lerp.time)
    transform.position = Vector3.Lerp(
      lerp.origin,
      lerp.target,
      lerp.fraction
    )
  }
}
```

The example above adds a `time` field to the custom component. The `time` field is incremented on every frame, and then `fraction` is set to the _sin_ of that value. Because of the nature of the _sin_ operation, the entity will lerp back and forth between both points.

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

export class PatrolPath {
  update(dt: number) {
    let transform = myEntity.get(Transform)
    let path = myEntity.get(PathData)
    if (path.fraction < 1) {
      transform.position = Vector3.Lerp(
        path.origin,
        path.target,
        path.fraction
      )
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
myEntity.set(new Transform())
myEntity.set(new BoxShape())
myEntity.set(new PathData())

engine.addEntity(myEntity)
```

The example above defines a 3D path that's made up of four 3D vectors. We also define a custom `PathData` component, that includes the same data used by the custom component in the _lerp_ example above, but adds a `nextPathIndex` field to keep track of what vector to use next from the path.

The system is very similar to the system in the _lerp_ example, but when a lerp action is completed, it sets the `target` and `origin` fields to new values. If we reach the end of the path, we return to the first value in the path.

<!--

## Move along curves

... investigate

-->

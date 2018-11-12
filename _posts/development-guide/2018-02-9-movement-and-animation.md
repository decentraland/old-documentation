---
date: 2018-02-9
title: Movement and animation
description: How to move and animate entities in your scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 2
---

<!--
## glTF animations

glTF models can include animations. Animations tell the mesh how to move over time.

See 3D models

-->

## Move an entity

To move any entity's position over time, you need to change the data in its _Transform_ component.

The easiest way to do this is to change the values incrementally in the `update()` function of a system.

```ts
export class SimpleMove {
  update() {
    myEntity.get(Transform).position.x += 0.1
  }
}

engine.addSystem(new SimpleMove())

const myEntity = new Entity()
myEntity.set(new Transform())
myEntity.set(new BoxShape())

engine.addEntity(myEntity)
```

The code above works ok, but suppose that the frame rate of the user running your scene can't keep up at a regular pace. Then the movement would appear jumpy, as not all frames are evenly timed.

You can avoid that by using the `dt` parameter

```ts
export class SimpleMove{
  update(dt: number) {
    myEntity.get(Transform).position.x += dt: number * 0.5
  }
}
// (...)
```

## Move gradually to a specific point

If you want an entity to move smoothly between two points, using a lerp (linear interpolation) algorythm is the easiest way. This algorythm is very well known in game development, as it's really useful.

The `lerp()` function takes three parameters:

- The origin vector
- The target vector
- The amount, a value from 0 to 1 that represents what fraction of the translation to do.

```ts
const originVector = Vector3.Zero()
const targetVector = Vector3.Forward()

let newPos = Vector3.Lerp(originVector, targetVector, 0.6)
```

The linear interpolation algorithm finds an intermediate point in the path between both vectors that is in the same proportion as the time fraction.

For example, if the origin vector is _(0, 0, 0)_ and the target vector is _(10, 0, 10)_:

- Using an amount of 0 would return _(0, 0, 0)_
- Using an amount of 0.3 would return _(3, 0, 3)_
- Using an amount of 1 would return _(10, 0, 10)_

To implement this in your scene, you should store the data that goes into the lerp function in a component. We recommend creating a specific component to store the necessary information for the lerp to happen. You also need to define a system that implements the gradual movement in each frame.

```ts
@Component("lerpData")
export class LerpData {
  previousPos: Vector3 = Vector3.Zero()
  target: Vector3 = Vector3.Zero()
  fraction: number = 0
}

export class LerpMove {
  update() {
    let transform = myEntity.get(Transform)
    let lerp = myEntity.get(LerpData)
    if (lerp.fraction < 1) {
      transform.position = Vector3.Lerp(
        lerp.previousPos,
        lerp.target,
        lerp.fraction
      )
      lerp.fraction += 1 / 60
    }
  }
}

engine.addSystem(new LerpMove())

const myEntity = new Entity()
myEntity.set(new Transform())
myEntity.set(new BoxShape())

myEntity.set(new LerpData())
myEntity.get(LerpData).previousPos = new Vector3(1, 1, 1)
myEntity.get(LerpData).target = new Vector3(8, 1, 3)

engine.addEntity(myEntity)
```

> Note: You can do the same kind of operation to lerp an entity's rotation or scale. When lerping scale, if you plan to keep all axis in proportion, you can make things simpler by using `Scalar.lerp` and only interpolate between two numbers instead of two vectors.

## Move in varying increments

While using the lerp method, you can make the movement speed non-linear. In the previous example we increment the fraction by a given amount each frame, but we could also use a mathematical function to increase the number exponentially or in other measures that give you a different movement pace.

You could also use a function that gives recurring results, like a sine function, to describe a movement that comes and goes.

```ts
@Component("lerpData")
export class LerpData {
  previousPos: Vector3 = Vector3.Zero()
  target: Vector3 = Vector3.Zero()
  fraction: number = 0
  time: number = 0
}

export class LerpMove {
  update() {
    let transform = lerpEntity.get(Transform)
    let lerp = lerpEntity.get(LerpData)
    lerp.time += 0.01
    lerp.fraction = Math.sin(lerp.time)
    transform.position = Vector3.Lerp(
      lerp.previousPos,
      lerp.target,
      lerp.fraction
    )
  }
}
```

The example above adds a `time` field to the custom component. The `time` field is incremented on every frame, and then `fraction` is set to the _sin_ of that value. Because of the nature of the _sin_ operation, the entity will lerp back and forth between both points.

## Follow a path

A `Path2` or `Path3` object stores a series of vectors that describe a path. You can have an entity loop over the list of vectors, performing a lerp movement between each.

```ts
const point1 = new Vector3(1, 1, 1)
const point2 = new Vector3(8, 1, 3)
const point3 = new Vector3(8, 4, 7)
const point4 = new Vector3(1, 1, 7)

const myPath = new Path3D([point1, point2, point3, point4])

@Component("pathData")
export class PathData {
  previousPos: Vector3 = myPath.path[0]
  target: Vector3 = myPath.path[1]
  fraction: number = 0
  nextPathIndex: number = 1
}

export class PatrolPath {
  update() {
    let transform = myEntity.get(Transform)
    let path = myEntity.get(PathData)
    if (path.fraction < 1) {
      transform.position = Vector3.Lerp(
        path.previousPos,
        path.target,
        path.fraction
      )
      path.fraction += 1 / 60
    } else {
      path.nextPathIndex += 1
      if (path.nextPathIndex >= myPath.path.length) {
        path.nextPathIndex = 0
      }
      path.previousPos = path.target
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

The system is very similar to the system in the _lerp_ example, but when a lerp action is completed, it sets the `target` and `previousPos` fields to new values. If we reach the end of the path, we return to the first value in the path.

<!--

## Move along curves

... investigate

-->

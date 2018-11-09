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

## glTF animations

glTF models can include animations. Animations tell the mesh how to move over time.

See 3D models

## Move in a straight line

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

## Move towards a specific point

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
  target: Vector3 = Vector3.Zero()
  previousPos: Vector3 = Vector3.Zero()
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

Try replacing the line `lerp.fraction += 1/60` for other alternatives like...

You could also use a function that gives recurring results, like a sine function, to describe a movement that comes and goes.

## Move following a path

A `Path2` or `Path3` object stores a series of vectors that describe a path. You can have an entity lerp over two vectors and then move on to the next vectors in the path.

## Move following a curve

... investigate

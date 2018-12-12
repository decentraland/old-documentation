---
date: 2018-02-12
title: Entity positioning
description: How to set the position, rotation and scale of an entity in a scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 2
---

You can set the _position_, _rotation_ and _scale_ of an entity by using the `Transform` component. This can be used on primitive shapes (cubes, spheres, planes, etc) as well as on 3D models (glTF).

```ts
// Create a new entity
const myEntity = new Entity()

// Add a transform component to the entity
myEntity.set(new Transform())
```

To move, rotate or resize an entity in your scene, change the values on this component incrementally, frame by frame. See [Movement and animation]() for more details and best practices.

## Position

`position` is a _3D vector_, it sets the position of the entity's center on all three axes, stored as a `Vector3` object.

```ts
// Create transform
let myTransform = new Transform()

// Set each axis individually
myTransform.position.x = 3
myTransform.position.y = 1
myTransform.position.z = 3

// Set the position with three numbers (x, y, z)
myTransform.position.set(3, 1, 3)

// Set the position with an object
myTransform.position = new Vector3(5, 1, 5)
```

> Note: When setting the value of the position with an object, you can either use a `Vector3` object, or any other object with _x_, _y_ and _z_ fields.

When setting a position, keep the following considerations in mind:

- `x:0, y:0, z:0` refers to the _South-East_ corner of the scene's base parcel, at ground level.

  > Tip: When viewing a scene preview, a compass appears in the (0,0,0) point of the scene with labels for each axis as reference.

  > Note: You can change the base parcel of a scene by editing the `base` attribute of _scene.json_.

- If an entity is a child of another, then `x:0, y:0, z:0` refers to the center of its parent entity, wherever it is in the scene.

- By default, coordinates are measured in _meters_.

  > Note: If you're positioning a child of a parent entity that has a scale that's different from 1, the position vector is scaled accordingly.

- Every entity in your scene must be positioned within the bounds of the parcels it occupies at all times. If an entity leaves these boundaries, it will raise an error.

  > Note: When viewing a scene in preview mode, entities that are out of bounds are highlighted in _red_.

- Your scene is also limited in height. The more parcels that make up the scene, the higher you're allowed to build. See [scene limitations]() for more details.

## Rotation

`rotation` is stored as a [_quaternion_](https://en.wikipedia.org/wiki/Quaternion), a system of four numbers, _x_, _y_, _z_ and _w_.

```ts
// Create transform
let myTransform = new Transform()

// Set rotation with four numbers (x, y, z, w)
myTransform.rotation.set(0, 0, 1, 0)

// Set rotation with a quaternion
myTransform.rotation = new Quaternion(1, 0, 0, 0)
```

You can also set the rotation field with [_Euler_ angles](https://en.wikipedia.org/wiki/Euler_angles), the more common _x_, _y_ and _z_ notation that most people are familiar with. To use Euler angles, use the `setEuler()` method.

```ts
// Create transform
let myTransform = new Transform()

// Use the .setEuler() function
myTransform.rotation.setEuler(0, 90, 180)

// Set the `eulerAngles` field
myTransform.rotation.eulerAngles = new Vector3(0, 90, 0)
```

When using a _3D vector_ to represent Euler angles, _x_, _y_ and _z_ represent the rotation in that axis, measured in degrees. A full turn requires 360 degrees.

> Note: If you set the rotation using _Euler_ angles, the rotation value is still stored internally as a quaternion.

When you retrieve the rotation of an entity, it returns a quaternion by default. To obtain the rotation expressed as in Euler angles, get the `.eulerAngles` field:

```ts
myEntity.get(Transform).rotation.eulerAngles
```

## Face the user

You can set a shape component to act as a _billboard_, this means that it will always rotate the entity to face the user. All components for primitive shapes and glTF models have a `billboard` field to allow you to set this.

Billboards were a common technique used in 3D games of the 90s, where most entities were 2D planes that always faced the player, but the same can also be used to rotate a 3D model.

You can also choose to only rotate the shape in this way in one of its axis. For example, if you set the billboard mode of a cube to only rotate in the Y axis, it will follow the user when moving at ground level, but the user will be able to look at it from above or from below.

Set the `billboard` field with a value from the `BillboardMode` enum. For example, to rotate in all axis, set the value to `BillboardMode.BILLBOARDMODE_ALL`.

- `BILLBOARDMODE_NONE` (0): No movement on any axis (default value)
- `BILLBOARDMODE_X` (1): Only move in the **X** axis, the rotation on other axis is fixed.
- `BILLBOARDMODE_Y` (2): Only move in the **Y** axis, the rotation on other axis is fixed.
- `BILLBOARDMODE_Z` (4): Only move in the **Z** axis, the rotation on other axis is fixed.
- `BILLBOARDMODE_ALL` (7): Rotate on all axis to follow the user.

```ts
// Create a transform
let myTransform = new Transform()

// Set its billboard mode
myTransform.billboard = BillboardMode.BILLBOARDMODE_Y
```

Billboards are also very handy to add to _text_ entities, since it makes them always legible.

If the transform is configured with both a specific `rotation` and a `billboard` value other than 0, it uses the rotation set on by its billboard behavior.

> Note: If there are multiple users present at the same time, they will each see the entities with billboard mode facing them.

## Face a set of coordinates

You can use `lookAt()` to orient an entity fo face a specific point in space by simply passing it that point's coordinates. This is a way to avoid dealing with the math for calculating the necessary angles.

```ts
// Create a transform
let myTransform = new Transform()

// Rotate to face the coordinates (4, 1, 2)
myTransform.lookAt(new Vector3(4, 1, 2))
```

This field requires a _Vector3_ object as a value, or any object with _x_, _y_ and _z_ attributes. This vector indicates the coordinates of the position of the point in the scene to look at.

The `lookAt()` function has a second optional argument that sets the global direction for _up_ to use as reference. For most cases, you won't need to set this field.

## Scale

`scale` is also a _3D vector_, stored as a `Vector3` object, including the scale factor on the _x_, _y_ and _z_ axis. The shape of the entity scaled accordingly, whether it's a primitive or a 3D model.

You can either use the `set()` operation to provide a value for each of the three axis, or use `setAll()` to provide a single number and maintain the entity's proportions as you scale it.

The default scale is 1, so assign a value larger to 1 to stretch an entity or smaller than 1 to shrink it.

You can either set each dimension individually, or use the `set` operation to set all dimensions.

```ts
// Create a transform
let myTransform = new Transform()

// Set each dimension individually
myTransform.scale.x = 1
myTransform.scale.y = 5
myTransform.scale.z = 1

// Set the whole scale with one expression  (x, y, z)
myTransform.scale.set(1, 5, 1)

// Set the scale with a single number to maintain proportions
myTransform.scale.setAll(2)

// Set the scale with an object
myTransform.scale = new Vector3(1, 1, 1.5)
```

When setting the value of the scale with an object, you can either use a `Vector3` object, or any other object with _x_, _y_ and _z_ fields.

## Inherit transformations from parent

When an entity is nested inside another, the child entities inherit components from the parents. This means that if a parent entity is positioned, scaled or rotated, its children are also affected. The position, rotation and scale values of children entities don't override those of the parents, instead these are compounded.

If a parent entity is scaled, all position values of its children are also scaled.

```tsx
// Create entities
const parentEntity = new Entity()
const childEntity = new Entity()

// Set one as the parent of the other
childEntity.setParent(parentEntity)

// Create a transform for the parent
let parentTransform = new Transform()
parentTransform.position.set(3, 1, 1)
parentTransform.scale(0.5, 0.5, 0.5)

// Create a transform for the child
let childTransform = new Transform()
childTransform.position.set(0, 1, 0)

// Add both entities to the engine
parentEntity.set(parentTransform)
childEntity.set(childTransform)
```

You can use an invisible entity with no shape component to wrap a set of other entities. This entity won't be visible in the rendered scene, but can be used to group its children and apply a transform to all of them.

## Rotate using a pivot point

When setting the rotation of an entity, the rotation is always in reference to the entity's center coordinate. To rotate an entity using another set of coordinates as a pivot point, create a second (invisible) entity with the pivot point as its position and make it a parent of the entity you with to rotate.

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
```

## Move gradually

The easiest way to move an entity is to use the `translate()` function to change the values stored in the `Transform` component. You can do this incrementally by translating a small amount each time the `update()` function of a system is called.

```ts
export class SimpleMove {
  update() {
    myEntity.get(Transform).translate(Vector3.Forward.scale(0.1))
  }
}

engine.addSystem(new SimpleMove())

const myEntity = new Entity()
myEntity.set(new Transform())
myEntity.set(new BoxShape())

engine.addEntity(myEntity)
```

Suppose that the user running your scene is struggling to keep up with the pace of the frame rate. That could result in the movement appearing jumpy, as not all frames are evenly timed but each moves the entity in the same amount.

You can compensate for this uneven timing by using the `dt` parameter to adjust the scale the movement.

```ts
export class SimpleMove {
  update(dt: number) {
    myEntity.get(Transform).translate(Vector3.Forward.scale(dt * 3))
  }
}
// (...)
```

## Rotate gradually

The easiest way to rotate an entity is to use the `rotate()` function to change the values in the Transform component incrementally, and run this as part of the `update()` function of a system.

The `rotate()` function takes two arguments:

- The direction in which to rotate (as a _Vector3_)
- The amount

```ts
export class SimpleRotate {
  update() {
    myEntity.get(Transform).rotate(Vector3.Left, dt * 3)
  }
}

engine.addSystem(new SimpleRotate())
```

## Move between two points

If you want an entity to move smoothly between two points, using a _lerp_ (linear interpolation) algorythm is the easiest way. This algorythm is very well known in game development, as it's really useful.

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

## Move non-linearly between two points

While using the lerp method, you can make the movement speed non-linear. In the previous example we increment the lerp amount by a given amount each frame, but we could also use a mathematical function to increase the number exponentially or in other measures that give you a different movement pace.

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

## Move following a path

A `Path3` object stores a series of vectors that describe a path. You can have an entity loop over the list of vectors, performing a lerp movement between each.

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

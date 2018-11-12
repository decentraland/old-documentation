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
const myEntity = new Entity()
let myTransform = new Transform()
myEntity.set(myTransform)
```

## Position

`position` is a _3D vector_, it sets the position of the entity's center on all three axes.

- By default, coordinates are measured in _meters_.
  > Note: If you're positioning a child of a parent entity that has a scale that's different from 1, the position vector is scaled accordingly.
- `x:0, y:0, z:0` refers is the middle of the scene's base parcel, at ground level. The position of a child entity is relative to the center position of its parent entity, so `x:0, y:0, z:0` always refers to the center of the parent, wherever it is in the scene.
  > Note: You can change the base parcel of a scene by editing the `base` attribute of _scene.json_.

You can either set each axis individually, or use the `set` operation to set all axis.

```ts
let myTransform = new Transform()

// Set each axis individually
myTransform.position.x = 3
myTransform.position.y = 1
myTransform.position.z = 3

// Set the whole position with one expression (x, y, z)
myTransform.position.set(3, 1, 3)
```

> Tip: When previewing a scene locally, a compass appears in the (0,0,0) point of the scene with labels for each axis.

## Rotation

`rotation` is stored as a [_quaternion_](https://en.wikipedia.org/wiki/Quaternion), a system of four numbers, _x_, _y_, _z_ and _w_.

```ts
let myTransform = new Transform()

myTransform.rotation.set(0, 0, 1, 0)
```

You can also set the rotation field with _Euler_ angles, the more common _x_, _y_ and _z_ notation that most people are familiar with. To use Euler angles, use the `setEuler()` method.

```ts
let myTransform = new Transform()

myTransform.rotation.setEuler(0, 90, 180)
```

The SDK uses a _3D vector_ to represent Euler angles, where _x_, _y_ and _z_ represent the rotation in that axis, measured in degrees. A full turn requires 360 degrees.

> Note: If you set the rotation using _Euler_ angles, the rotation value is still stored internally as a quaternion.

When you retrieve the rotation of an entity, it returns a quaternion by default. To obtain the rotation expressed as in Euler angles, you need to specify it:

```ts
myEntity.get(Transform).rotation.eulerAngles
```

## Rotate to face the user

You can set a shape component to act as a _billboard_, this means that it will always rotate the entity to face the user. All components for primitive shapes and glTF models have a `billboard` field to allow you to set this.

Billboards were a common technique used in 3D games of the 90s, where most entities were 2D planes that always faced the player, but the same can also be used to rotate a 3D model.

You can also choose to only rotate the shape in this way in one of its axis. For example, if you set the billboard mode of a cube to only rotate in the Y axis, it will follow the user when moving at ground level, but the user will be able to look at it from above or from below.

Set the `billboard` field with a number, each number refers to a different rotation mode:

- 0: No movement on any axis (default value)
- 1: Only move in the **X** axis, the rotation on other axis is fixed.
- 2: Only move in the **Y** axis, the rotation on other axis is fixed.
- 4: Only move in the **Z** axis, the rotation on other axis is fixed.
- 7: Rotate on all axis to follow the user.

```ts
let myTransform = new Transform()

// Set its billboard mode
myTransform.billboard = 2
```

Billboards are also very handy to add to _text_ entities, since it makes them always legible.

If the transform is configured with both a specific `rotation` and a `billboard` value other than 0, it uses the rotation set on by its billboard behavior.

## Rotate to face a position

You can use `lookAt()` to orient an entity fo face a specific point in space by simply passing it that point's coordinates. This is a way to avoid dealing with the math for calculating the necessary angles.

```ts
let myTransform = new Transform()
myTransform.position.set(1, 0, 1)

// Rotate to face the coordinates (4, 1, 2)
myTransform.lookAt(new Vector3(4, 1, 2))
```

This field requires a _Vector3Component_ as a value, this vector indicates the coordinates of the position of the point in the scene to look at.

## Scale

`scale` is also a _3D vector_, including the scale factor on the _x_, _y_ and _z_ axis. The shape of the entity scaled accordingly, whether it's a primitive or a 3D model.

You can either use the `set()` operation to provide a value for each of the three axis, or use `setAll()` to provide a single number and maintain the entity's proportions as you scale it.

The default scale is 1, so assign a value larger to 1 to stretch an entity or smaller than 1 to shrink it.

You can either set each dimension individually, or use the `set` operation to set all dimensions.

```ts
let myTransform = new Transform()

// Set each dimension individually
myTransform.scale.x = 1
myTransform.scale.y = 5
myTransform.scale.z = 1

// Set the whole scale with one expression  (x, y, z)
myTransform.set(1, 5, 1)

// Set the scale with a single number to maintain proportions
myTransform.setAll(2)
```

## Inherit transformations from parent

When an entity is nested inside another, the child entities inherit components from the parents. This means that if a parent entity is positioned, scaled or rotated, its children are also affected. The position, rotation and scale values of children entities don't override those of the parents, instead these are compounded.

If a parent entity is scaled, all position values of its children are also scaled.

```tsx
const parentEntity = new Entity()
const childEntity = new Entity()
childEntity.parent = parentEntity

let parentTransform = new Transform()
parentTransform.position.set(3, 1, 1)
parentTransform.scale(0.5, 0.5, 0.5)

let childTransform = new Transform()
childTransform.position.set(0, 1, 0)

parentEntity.set(parentTransform)
childEntity.set(childTransform)
```

You can include an invisible entity with no shape component wrapping a set of other entities. This entity won't be visible in the rendered scene, but can be used to apply a transform to all its children as a group.

<!--
## Translate


## Rotate




-->

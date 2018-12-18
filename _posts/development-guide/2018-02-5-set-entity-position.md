---
date: 2018-02-5
title: Set Entity positions
description: How to set the position, rotation and scale of an entity in a scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 5
---

You can set the _position_, _rotation_ and _scale_ of an entity by using the `Transform` component. This can be used on primitive shapes (cubes, spheres, planes, etc) as well as on 3D models (glTF).

```ts
// Create a new entity
const myEntity = new Entity()

// Add a transform component to the entity
myEntity.set(new Transform())
```

For brevity, you can also create a `Transform` entity and give it initial values in a single statement, passing it an object that can optionally include _position_, _rotation_ and _scale_ properties.

```ts
myEntity.set(new Transform({ 
    position: new Vector3(3, 1, 3), 
    scale: new Vector3(10, 10, 10)
    rotation: new Quaternion(0, 0, 0, 1)
    }))
```

To move, rotate or resize an entity in your scene, change the values on this component incrementally, frame by frame. See [Move entities]() for more details and best practices.

## Position

`position` is a _3D vector_, it sets the position of the entity's center on all three axes, stored as a `Vector3` object.

```ts
// Create transform with a predefined position
let myTransform = new Transform({position: new Vector3(1, 0, 1)})

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
// Create transform with a predefined rotation in Quaternions
let myTransform = new Transform({rotation: new Quaternion(0, 0, 0, 1)})

// Set rotation with four numbers (x, y, z, w)
myTransform.rotation.set(0, 0, 1, 0)

// Set rotation with a quaternion
myTransform.rotation = new Quaternion(1, 0, 0, 0)
```

You can also set the rotation field with [_Euler_ angles](https://en.wikipedia.org/wiki/Euler_angles), the more common _x_, _y_ and _z_ notation that most people are familiar with. To use Euler angles, use the `setEuler()` method.

```ts
// Create transform with a predefined rotation in Euler angles
let myTransform = new Transform({rotation: Quaternion.Euler(0, 90, 0)})

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
// Create a transform with a predefined scale
let myTransform = new Transform({scale: new Vector3(2, 2, 2)})

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
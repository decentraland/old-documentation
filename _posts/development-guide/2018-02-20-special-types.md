---
date: 2018-02-14
title: Special types
description: Learn what special types exist, including Vector, Quaternions, and more.
categories:
  - development-guide
type: Document
---

## Vectors

Decentraland uses vectors to represent paths, points in space, and directions. Vectors can also be used to define rotation orientations, as a friendlier alternative to _quaternions_. `Vector2`, `Vector3` and `Vector4` are each defined as different classes, containing a different number of dimensions.

Vector objects contain a series of handy methods that you can call to avoid having to deal with most vector math operations.

Below are a few lines showing the syntax for some basic operations with vectors.

```ts
// Instance a vector object
let myVector = new Vector3(3, 1, 5)

// Edit one of its values
myVector.x = 5

// Call functions from the vector instance
let normalizedVector = myVector.normalize()

// Call functions from the vector class
let distance = Vector3.Distance(myVector1, myVector2)

let midPoint = Vector3.lerp(myVector1, myVector2, 0.5)
```

3D vectors are also included in the fields of several components. For example, the `Transform` component contains `Vector3` values for the _position_ and _scale_ of the entity.

#### Shortcuts for writing direction vectors

The following shortcuts exist for defining generic vectors:

- `Vector3.Zero()` returns _(0, 0, 0)_
- `Vector3.Up()` returns _(0, 1, 0)_
- `Vector3.Down()` returns _(0, -1, 0)_
- `Vector3.Left()` returns _(-1, 0, 0)_
- `Vector3.Right()` returns _(1, 0, 0)_
- `Vector3.Forward()` returns _(0, 0, 1)_
- `Vector3.Backward()` returns _(0, 0, -1)_

## Scalars

A scalar is nothing more than a number. For that reason, it doesn't make much sense to instantiate a `Scalar` object to store data. The functions in the `Scalar` class however exposes several handy functions (similar to those in _Vector_ classes), that can be used on numbers.

```ts
// Call functions from the Scalar class
let random = Scalar.RandomRange(1, 100)

let midPoint = Scalar.lerp(number1, number2, 0.5)

let clampedValue = Scalar.Clamp(myInput, 0, 100)
```

## Quaternions

Quaternions are used to store rotation information for the Transform component. A Quaternion is composed of four numbers between -1 and 1: x, y, z, w.

```ts
// Instance a quaternion object
let myQuaternion = new Quaternion(0, 0, 0, 1)

// Edit one of its values
myQuaternion.x = 1

// Call functions from the quaternion instance
let quaternionAsArray = myQuaternion.asArray()

// Call functions from the quaternion class
let quaternionFromEuler = Quaternion.FromEulerAnglesRef(90, 0, 0)

let midPoint = Quaternion.Slerp(myQuaternion1, myQuaternion2, 0.5)
```

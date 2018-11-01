---
date: 2018-02-14
title: Vector functions
description: Learn what methods can be executed by a Vector object on the SDK.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 3
---

Vector objects have a series of handy methods that you can call to avoid having to deal with vector math operations.

## Vectors

3D vectors are included in some of the components available in the SDK. You can also define a custom component that stores Vector objects as its values.

For example, the `Transform` component contains three vectors, for the _position_, _rotation_ and _scale_ of the entity.

## Linear interpolation

Linearly interpolates between two vectors.

     * @param a - The origin vector
     * @param b - The target vector
     * @param fraction - The time fraction (0 to 1)
     * @param ref - The target reference vector
     */
    static lerp(a: Vector3, b: Vector3, fraction: number, ref: Vector3): void;

## Distance

Returns the distance between two vectors.

    /**
     * @public
     *
     * @param a - The origin vector
     * @param b - The target vector
     */
    static distance(a: Vector3, b: Vector3): number;
    /**
     * @public
     * Shorthand for writing Vector3(0, 0, 0).
     */

        add(vector: Vector3): void;
    /**
     * @public
     * Returns the angle between two vectors in radians.
     */
    angleTo(vector: Vector3): number;
    /**
     * @public
     * Returns a copy of the vector as a new instance.
     */
    clone(): Vector3;
    /**
     * @public
     * Sets X, Y and Z for this vector based on another vector's value.
     */
    copy(vector: Vector3): void;
    /**
     * @public
     * Cross Product of two vectors.
     */
    cross(vector: Vector3): void;
    /**
     * @public
     * Divides a vector by another vector.
     */
    divide(vector: Vector3): void;
    /**
     * @public
     * Divides a vector by a number.
     */
    divideScalar(num: number): void;
    /**
     * @public
     * Dot Product of two vectors.
     */
    dot(vector: Vector3): number;
    /**
     * @public
     * Returns true if two vectors are equal.
     */
    equals(vector: Vector3): boolean;
    /**
     * @public
     * Multiplies a vector by another vector.
     */
    multiply(vector: Vector3): void;
    /**
     * @public
     * Multiplies a vector by a number.
     */
    multiplyScalar(num: number): void;
    /**
     * @public
     * Makes this vector have a magnitude of 1.
     */
    normalize(): void;
    /**
     * @public
     * Returns a new instance of this vector with a magnitude of 1.
     */
    normalized(): Vector3;
    /**
     * @public
     * Sets the initialization values for this vector.
     */
    set(x: number, y: number, z: number): void;
    /**
     * @public
     * Subtracts two vectors.
     */
    subtract(vector: Vector3): void;
    /**
     * @public
     * Returns a nicely formatted string for this vector.
     */
    toString(): string;

/\*\*

- @public
- Adds two vectors.
  \*/
  distanceTo(vector: Vector3) {
  return Vector3.distance(this, vector)
  }

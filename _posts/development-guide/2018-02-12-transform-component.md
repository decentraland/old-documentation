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

`rotation` is a _3D vector_ too, but where _x_, _y_ and _z_ represent the rotation in that axis, measured in degrees. A full turn requires 360 degrees.

You can either set each angle individually, or use the `set` operation to set all angles.

```ts
let myTransform = new Transform()

// Set each angle individually
myTransform.rotation.x = 180
myTransform.rotation.y = 90
myTransform.rotation.z = 0

// Set the whole rotation with one expression  (x, y, z)
myTransform.rotation.set(180, 90, 0)
```

<!--
#### Turn to face the user

You can set an entity to act as a _billboard_, this means that it will always rotate to face the user. This was a common technique used in 3D games of the 90s, where most entities were planes that always faced the player, but the same can be used with and 3D model. This is also very handy to add to _text_ entities, since it makes them always legible.

{% raw %}

```tsx
<box billboard={7} />
```

{% endraw %}

You must provide this setting with a number that selects between the following modes:

- 0: No movement on any axis
- 1: Only move in the **X** axis, the rotation on other axis is fixed.
- 2: Only move in the **Y** axis, the rotation on other axis is fixed.
- 4: Only move in the **Z** axis, the rotation on other axis is fixed.
- 7: Rotate on all axis to follow the user.

If the entity is configured with both a specific rotation and a billboard setting, it uses the rotation set on by its billboard behavior.

#### Turn to face a position

You can set an entity to face a specific position in the scene using `lookAt`. This is a way to set the rotation of an entity without having to deal with angles.

{% raw %}

```tsx
<box lookAt={{ x: 2, y: 1, z: 3 }} transition={{ lookAt: { duration: 500 } }} />
```

{% endraw %}

This setting needs a _Vector3Component_ as a value, this vector indicates the coordinates of the point in the scene that it will look at. You can, for example, set this value to a variable in the scene state that is updated with another entity's position.

You can use a transition to make movements caused by lookAt smoother and more natural.

If the entity is configured with both a specific rotation and a lookAt setting, it uses the rotation set on by its lookAt behavior.

-->

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

## Transitions

In dynamic scenes, you can configure an entity to affect the way in which it moves. By default, all changes to an entity are rendered as a sudden shift from one state to another. By adding a _transition_, you can make the change be gradual and more natural.

The example below shows a box entity that is configured to rotate smoothly.

{% raw %}

```tsx
<box
  rotation={currentRotation}
  transition={{
    rotation: { duration: 1000, timing: "ease-in" }
  }}
/>
```

{% endraw %}

> Note: The transition doesn't make the box rotate, it just sets the way it rotates whenever the value of the entity's rotation changes, usually as the result of an event.

The transition can be added to affect the following properties of an entity:

- position
- rotation
- scale
- lookAt

Note that the transition for each of these properties is configured separately.

{% raw %}

```tsx
<box
  rotation={currentRotation}
  scale={currentScale}
  transition={{
    rotation: { duration: 1000, timing: "ease-in" },
    scale: { duration: 300, timing: "bounce-in" }
  }}
/>
```

{% endraw %}

The transition allows you to set:

- A delay: milliseconds to wait before the change begins occuring.
- A duration: milliseconds from when the change begins to when it ends.
- Timing: select a function to shape the transition. For example, the transition could be _linear_, _ease-in_, _ease-out_, _exponential-in_ or _bounce-in_, among other options.

In the example below, a transition is applied to the rotation of an invisible entity that wraps a box. As the box is off-center from the parent entity, the box pivots like an opening door.

{% raw %}

```tsx
<entity
  rotation={currentRotation}
  transition={{
    rotation: { duration: 1000, timing: "ease-in" }
  }}
>
  <box
    id="door"
    scale={{ x: 1, y: 2, z: 0.05 }}
    position={{ x: 0.5, y: 1, z: 0 }}
  />
</entity>
```

{% endraw %}
-->
---
date: 2018-02-10
title: Entity groups
description: Learn about how your scene keeps track of lists of entities that have components in common to make updating them easier.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 3
---

Each entity group keeps track of a list of entities that have all the required components. The engine automatically updates this list every time that:

- A new entity is added to the engine
- An entity is removed from the engine
- An entity in the engine adds a new component
- An entity in the engine removes a component

After the group is created, you don't need to add or remove manually from it, the engine takes care of that.

```ts
const myGroup = engine.getComponentGroup(Transform)
```

[Systems]() typically iterate over these groups in their update method. Having a predefined group of valid entities is a great way to save resources, specially for functions that run on every frame like `update()`. If on every frame your system would have to iterate over every single entity in the scene, that would be very time consuming.

You can access the entities in a group in the following way: if the group name is `myGroup`, calling `this.myGroup.entities` returns an array containing all the entities in it. Typically, the functions in a system iterate over this array, performing the same operations on each.

> Note: Keep in mind that groups take up space in the local memory of the user's machine. Usually, the benefit in speed you get from having a group is a tradeoff that is well worth it. However, for cases where you have a large group that you don't access all that often, it might be better to not have one.

## Required components

When creating a group, you need to specify what components need to be present in every entity of the group. You can list as many components as you want, the group will only accept entities that have **all** of the listed components.

```ts
const myGroup = engine.getComponentGroup(Transform, Physics, NextPosition)
```

> Tip: If your scene includes several entities that have the same components, but you only want some of those in your group, create a custom component to acts as as a flag. This component doesn't need to have any properties in it. Add this component to the entities that you want the group to handle.

## Use groups on a system

```ts
const myGroup = engine.getComponentGroup(Transform, Physics)

export class PhysicsSystem {
  update() {
    for (let entity of this.myGroup.entities) {
      const position = entity.get(Transform).Position
      const vel = entity.get(Physics).velocity
      position.x += vel.x
      position.y += vel.y
      position.z += vel.z
    }
  }
}
```

In the example above, `PhysicsSystem` iterates over the entities in `myGroup` as part of the `update()` function, that is executed on every frame of the game loop.

- If the scene has several _ball_ entities, each with a `Position` and a `Physics` component, then they be included in `myGroup` and `PhysicsSystem` will update their position on every frame.

- If your scene also has other entities like a _hoop_ and a _scoreBoard_ that only have a `Physics` component, then they won't be in `myGroup` and won't be unaffected by `PhysicsSystem`.

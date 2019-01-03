---
date: 2018-02-2
title: Component groups
description: Learn about how your scene keeps track of lists of entities that have components in common to make updating them easier.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 2
---

Each component group keeps track of a list of entities that have all the required [components]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}). 

![](/images/media/ecs-big-picture-w-compgroup.png)


The engine automatically updates this list every time that:

- A new entity is added to the engine
- An entity is removed from the engine
- An entity in the engine adds a new component
- An entity in the engine removes a component

> Note: Only entities that are added to the engine are eligible for component groups. Entities that have been created but not added to the engine, or that have been removed from the engine, aren't listed in any group.

After the group is created, you don't need to add or remove entities manually from it, the engine takes care of that.

```ts
const myGroup = engine.getComponentGroup(Transform)
```

[Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) typically iterate over the entities in these groups in their update method, performing the same operations on each. Having a predefined group of valid entities is a great way to save resources, specially for functions that run on every frame like `update()`. If on every frame your system would have to iterate over every single entity in the scene looking for the ones it needs, that would be very time consuming.

You can access the entities in a component group in the following way: if the group name is `myGroup`, calling `myGroup.entities` returns an array containing all the entities in it.

> Note: Keep in mind that component groups take up space in the local memory of the user's machine. Usually, the benefit in speed you get from having a group is a tradeoff that is well worth it. However, for cases where you'd have a large group that you don't access all that often, it might be better to not have one.

## Required components

When creating a component group, specify what components need to be present in every entity that's added to the group. You can list as many components as you want, the component group will only accept entities that have **all** of the listed components.

```ts
const myGroup = engine.getComponentGroup(Transform, Physics, NextPosition)
```

> Tip: If your scene includes several entities that have the same components, but you only want some of those in your component group, create a custom component to act as a [flag]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}#components-as-flags). This component doesn't need to have any properties in it. Add this component to the entities that you want the component group to handle.

## Use component groups in a system

```ts
const myGroup = engine.getComponentGroup(Transform, Physics)

export class PhysicsSystem implements ISystem {
  update() {
    for (let entity of myGroup.entities) {
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

- If the scene has several _ball_ entities, each with a `Position` and a `Physics` component, then they will be included in `myGroup`. `PhysicsSystem` will then update their position on every frame.

- If your scene also has other entities like a _hoop_ and a _scoreBoard_ that only have a `Physics` component, then they won't be in `myGroup` and won't be affected by `PhysicsSystem`.

## All entities

You can access the full list of entities that have been added to the engine, regardless of what components they have, through `engine.entities`.

```ts
engine.entities
```

## Change a component group while iterating

Component groups are mutable. You shouldn't modify the component group while you're iterating over it, because that could have unwanted consequences.

For example, if you iterate over a component group to remove each entity from the engine, the act of removing an entity displaces the other entities in the array, which can lead to some entities being skipped.

To overcome this problem, use the following code to remove all entities from the engine:

```ts
while (myGroup.entities.length) {
  engine.removeEntity(myGroup.entities[0])
}
```

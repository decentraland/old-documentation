---
date: 2018-01-15
title: Entities and components
description: Learn the essentials about entities and components in a Decentraland scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 2
---

Decentraland scenes that use 'ECS' are built around _entities_ and _components_.

## Overview

_Entities_ are the basic unit for building everything in Decentraland scenes. If you're familiar with web development, think of them as the equivalent of Elements in a DOM tree. All visible and invisible 3D objects and audio players in your scene will each be an entity. An entity is nothing more than a container in which to place components. The entity itself has no properties or methods of its own, it simply groups several components together.

_Components_ define the traits of an entity. For example, a `position` component stores the entity's coordinates. You might also add a `scale` component to modify an entity's default size, or create a custom `physics` component to store values for the entity's velocity and acceleration. Components only store data about their parent entity, they have no methods or behaviors.

[DIAGRAM : ENTITIY W COMPONENTS]

## XML syntax for entities and components

Quick sample and link to xml static scenes??

Explain there are two ways to declare entities and compnents: xml for static and code for dynamic

## TypeScript syntax for entities and components

const cube = new Entity()

cube.set(new Components.Position(5, 1, 5))

engine.addEntity(cube)

> Note: An entity and its components don't exist in your scene until you add the entity to the engine, as shown above.

## Nested entities

An entity can have other entities as children, these are affected by the components from the parent. Thanks to this, we can arrange entities into trees, just like the HTML of a webpage.

If a parent entity has components that position, scale or rotate it, its children entities are also affected. Position and rotation components consider the parent's as _0, 0, 0_. If the parent is scaled, all components of the child entities are also scaled in proportion.

[DIAGRAM : ENTITIY W children]

Invisible entities can be used as wrappers, these can handle multiple entities as a group.

[DIAGRAM : invisible ENTITIY W children]

syntax

example with nested entities

## Predefined components

The Decentraland ECS module includes a series of basic predefined components.

- Position
- Rotation
- Scale
- Transition
- Sound
- CylinderShapre
- PlaneShape
- BoxShape
- GLTFShape
- OBJShape

> Note: Each entity can have only one Shape component assigned to it.

See [Entity interfaces]({{ site.baseurl }}{% post_url /development-guide/2018-06-21-entity-interfaces %}) for a reference of all the available constructors for predefined entities and all of the supported components of each.

## Define a custom component

@Component('velocity')
export class Velocity extends Components.Vector {
constructor(x: number, y: number, z: number) {
super(x, y, z)
}
}

#### Attributes

#### Constructors

#### Default values

#### Inheritance

```ts
@Component("velocity")
export class Velocity extends Components.Vector {
  constructor(x: number, y: number, z: number) {
    super(x, y, z)
  }
}
```

## Changing component values

The values stored in all of the components that exist in the entities of the scene make up the _scene state_. When these values change, they change how the scene is rendered for the users.

All changes to the values in the components are carried out by [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-01-16-systems %}). Systems are completely decoupled from the components themselves. Entities and components simply store data, they are agnostic to what _systems_ are acting upon them.

## Components as flags

You may want to add a component that simply signals to a _componentSystem_ to handle this entity and not another.

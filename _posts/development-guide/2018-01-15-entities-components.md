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

Decentraland scenes that use the 'ECS' module are built around _entities_ and _components_.

_Entities_ are the basic unit for building everything in Decentraland scenes, think of them as the equivalent of Elements in a DOM tree in web development. All visible and invisible 3D objects and audio players in your scene will each be an entity. An entity is nothing more than a container in which to place components. The entity itself has no properties or methods of its own, it simply groups several components together.

_Components_ define the traits of an entity. For example, all entities have a `position` component that stores the entity's coordinates. You might also add a `color` component on an entity to store its color, or create a custom `physics` component to store values for the entity's weight, velocity and acceleration. A component only stores specific data about its parent entity, it has no methods of its own.

[DIAGRAM : ENTITIY W COMPONENTS]

The values stored in all the components of the scene represent the _scene state_.

The methods that change values in the components over time are completely decoupled from the entities and components. These methods are carried out by [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-01-16-systems %}). Entities and components simply store data and are completely agnostic to what _systems_ are acting upon them.

## Nesting entities

An entity can have other entities as children, these inherit the components from the parent. Thanks to this, we can arrange entities into trees, just like the HTML of a webpage.

If a parent entity is positioned, scaled or rotated by its components, its children entities are also affected.

[DIAGRAM : ENTITIY W children]

Invisible entities can be used as wrappers that only exist to handle multiple entities as a group.

[DIAGRAM : invisible ENTITIY W children]

## Predefined components

The Decentraland ECS module includes a series of basic predefined components. These don't need to be defined in your scene, and already include the necessary variables.

- position
- rotation
- scale
- transition
- sound
- cylinderShapre
- planeShape
- boxShape
- GLTFShape
- OBJShape

> Note: Each entity can have only one Shape component assigned to it.

See [Entity interfaces]({{ site.baseurl }}{% post_url /development-guide/2018-06-21-entity-interfaces %}) for a reference of all the available constructors for predefined entities and all of the supported components of each.

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

_Components_ define the traits of an entity. For example, a `transform` component stores the entity's coordinates, rotation and scale. A `BoxShape` component gives the entity a cube shape when rendered in the scene. You might also create a custom `physics` component to store values for the entity's velocity and acceleration.

[DIAGRAM : ENTITIY W COMPONENTS]

The values stored in all of the components that exist in the entities of the scene make up the _scene state_. When these values change, they change how the scene is rendered for the users.

Components are meant to only store data about their parent entity. All changes to the values in the components are carried out by [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-16-systems %}). Systems are completely decoupled from the components themselves. Entities and components are agnostic to what _systems_ are acting upon them.

See [Component Reference]() for a reference of all the available constructors for predefined entities and all of the supported components of each.

<!--
## XML syntax for entities and components

Quick sample and link to xml static scenes??

Explain there are two ways to declare entities and compnents: xml for static and code for dynamic

-->

## TypeScript syntax for entities and components

```ts
// Create an entity
const cube = new Entity()

// Create and apply a transform component to that entity
cube.set(new Transform())

// Set the fields in the component
cube.get(Transform).position.set(3, 1, 3)

// Add the entity to the engine
engine.addEntity(cube)
```

> Note: Entities and their components don't exist in your scene until you add the entities to the engine, as shown above.

## Nested entities

An entity can have other entities as children. Thanks to this, we can arrange entities into trees, just like the HTML of a webpage.

[DIAGRAM : ENTITIY W children]

To assign an entity as the parent of another, simply use the following syntax:

```ts
childEntity = new Entity()
parentEntity = new Entity()

childEntity.parent = parentEntity
```

If a parent entity has a `transform` component that affects its position, scale or rotation, its children entities are also affected.

- For **position**, the parent's center is _0, 0, 0_
- For **rotation** the parent's rotation is _0, 0, 0_
- For **scale**, the parent is considered to have a size of _1_. Any resizing of the parent affects scale and position in proportion.

Invisible entities can be used as wrappers, these can handle multiple entities as a group.

[DIAGRAM : invisible ENTITIY W children]

## Add a component to an entity

Add a component to an entity for its values to affect the entity.

You can create a new component and set it in one single expression, as shown below:

```ts
cube = new Entity()
cube.set(new Scale(0.1, 0.3, 0.1))
```

You can otherwise first create a component, and then set on to an entity in a separate expression:

```ts
cube = new Entity()
const nextPosComponent = new NextPos()
nextPosComponent.x = Math.random() * 10
cube.set(nextPosComponent)
```

## Access a component from an entity

Once a component is set in an entity, you can reference it through the parent entity.

```ts
cube = new Entity()
cube.set(new Transform())
scale = cube.get(Transform)
```

You can change the values in the fields of the component by accessing it this way.

```ts
scale = cube.get(Transform).scale.x = Math.random() * 10
```

## Define a custom component

If you need to store information about an entity that isn't handled by the default components of the SDK (see [component reference]() ), then you can create a custom type of component on your scene.

Custom components can be defined in your scene's `.ts` file.

Components can store as many fields as you want.

```ts
@Component("nextPos")
export class NextPos {
  x: number = 0
  y: number = 0
  z: number = 0
}

cube = new Entity()
const nextPosComponent = new NextPos()
nextPosComponent.x = 5
nextPosComponent.y = 3
nextPosComponent.z = 5
cube.set(nextPosComponent)
```

#### Constructors

You can add a constructor to your component, this allows you to set its values in the same expression as you instance it.

```ts
@Component("nextPos")
export class NextPos {
  x: number = 0
  y: number = 0
  z: number = 0
  constructor(number: x, number: y, number: z) {
    this.x = x
    this.y = y
    this.z = z
  }
}

cube = new Entity()
cube.set(new NextPos(5, 3, 5))
```

> Tip: If you use a source code editor, when instancing a component that has a constructor, you can see what the parameters are by mousing over the expression.
> [img]

You can make the parameters optional by setting default values on each. If there are default values and you don't declare the parameters when instancing a component, it will use the default.

```ts
@Component("nextPos")
export class NextPos {
  x: number = 0
  y: number = 0
  z: number = 0
  constructor(number: x = 5, number: y = 3, number: z = 5) {
    this.x = x
    this.y = y
    this.z = z
  }
}

cube = new Entity()
cube.set(new NextPos())
```

#### Inheritance

You can create a component that's based on an existing one and leverage all of its existing methods.

The following example defines a _Velocity_ component, which inherits its fields and methods from the already existing _Vector_ component.

```ts
@Component("velocity")
export class Velocity extends Components.Vector {
  constructor(x: number, y: number, z: number) {
    super(x, y, z)
  }
}
```

#### Interchangable components

You might want to define multiple different components where it only makes sense for each entity to have only one of these.

You can define multiple components that occupy a single _space_ on an entity.

For example, an entity can't have both BoxShape and PlaneShape, if you assign one, you overwrite the other. You can create custom components that follow this same behavior with each other.

To define components that share a same space, set the same name for the internal name:

```ts
@Component("animal")
export class Dog {
 (...)
}

@Component("animal")
export class Cat {
 (...)
}
```

## Components as flags

You may want to add a component that simply signals to a [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-16-systems %}) to handle this entity and not another. A component like this could have no data of its own.

```ts
@Component("flag")
export class flag {}
```

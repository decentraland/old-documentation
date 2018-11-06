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

Components are only meant to store data about their parent entity. All changes to the values in the components are carried out by [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-16-systems %}). Systems are completely decoupled from the components themselves. Entities and components are agnostic to what _systems_ are acting upon them.

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

Entities with no shape component are invisible in the scene, and these can be used as wrappers to handle and position multiple entities as a group.

## Add a component to an entity

Add a component to an entity for its values to affect the entity.

You can create a new component and set it in one single expression, as shown below:

```ts
cube = new Entity()
cube.set(new NextPos(1, 3, 1))
```

You can otherwise first create a component, and then set it onto an entity in a separate expression:

```ts
cube = new Entity()
const nextPosComponent = new NextPos()
nextPosComponent.x = 1
nextPosComponent.y = 3
nextPosComponent.z = 1
cube.set(nextPosComponent)
```

## Remove a component from an entity

To remove a component from an entity, simply use the entity's `remove()` method.

```ts
myEntity.remove(Material)
```

A removed component might still remain in memory even after removed.

If your scene adds new components and removes them regularly, these removed components will add up and cause memory problems. It's advisable to instead use an object pool.

If you try to remove a component that doesn't exist in the entity, this won't raise any errors.

## Access a component from an entity

Once a component is set in an entity, you can reference it through the parent entity using the `get` method.

```ts
// Create entity and component
cube = new Entity()
cube.set(new Transform())

// Using get
scale = cube.get(Transform)
```

The `get()` function fetches a reference to the component object, not a copy of its values. That means you are then free to change the component's values.

```ts
let XScale = cube.get(Transform).scale.x
XScale = Math.random() * 10
```

The example above directly modifies the value of the _x_ scale on the Transform component.

If you're not entirely sure if the entity will have the component you're trying to retrieve, you can use `getOrNull()` or `getOrCreate()`

```ts
//  getOrNull
scale = cube.getOrNull(Transform)

// getOrCreate
scale = cube.getOrCreate(Transform)
```

If the component you're trying to retrieve can't be found in the entity:

- When using `get()` it returns an error
- When using `getOrNull()` it returns `Null`

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
  constructor(x: number, y: number, z: number) {
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
  constructor(x: number = 5, y: number = 3, z: number = 5) {
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

#### Interchangeable components

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

## Pool entities and components

If you plan to spawn and despawn similar entities from your scene, it might be a good practice to keep a fixed set of entities in memory. Instead of creating and deleting these, you could add and remove these from the engine instead.

This is an efficient way to deal with your user's memory.

```ts
```

When adding an entity to the engine, its `alive` field is implicitly set to `true`, when removing it, this field is set to `false`.

While an entity isn't added to the engine, its geometry doesn't add up to the maximum triangle count four your scene.

This has the following benefits:

- If your entity uses a complex 3D model or texture, it might take the scene some time to load it from the content server. If the entity is already in memory, then that won't be necessary.
- If you add and remove entities constantly, entities that are removed from the engine might still remain in memory and add up over time till they become unmanageable. By reusing the same ones, you ensure this won't happen.

Similarly, if you plan to set and remove certain components from your entities, it's recommendable to create a pool of fixed components to add and remove rather than create new ones.

```ts
```

---
date: 2018-01-15
title: Entities and components
description: Learn the essentials about entities and components in a Decentraland scene
categories:
  - development-guide
redirect_from:
  - /sdk-reference/scene-state/
  - /sdk-reference/scene-content-guide/
  - /docs/entities
  - /sdk-reference/entity-interfaces/
  - /development-guide/scene-state/
  - /development-guide/scene-content/
  - /development-guide/entity-interfaces/
type: Document
---

Decentraland scenes are built around [_entities_, _components_ and _systems_](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system). This is a common pattern used in the architecture of several game engines, that allows for easy composability and scalability.

![]({{ site.baseurl }}/images/media/ecs-big-picture.png)

## Overview

_Entities_ are the basic unit for building everything in Decentraland scenes. All visible and invisible 3D objects and audio players in your scene will each be an entity. An entity is nothing more than a container that holds components. The entity itself has no properties or methods of its own, it simply groups several components together.

_Components_ define the traits of an entity. For example, a `transform` component stores the entity's coordinates, rotation and scale. A `BoxShape` component gives the entity a box shape when rendered in the scene, a `Material` component gives the entity a color or texture. You could also create a custom `health` component to store an entity's remaining health value, and add it to entities that represent non-player enemies in a game.

If you're familiar with web development, think of entities as the equivalent of _Elements_ in a _DOM_ tree, and of components as _attributes_ of those elements.

> Note: In previous versions of the SDK, the _scene state_ was stored in an object that was separate from the entities themselves. As of version 5.0, the _scene state_ is directly embodied by the components that are used by the entities in the scene.

<img src="{{ site.baseurl }}/images/media/ecs-components.png" alt="Armature" width="400"/>

Components like `Transform`, `Material` or any of the _shape_ components are closely tied in with the rendering of the scene. If the values in these components change, that alone is enough to change how the scene is rendered in the next frame.

Components are meant to store data about their parent entity. They only store this data, they shouldn't modify it themselves. All changes to the values in the components are carried out by [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}). Systems are completely decoupled from the components and entities themselves. Entities and components are agnostic to what _systems_ are acting upon them.

See [Component Reference](https://github.com/decentraland/ecs-reference) for a reference of all the available constructors for predefined components.

## Syntax for entities and components

Entities and components are declared as TypeScript objects. The example below shows some basic operations of declaring, configuring and assigning these.

```ts
// Create an entity
const box = new Entity()

// Create and add a `Transform` component to that entity
box.addComponent(new Transform())

// Set the fields in the component
box.getComponent(Transform).position.set(3, 1, 3)

// Create and apply a `BoxShape` component to give the entity a visible form
box.addComponent(new BoxShape())

// Add the entity to the engine
engine.addEntity(box)
```

## Add entities to the engine

When you create a new entity, you're instancing an object and storing it in memory. A newly created entity isn't _rendered_ and it won't be possible for a player to interact with it until it's added to the _engine_.

The engine is the part of the scene that sits in the middle and manages all of the other parts. It determines what entities are rendered and how players interact with them. It also coordinates what functions from [systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) are executed and when.

```ts
// Create an entity
const box = new Entity()

// Give the entity a shape
box.addComponent(new BoxShape())

// Add the entity to the engine
engine.addEntity(box)
```

In the example above, the newly created entity isn't viewable by players on your scene until it's added to the engine.

> Note: Entities aren't added to [Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}) either until they are added to the engine.

It’s sometimes useful to preemptively create entities and not add them to the engine until they are needed. This is especially true for entities that have elaborate geometries that might otherwise take long to load.

When an entity is added to the engine, its `alive` property is implicitly set to _true_. You can check if an entity is currently added to the engine via this property.

```ts
if (myEntity.alive) {
  log("the entity is added to the engine")
}
```

> Note: It's always recommended to add a `Transform` component to an entity before adding it to the engine. Entities that don't have a Transform component are rendered in the _(0, 0, 0)_ position of the scene, so if the entity is added before it has a `Transform`, it will be momentarily rendered in that position, and with its original size and rotation.

## Remove entities from the engine

Entities that have been added to the engine can also be removed from it. When an entity is removed, it stops being rendered by the scene and players can no longer interact with it.

```ts
// Remove an entity from the engine
engine.removeEntity(box)
```

Note: Removed entities are also removed from all [Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}).

If your scene has a pointer referencing a removed entity, it will remain in memory, allowing you to still access and change its component's values and add it back.

If a removed entity has child entities, all children of that entity are removed too.

## Nested entities

An entity can have other entities as children. Thanks to this, we can arrange entities into trees, just like the HTML of a webpage.

<img src="{{ site.baseurl }}/images/media/ecs-nested-entities.png" alt="nested entities" width="400"/>

To set an entity as the parent of another, simply use `.setParent()`:

```ts
// Create entities
const parentEntity = new Entity()
engine.addEntity(parentEntity)

const childEntity = new Entity()

// Set parent
childEntity.setParent(parentEntity)
```

> Note: Child entities should not be explicitly added to the engine, as they are already added via their parent entity.

Once a parent is assigned, it can be read off the child entity with `.getParent()`.

```ts
// Get parent from an entity
const parent = childEntity.getParent()
```

<!--
You can also iterate over an entity's children in the following way.

```ts
// Get the first child listed in the library
for(let id in parent.children){
  const child = parent.children[id]
  // do something with the child entity
}
```

> Note: `.children` returns a library that lists all the child entities.
-->

If a parent entity has a `transform` component that affects its position, scale or rotation, its children entities are also affected.

- For **position**, the parent's center is _0, 0, 0_
- For **rotation** the parent's rotation is the quaternion _0, 0, 0, 1_ (equivalent to the Euler angles _0, 0, 0_)
- For **scale**, the parent is considered to have a size of _1_. Any resizing of the parent affects scale and position in proportion.

Entities with no shape component are invisible in the scene. These can be used as wrappers to handle and position multiple entities as a group.

To remove an entity's parent, you can assign the entity's parent to `null`.

```ts
childEntity.setParent(null)
```

If you set a new parent to an entity that already had a parent, the new parent will overwrite the old one.

## Get an entity by ID

Every entity in your scene has a unique autogenrated _id_ property. You can retrieve a specific entity from the engine based on this ID, by referring to the `engine.entities[]` array.

```typescript
engine.entities[entityId]
```

For example, if a player's click or a raycast hits an entity, this will return the id of the hit entity, and you can use the command above to fetch the entity that matches that id.

## Add a component to an entity

When a component is added to an entity, the component's values affect the entity.

One way of doing this is to first create the component instance, and then add it to an entity in a separate expression:

```ts
// Create entity
const box = new Entity()
engine.addEntity(box)

// Create component
const myMaterial = new Material()

// Configure component
myMaterial.albedoColor = Color3.Red()

// Add component
box.addComponent(myMaterial)
```

You can otherwise use a single expression to both create a new instance of a component and add it to an entity:

```ts
// Create entity
const box = new Entity()
engine.addEntity(box)

// Create and add component
box.addComponent(new Material())

// Configure component
box.getComponent(Material).albedoColor = Color3.Red()
```

> Note: In the example above, as you never define a pointer to the entity's material component, you need to refer to it through its parent entity using `.getComponent()`.

#### Add or replace a component

By using `.addComponentOrReplace()` instead of `.addComponent()` you overwrite any existing components of the same kind on a specific entity.

## Remove a component from an entity

To remove a component from an entity, simply use the entity's `removeComponent()` method.

```ts
myEntity.removeComponent(Material)
```

If you attempt to remove a component that doesn't exist in the entity, this action won't raise any errors.

A removed component might still remain in memory even after removed. If your scene adds new components and removes them regularly, these removed components will add up and cause memory problems. It's advisable to instead use an [object pool](#pooling-entities-and-components) when possible to handle these components.

## Access a component from an entity

You can reach components through their parent entity by using the entity's `.getComponent()` function.

```ts
// Create entity and component
const box = new Entity()

// Create and add component
box.addComponent(new Transform())

// Using get
let transform = box.getComponent(Transform)

// Edit values in the component
transform.position = new Vector3(5, 0, 5)
```

The `getComponent()` function fetches a reference to the component object. If you change the values of what's returned by this function, you're changing the component itself. For example, in the example above, we're setting the `position` stored in the component to _(5, 0, 5)_.

```ts
box.getComponent(Transform).scale.x = Math.random() * 10
```

The example above directly modifies the value of the _x_ scale on the Transform component.

If you're not entirely sure if the entity does have the component you're trying to retrieve, use `getComponentOrNull()` or `getComponentOrCreate()`

```ts
//  getComponentOrNull
let scale = box.getComponentOrNull(Transform)

// getComponentOrCreate
let scale = box.getComponentOrCreate(Transform)
```

If the component you're trying to retrieve doesn't exist in the entity:

- `getComponent()` returns an error.
- `getComponentOrNull()` returns `Null`.
- `getComponentOrCreate()` instances a new component in its place and retrieves it.

When you're dealing with [Interchangeable component](#interchangeable-components), you can also get a component by _space name_ instead of by type. For example, both `BoxShape` and `SphereShape` occupy the `shape` space of an entity. If you don't know which of these an entity has, you can fetch the `shape` of the entity, and it will return whichever component is occupying the `shape` space.

```ts
let entityShape = myEntity.getComponent(shape)
```

## Pooling entities and components

If you plan to spawn and despawn similar entities from your scene, it's often a good practice to keep a fixed set of entities in memory. Instead of creating new entities and deleting them, you could add and remove existing entities from the engine. This is an efficient way to deal with the player's memory.

Entities that are not added to the engine aren't rendered as part of the scene, but they are kept in memory, making them quick to load if needed. Their geometry doesn't add up to the maximum triangle count four your scene while they aren't being rendered.

```ts
// Define spawner singleton object
const spawner = {
  MAX_POOL_SIZE: 20,
  pool: [] as Entity[],

  spawnEntity() {
    // Get an entity from the pool
    const ent = spawner.getEntityFromPool()

    if (!ent) return

    // Add a transform component to the entity
    let t = ent.getComponentOrCreate(Transform)
    t.scale.setAll(0.5)
    t.position.set(5, 0, 5)

    //add entity to engine
    engine.addEntity(ent)
  },

  getEntityFromPool(): Entity | null {
    // Check if an existing entity can be used
    for (let i = 0; i < spawner.pool.length; i++) {
      if (!spawner.pool[i].alive) {
        return spawner.pool[i]
      }
    }
    // If none of the existing are available, create a new one, unless the maximum pool size is reached
    if (spawner.pool.length < spawner.MAX_POOL_SIZE) {
      const instance = new Entity()
      spawner.pool.push(instance)
      return instance
    }
    return null
  },
}

spawner.spawnEntity()
```

When adding an entity to the engine, its `alive` field is implicitly set to `true`, when removing it, this field is set to `false`.

Using an object pool has the following benefits:

- If your entity uses a complex 3D model or texture, it might take the scene some time to load it from the content server. If the entity is already in memory when it's needed, then that delay won't happen.
- This is a solution to avoid a common problem, where each entity that's removed could remain lingering in memory after being removed, and these unused entities could add up till they become too many to handle. By recycling the same entities, you ensure this won't happen.

<!--
Similarly, if you plan to set and remove certain components from your entities, it's recommendable to create a pool of fixed components to add and remove rather than create new component instances each time.

```ts
```
-->

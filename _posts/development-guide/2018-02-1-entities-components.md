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
set: development-guide
set_order: 1
---

Decentraland scenes are built around [_entities_, _components_ and _systems_](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system). This is a common pattern used the architecture of several game engines, that allows for easy composability and scalability.

![](/images/media/ecs-big-picture.png)

## Overview

_Entities_ are the basic unit for building everything in Decentraland scenes. All visible and invisible 3D objects and audio players in your scene will each be an entity. An entity is nothing more than a container that holds components. The entity itself has no properties or methods of its own, it simply groups several components together.

_Components_ define the traits of an entity. For example, a `transform` component stores the entity's coordinates, rotation and scale. A `BoxShape` component gives the entity a cube shape when rendered in the scene, a `Material` component gives the entity a color or texture. You could also create a custom `health` component to store an entity's remaining health value, and add it to entities that represent non-player enemies in a game.

If you're familiar with web development, think of entities as the equivalent of _Elements_ in a _DOM_ tree, and of components as _attributes_ of those elements.

> Note: In previous versions of the SDK, the _scene state_ was stored in an object that was separate from the entities themselves. As of version 5.0, the _scene state_ is directly embodied by the components that are used by the entities in the scene.

![](/images/media/ecs-components.png)

Components like `Transform`, `Material` or any of the _shape_ components are closely tied in with the rendering of the scene. If the values in these components change, that alone is enough to change how the scene is rendered in the next frame.

Components are meant to store data about their parent entity. They only store this data, they shouldn't modify it themselves. All changes to the values in the components are carried out by [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}). Systems are completely decoupled from the components and entities themselves. Entities and components are agnostic to what _systems_ are acting upon them.

See [Component Reference]() for a reference of all the available constructors for predefined components.


## Syntax for entities and components

Entities and components are declared as TypeScript objects. The example below shows some basic operations of declaring, configuring and assigning these.

```ts
// Create an entity
const cube = new Entity()

// Create and add a `Transform` component to that entity
cube.add(new Transform())

// Set the fields in the component
cube.get(Transform).position.set(3, 1, 3)

// Create and apply a `CubeShape` component to give the entity a visible form
cube.add(new CubeShape())

// Add the entity to the engine
engine.addEntity(cube)
```

Note: It's also possible to declare entities and components in [XML]({{ site.baseurl }}{% post_url /development-guide/2018-01-13-xml-static-scenes %}). Writing a scene in this way is easier but very limiting. You can't make the entities in the scene move or be interactive in any way.

## Add entities to the engine

When you create a new entity, you're instancing an object and storing it in memory. A newly created entity isn't _rendered_ and it won't be possible for a user to interact with it until it's added to the _engine_.

The engine is the part of the scene that sits in the middle and manages all of the other parts. It determines what entities are rendered and how users interact with them. It also coordinates what functions from [systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) are executed and when.

```ts
// Create an entity
const cube = new Entity()

// Give the entity a shape
cube.add(new CubeShape())

// Add the entity to the engine
engine.addEntity(cube)
```

In the example above, the newly created entity isn't viewable by users of your scene until it's added to the engine.

> Note: Entities aren't added to [Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}) either until they are added to the engine.

It’s sometimes useful to preemptively create entities and not add them to the engine until they are needed. This is especially true for entities that have elaborate geometries that might otherwise take long to load.

When an entity is added to the engine, its `alive` property is implicitly set to _true_. You can check if an entity is currently added to the engine via this property.

```ts
if (myEntity.alive) {
  log("the entity is added to the engine")
}
```

## Remove entities from the engine

Entities that have been added to the engine can also be removed from it. When an entity is removed, it stops being rendered by the scene and users can no longer interact with it.

```ts
// Remove an entity from the engine
engine.removeEntity(cube)
```

Note: Removed entities are also removed from all [Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}). 

If your scene has a pointer referencing a removed entity, it will remain in memory, allowing you to still access and change its component's values and add it back.

If a removed entity has child entities, you can determine what to do with them through the optional second and third arguments of the `.removeEntity()` function.

- `removeChildren`: Boolean to determine whether child entities are removed too. _false_ by default.
- `newParent`: Set a new parent entity for all children of the removed entity.

```ts
/* These are the arguments being used:
 - Entity to remove: cube
 - removeChildren: false
 - newParent: cube2
*/
engine.removeEntity(cube, false, cube2)
```

> Note: Keep in mind that the position, rotation and scale of a child entity is always relative to their parent. If the children of an entity aren't removed together with the parent, they will now be positioned relative to the scene (or to their new parent entity).

## Nested entities

An entity can have other entities as children. Thanks to this, we can arrange entities into trees, just like the HTML of a webpage.

![](/images/media/ecs-nested-entities.png)

To set an entity as the parent of another, simply use `.setParent()`:

```ts
// Create entities
childEntity = new Entity()
parentEntity = new Entity()

// Set parent
childEntity.setParent(parentEntity)
```

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

## Add a component to an entity

When a component is added to an entity, the component's values affect the entity.

One way of doing this is to first create the component instance, and then add it to an entity in a separate expression:

```ts
// Create entity
cube = new Entity()

// Create component
const myMaterial = new Material()

// Configure component
myMaterial.albedoColor = Color3.Red()

// Add component
cube.add(myMaterial)
```

You can otherwise use a single expression to both create a new instance of a component and add it to an entity:

```ts
// Create entity
cube = new Entity()

// Create and add component
cube.add(new Material())

// Configure component
cube.get(Material).albedoColor = Color3.Red()
```

> Note: In the example above, as you never define a pointer to the entity's material component, you need to refer to it through its parent entity using `.get()`.

#### set or add

You can add a component to an entity either through `.set()` or `.add()`. The only difference between them is that a component assigned with `.set()` is overwritten whenever a component of the same kind is assigned to the entity.

A component assigned with `.add()` can't be overwritten like that. To change it, you must first remove it before assigning a replacement component.

For example, if you first do `.set(new BoxShape())` on an entity entity and then do `.set(nwe SphereShape())` to the same entity, the shape will be overwritten. If you instead use `.add()` to assign the first shape, it won't be possible to overwrite it.

## Remove a component from an entity

To remove a component from an entity, simply use the entity's `remove()` method.

```ts
myEntity.remove(Material)
```

A removed component might still remain in memory even after removed. If your scene adds new components and removes them regularly, these removed components will add up and cause memory problems. It's advisable to instead use an [object pool](#pooling-entities-and-components) when possible to handle these components.

If you try to remove a component that doesn't exist in the entity, this action won't raise any errors.

If a component was added using `.set()`, then it can be overwritten directly by a component of the same category, without needing to remove it first.

## Access a component from an entity

You can reach components through their parent entity by using the entity's `.get()` function.

```ts
// Create entity and component
cube = new Entity()

// Create and add component
cube.add(new Transform())

// Using get
let transform = cube.get(Transform)

// Edit values in the component
transform.position = (5, 0, 5)
```

The `get()` function fetches a reference to the component object. If you change the values of what's returned by this function, you're changing the component itself. For example, in the example above, we're setting the `position` stored in the component to _(5, 0, 5)_.

```ts
let XScale = cube.get(Transform).scale.x
XScale = Math.random() * 10
```

The example above directly modifies the value of the _x_ scale on the Transform component.

If you're not entirely sure if the entity does have the component you're trying to retrieve, use `getOrNull()` or `getOrCreate()`

```ts
//  getOrNull
scale = cube.getOrNull(Transform)

// getOrCreate
scale = cube.getOrCreate(Transform)
```

If the component you're trying to retrieve doesn't exist in the entity:

- `get()` returns an error.
- `getOrNull()` returns `Null`.
- `getOrCreate()` instances a new component in its place and retrieves it.

## Custom components

If you need to store information about an entity that isn't handled by the default components of the SDK (see [component reference]() ), then you can create a custom type of component on your scene.

Tip: Custom components can be defined in your scene's `.ts` file, but for larger projects we recommend defining them in a separate `ts` file and importing them.

A component can store as many fields as you want.

```ts
@Component('wheelSpin')
export class WheelSpin {
  spinning: boolean
  speed: number
}
```

Note that we're defining two names for the component: `wheelSpin` and `WheelSpin` in this case. The class name, the one in upper case, is the one you use to add the component to entities. The other name, the one in lowe case, can mostly be ignored, except if you want to use it as an [Interchangeable component](#interchangeable-components).

Once defined, you can use the component in the entities of your scene:

```ts
// Create entities
wheel = new Entity()
wheel2 = new Entity()

// Create instances of the component
wheel.add(new WheelSpin())
wheel2.add(new WheelSpin())

// Set values on component
wheel.get(WheelSpin).spinning = true
wheel.get(WheelSpin).speed = 10
wheel2.get(WheelSpin).spinning = false
```

Each entity that has the component added to it is instancing a new copy of it, holding specific data for that entity.


#### Constructors

Adding a constructor to a component allows you to configure its values in the same expression as you create an instance of it.

```ts
@Component('wheelSpin')
export class WheelSpin {
  spinning: boolean
  speed: number
  constructor(spinning: boolean, speed: number) {
    this.spinning = spinning
    this.speed = speed
  }
}
```

If the component includes a constructor, you can use the following syntax:

```ts
// Create entity
wheel = new Entity()

// Create instance of component and set its values
wheel.add(new WheelSpin(true, 10))
```

> Tip: If you use a source code editor, when instancing a component that has a constructor, you can see what the parameters are by mousing over the expression.

<!-- img -->

You can make the parameters optional by setting default values on each. If there are default values and you don't declare the parameters when instancing a component, it will use the default.

```ts
@Component('wheelSpin')
export class WheelSpin {
  spinning: boolean
  speed: number
  constructor(spinning?: boolean = false, speed?: number = 3) {
    this.spinning = spinning
    this.speed = speed
  }
}
```
```ts
// Create entity
wheel = new Entity()

// Create instance of component with default values
wheel.add(new WheelSpin())
```

#### Inheritance from other components

You can create a component that's based on an existing one and leverage all of its existing methods and fields.

The following example defines a _Velocity_ component, which inherits its fields and methods from the already existing _Vector3_ component.

```ts
@Component("velocity")
export class Velocity extends Vector3 {
  // x, y and z fields are inherited from Vector
  constructor(x: number, y: number, z: number) {
    super(x, y, z)
  }
}
```

#### Interchangeable components

Certain components intentionally can't coexist in a single entity. For example, an entity can't have both `BoxShape` and `PlaneShape`. If you assign one using `.set()`, you overwrite the other if present.

You can create custom components that follow this same behavior against each other, where it only makes sense for each entity to have only one of them assigned.

To define components that are interchangeable and that occupy a same _space_ in an entity, set the same name for both on the component's internal name:

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

In the example above, note that both components occupy the _animal_ space. Each entity in the scene can only have one _animal_ component assigned.

If you use `.set()` to assign a _Dog_ component to an entity that has a _Cat_ component, then the _Dog_ component will overwrite the _Cat_ component.

## Components as flags

You may want to add a component that simply flags an entity to differentiate it from others, without using it to store any data. 

This is especially useful when using [Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}). Since component groups list entities based on components they own, a simple flag component can tell entities apart from others.

```ts
@Component("myFlag")
export class MyFlag {}
```

## Pooling entities and components

If you plan to spawn and despawn similar entities from your scene, it's often a good practice to keep a fixed set of entities in memory. Instead of creating new entities and deleting them, you could add and remove existing entities from the engine. This is an efficient way to deal with your user's memory.

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
    let t = ent.getOrCreate(Transform)
    t.scale.setAll(0.5)
    t.position = (5, 0, 5)

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
  }
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
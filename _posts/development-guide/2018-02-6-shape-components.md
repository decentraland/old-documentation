---
date: 2018-02-6
title: Shape components
description: Learn about the different components that give entities their 3D shape and collision.
categories:
  - development-guide
type: Document
---

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an _entity_, and each entity can include _components_ that shape its characteristics and functionality.

The rendered shape of an entity is determined by what component it uses. Each entity can have only one shape component assigned to it.

<img src="{{ site.baseurl }}/images/media/ecs-simple-components.png" alt="nested entities" width="400"/>

## Primitive shapes

Several basic shapes, often called _primitives_, can be added to an entity.

The following primitive shape components are available:

- `BoxShape`
- `SphereShape`
- `PlaneShape`
- `CylinderShape`
- `ConeShape`

Each of these components has certain fields that are specific to that shape, for example the _cylinder_ shape has `arc`, `radiusTop`, `radiusBottom`, etc.

To apply a component to an entity, you can instance a new component and assign it all in one operation:

```ts
myEntity.addComponent(new SphereShape())
```

Or you can first create the component instance and then assign it to the entity.

```ts
let sphere = new SphereShape()
myEntity.addComponent(sphere)
```

Primitive shapes don't include materials. To give it a color or a texture, you must assign a [material component]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}) to the same entity.

## 3D models

For more complex shapes, you can build a 3D model in an external tool like Blender and then import them in _.glTF_ or _.glb_ (binary _.glTF_). [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

To add an external model into a scene, add a `GLTFShape` component to an entity and set its `src` to the path of the glTF file containing the model.

```ts
myEntity.addComponent(new GLTFShape("models/House.gltf"))
```

Since the `src` field is required, you must give it a value when constructing the component.

In the example above, the model is located in a `models` folder at root level of the scene project folder.

> Tip: We recommend keeping your models separate in a `/models` folder inside your scene.

glTF models can include their own embedded textures, materials, colliders and animations. See [3D models]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %}) for more information on this.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

#### Free libraries for 3D models

Instead of building your own 3d models, you can also download them from several free or paid libraries.

To get you started, below is a list of libraries that have free or relatively inexpensive content:

- [Assets from the Builder](https://github.com/decentraland/builder-assets/tree/master/assets)
- [Google Poly](https://poly.google.com)
- [SketchFab](https://sketchfab.com/)
- [Clara.io](https://clara.io/)
- [Archive3D](https://archive3d.net/)
- [SketchUp 3D Warehouse](https://3dwarehouse.sketchup.com/)
- [Thingiverse](https://www.thingiverse.com/) (3D models made primarily for 3D printing, but adaptable to Virtual Worlds)
- [ShareCG](https://www.sharecg.com/)
- [CGTrader](https://www.cgtrader.com/)

> Note: Pay attention to the license restrictions that the content you download has.

Note that in several of these sites, you can choose what format to download the model in. Always choose _.glTF_ format if available. If not available, you must convert them to _glTF_ before you can use them in a scene. For that, we recommend importing them into Blender.

## Collisions

Entities that have collisions enabled occupy space and block a player's path, entities without collisions can be walked through by a player`s avatar.

Collision settings currently don't affect how other entities interact with each other, entities can always overlap. Collision settings only affect how the entity interacts with the player's avatar.

Decentraland currently doesn't have a physics engine, so if you want entities to fall, crash or bounce, you must code this behavior into the scene.

Entities don't use collisions by default. Depending on the type of the shape component it has, collisions are enabled as follows:

- For _primitive_ shapes (boxes, spheres, planes etc), you enable collisions by setting the `withCollisions` field of the shape component to _true_.

  This example defines a box entity that can't be walked through.

  ```ts
  let box = new BoxShape()
  box.withCollisions = true
  myEntity.addComponent(box)
  ```

  > Note: Planes only block movement in one direction.

- To use collisions in a _glTF_ shape, you can either:

  - Overlay an invisible entity with a primitive shape and the `withCollisions` field set to _true_.
  - Edit the model in an external tool like Blender to include a _collider object_. The collider must be named _x_collider_, where _x_ is the name of the model. So for a model named _house_, the collider must be named _house_collider_.

A _collider_ is a set of geometric shapes or planes that define which parts of the model are collided with. This allows for much greater control and is a lot less demanding on the system, as the collision object is usually a lot simpler (with less vertices) than the original model.

See [3D models]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %}) for more details on how to add colliders to a 3D model.

## Pointer blocking

All shapes block player [button events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}) by default, so that for example a player can't click through a wall, or pick something up that is locked inside a chest.

You can however disable this behavior on any shape, no matter if it's a primitive or an imported 3D model.

To do so, set the `isPointerBlocker` property of the shape component to _false_.

```ts
let box = new BoxShape()
box.isPointerBlocker = false
myEntity.addComponent(box)
```

By using this property, you could for example have an invisible wall that players can't walk through, but that does allow them to click on items on the other side of the wall.

## Make invisible

You can make an entity invisible by setting the `visible` field in its shape component. Doing this is especially useful when using the shape as a collider.

All components for primitive shape and 3D models are visible by default.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())
myEntity.getComponent(BoxShape).visible = false
```

If an entity is invisible, its collider can block a player's path, but it can't be clicked. To make an entity that's both invisible and clickable, keep the `visible` property set to _true_, and instead give it a [material]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}#pooling-entities-and-components) with 100% transparency.

## Optimize 3D models

To ensure that 3D models in your scene load faster and take up less memory, follow these best practices:

- Save your models in _.glb_ format, which is a lighter version of _.gltf_.
- If you have multiple models that share the same textures, export your models with textures in a separate file. That way multiple models can refer to a single texture file that only needs to be loaded once.
- If you have multiple entities using the same 3D model, instance a single `GLTFShape` component and assign that same one to the entities that will use it.
- If your scene has entities that appear and disappear, it might be a good idea to pool these entities and keep them already defined but removed from the engine until needed. This will help them appear faster, the trade-off is that they will occupy memory when not in use. See [entities and components]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}#pooling-entities-and-components)

## Reuse shapes

If multiple entities in your scene use a same primitive or 3D model, there's no need to create an instance of the shape component for each. All entities can share one same instance.

This keeps your scene lighter to load and prevents you from exceeding the [maximum amount]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}) of _bodies_ per scene.

> Note: Reused shapes are added to the _triangle_ count of the scene. So it is possible to exceed the triangle limit by reusing shapes.

```ts
// Create shape component
const house = new GLTFShape("models/House.gltf")

// Create entities
const myEntity = new Entity()
const mySecondEntity = new Entity()
const myThirdEntity = new Entity()

// Assign shape component to entities
myEntity.addComponent(house)
mySecondEntity.addComponent(house)
myThirdEntity.addComponent(house)
```

Each entity that shares a shape can apply different scales, rotations or even materials (in the case of primitives) without affecting how the other entities are being rendered.

Entities that share a 3D model instance can also have animations that run independently of each other. Each must have a separate `Animator` component, with separate `AnimationState` objects to keep track of what part of the animation is currently being played. See [3D model animations]({{ site.baseurl }}{% post_url /development-guide/2018-02-13-3d-model-animations %})

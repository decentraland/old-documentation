---
date: 2018-02-17
title: Shape components
description: Learn about the different components that give entities their 3D shape and collision.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 3
---

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an _entity_, and each entity can include _components_ that shape its characteristics and functionality.

The rendered shape of an entity is determined by what component it uses.

Each entity can have only one shape component assigned to it. If you assign a shape component to an entity that already had one, it will overwrite it.

## Primitive shapes

Several basic shapes, often called _primitives_, can be added to an entity.

The following primitive shape components are available:

- `BoxShape`
- `SphereShape`
- `PlaneShape`
- `CylinderShape`
- `ConeShape`

Each of these components has certain fields that are specific to that shape, for example the _cylinder_ shape has `arc`, `radiusTop`, `radiusBottom`, etc.

See [Component reference]() for more details on the fields available on each component.

To apply a component to an entity, you can instance a new component and assign it all in one operation:

```ts
myEntity.set(new SphereShape())
```

Or you can first create the component instance and then assign it to the entity.

```ts
let shpere = new SphereShape()
myEntity.set(sphere)
```

Primitive shapes don't include materials. To give it a color or a texture, you must assign a [material component]() to the same entity.

## Import 3D models

For more complex shapes, you can build a 3D model in an external tool like Blender and then import them in _glTF_ format. [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

To add an external model into a scene, add a `GLTFShape` component to an entity and set its `src` to the path of the glTF file containing the model.

> Note: 3D models in _.obj_ format are also supported, but will might not be supported for much longer. To add one, create an `OBJShape` component instead. Note that _.obj_ models don't support animations and other features.

```ts
myEntity.set(new GLTFShape("models/House.gltf"))
```

Since the `src` field is required, you must give it a value when constructing the component.

In the example above, the model is located in a `models` folder at root level of the scene project folder.

> Tip: We recommend keeping your models separate in a `/models` folder inside your scene.

glTF models can include their own embedded textures, materials, colliders and animations. See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for more information on this.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

#### Free libraries for 3D models

Instead of building your own 3d models, you can also download them from several free or paid libraries.

To get you started, below is a list of libraries that have free or relatively inexpensive content:

- [Google Poly](https://poly.google.com)
- [SketchFab](https://sketchfab.com/)
- [Clara.io](https://clara.io/)
- [Archive3D](https://archive3d.net/)
- [SketchUp 3D Warehouse](https://3dwarehouse.sketchup.com/)
- [Thingiverse](https://www.thingiverse.com/) (3D models made primarily for 3D printing, but adaptable to Virtual Worlds)
- [ShareCG](https://www.sharecg.com/)

> Note: Pay attention to the licence restrictions that the content you download has.

Note that in several of these sites, you can choose what format to download the model in. Always choose _.glTF_ format if available. If not available, you must convert them to _glTF_ before you can use them in a scene. For that, we recommend importing them into Blender and exporting them with one of the available _glTF_ export add-ons.

## Collisions

Entities that have collisions enabled occupy space and block a user's path, entities without collisions can be walked through by a user`s avatar.

Collision settings currently don't affect how other entities interact with each other, entities can always overlap. Collision settings only affect how the entity interacts with the user's avatar.

Decentraland currently doesn't have a physics engine, so if you want entities to fall, crash or bounce, you must code this behavior into the scene.

> Tip: To view the limits of all collider meshes in the scene, launch your scene preview with `dcl start` and then click `c`. This draws blue lines that delimit all colliders in place.

Entities don't use collisions by default. Depending on the type of the shape component it has, collisions are enabled as follows:

- For _primitive_ shapes (boxes, spheres, planes etc), you enable collisions by setting the `withCollisions` field of the shape component to _true_.

  > Note: Planes only block movement in one direction.

      ```ts
      let box = new BoxShape()
      box.withCollisions = true
      myEntitiy.set(box)
      ```


      The example above defines a box entity that can't be walked through.

- To use collisions in a _glTF_ shape, you can either:

  - Overlay an invisible entity with a primitive shape and the `withCollisions` field set to _true_.
  - Edit the model in an external tool like Blender to include a _collider object_. The collider must be named _x_collider_, where _x_ is the name of the model. So for a model named _house_, the collider must be named _house_collider_.

A _collider_ is a set of geometric shapes or planes that define which parts of the model are collided with. This allows for much greater control and is a lot less demanding on the system, as the collision object is usually a lot simpler (with less vertices) than the original model.

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for more details on how to add colliders to a 3D model.

## Text blocks

## Reuse shapes

If multiple entities in your scene use a same primitive or 3D model, there's no need to create an instance of the shape component for each. All entities can share one same instance, this keeps your scene lighter to load and prevents you from exceeding the maximum amount of triangles per scene.

```ts
// Create shape component
const house = new GLTFShape("models/House.gltf"

// Create entities
const myEntity = new Entity()
const mySecondEntity = new Entity()
const myThirdEntity = new Entity()

// Assign shape component to entities
myEntity.set(house)
mySecondEntity.set(house)
myThirdEntity.set(house)
```
---
date: 2018-02-6
title: Shape components
description: Learn about the different components that give entities their 3D shape and collision.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 6
---

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an _entity_, and each entity can include _components_ that shape its characteristics and functionality.

The rendered shape of an entity is determined by what component it uses. Each entity can have only one shape component assigned to it.

<img src="/images/media/ecs-simple-components.png" alt="nested entities" width="400"/>


## Primitive shapes

Several basic shapes, often called _primitives_, can be added to an entity.

The following primitive shape components are available:

- `BoxShape`
- `SphereShape`
- `PlaneShape`
- `CylinderShape`
- `ConeShape`

Each of these components has certain fields that are specific to that shape, for example the _cylinder_ shape has `arc`, `radiusTop`, `radiusBottom`, etc.

See [Component reference](https://github.com/decentraland/ecs-reference) for more details on the fields available on each component.

To apply a component to an entity, you can instance a new component and assign it all in one operation:

```ts
myEntity.addComponent(new SphereShape())
```

Or you can first create the component instance and then assign it to the entity.

```ts
let shpere = new SphereShape()
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

glTF models can include their own embedded textures, materials, colliders and animations. See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for more information on this.

Keep in mind that all models, their shaders and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}).

> Note: 3D models in _.obj_ format are also supported, but less encouraged. To add one, create an `OBJShape` component instead. Note that _.obj_ models don't support animations and other features.

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

_primitive_ shapes (boxes, spheres, planes etc), have collisions already built into them. An imported _glTF_ or _glb_ model must have a collider geometry in it for collisions to work.

> Note: Collision settings currently don't affect how other entities interact with each other, entities can always overlap. Collision settings only affect how the entity interacts with the user's avatar. Decentraland currently doesn't have a physics engine, so if you want entities to fall, crash or bounce, you must code this behavior into the scene.


<!--
> Tip: To view the limits of all collider meshes in the scene, launch your scene preview with `dcl start` and then click `c`. This draws blue lines that delimit all colliders in place.
-->

#### Disable collisions

To turn off collisions, either in a primitive shape or a GLTF model, set the `withCollisions` field in the shape component to _false_. 

This example defines a box entity that can be walked through.

```ts
let box = new BoxShape()
box.withCollisions = false
myEntity.addComponent(box)
```
> Note: Planes only block movement in one direction. 

#### Add colliders to a model

A _collider_ is a set of geometric shapes or planes that define which parts of the model are collided with. This allows for much greater control and is a lot less demanding on the system, as the collision object is usually a lot simpler (with less vertices) than the original model.

> Note: Primitive shapes already have colliders built into them.

You can edit a model in an external tool like Blender to include a collider, if it doesn't already include one.

Any objects that are named `x_collider`, where `x` can be any name you want, are considered colliders by the SDK, as long as the name ends in `_collider`. 

For example, if you have a 3D model of a house that you can walk through, you can:

1) Import it into Blender
2) Add a new cube object that overlaps with the shape of the house
3) Name this cube `house_collider` 
4) Export the model and use it in your scene
5) The SDK will now interpret the shape of this cube as a collider. It will be invisible, but it will block players form walking through the house.

See [3D models considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for more details on how to add colliders to a 3D model.


> Tip: In many cases, a simpler solution than editing the model is to overlay an entity with a primitive shape (like a box or a plane) and the `visible` field set to _false_, so that it acts as a collider.


## Make invisible

You can make an entity invisible by setting the `visible` field in its shape component. Doing this is especially useful when using the shape as a collider.

All components for primitive shape and 3D models are visible by default.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())
myEntity.getComponent(BoxShape).visible = false
```

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
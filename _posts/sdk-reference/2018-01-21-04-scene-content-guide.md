---
date: 2018-06-12
title: Scene content guide
description: Learn how to import 3D models to use in a scene
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 2
tag: introduction
---

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an *entity*, and each entity can include *components* that shape its characteristics and functionality. 

Entities can be nested inside others to create a tree structure. In fact, all scenes must output a tree of nested entities. `.xml` scenes explicitly define this tree, `.xlt` scenes define typescript code that builds and updates this tree.

This document covers how to achieve common objectives by using different types of entities and components in a scene's tree.

## Create simple geometric shapes

Several different types of predefined entities can be added to a scene, these already have certain components defined (like their shape) and let you set others (like their rotation and color).

The following types of entities are available:

* `<Box />`
* `<Sphere />`
* `<Plane />`
* `<Cylinder />`
* `<Cone />`

Any of these can be added to your scene, they can all include basic components like position, scale or color.

```xml
<box position={vector} color="#ff00aa" scale={2} />
```

See [Entity interfaces]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}) for more details on these types of entities.

> Tip: When editing the code via a IDE (like Visual Studio Code), you can see the list of components supported by a type of entity. Typically, this is done by placing the cursor in the entity and pressing *Ctrl + Space bar*.

## Import 3D Models
 
For more complex shapes, you can build a 3D model in an external tool like Blender and then import them in glTF format.  [glTF](https://www.khronos.org/gltf) (GL Transmission Format) is an open project by Khronos providing a common, extensible format for 3D assets that is both efficient and highly interoperable with modern web technologies.

To add an external model into a scene, add a `<gltf-model>` element and set its `src` component to the path of the glTF file containing the model.

```xml
<gltf-model
    position={ { x: 5, y: 3, z: 5 } }
    scale={0.5}
    src="models/myModel.gltf"
  />
```


glTF models can also include their own textures and animations. 

> Note: Keep in mind that all models and their textures must be within the parameters of the [scene limitations]({{ site.baseurl }}{% post_url /building-scenes/2018-01-06-scene-limitations %}).


The example below imports a model that includes animations and configures them:

```xml
<gltf-model
    position={ { x: 5, y: 3, z: 5 } }
    scale={0.5}
    src="models/shark_anim.gltf"
    skeletalAnimation={[
      { clip: 'shark_skeleton_bite', playing: false },
      { clip: 'shark_skeleton_swim', weight: 0.2, playing: true }
    ]}
  />
```

> Note: obj models are also supported as a legacy feature, but will likely not be supported for much longer. To add one, use an `<obj-model>` entity. 



<!---

### glb models

-->



### Why we use glTF?

Compared to the older *OBJ format*, which supports only vertices, normals, texture coordinates, and basic materials,
glTF provides a more powerful set of features. In addition to all of the features we just named, glTF also offers:

- Hierarchical objects
- Scene information (light sources, cameras)
- Skeletal structure and animation
- More robust materials and shaders

OBJ can currently be used for simple models that have no animations, but we will probably stop supporting it in the future.

Compared to *COLLADA*, the supported features are very similar. However, because glTF focuses on providing a
"transmission format" rather than an editor format, it is more interoperable with web technologies.

Consider this analogy: the .PSD (Adobe Photoshop) format is helpful for editing 2D images, but images must then be converted to .JPG for use
on the web. In the same way, COLLADA may be used to edit a 3D asset, but glTF is a simpler way of transmitting it while rendering the same result.


<!---
### How to use Blender with the SDK


how to add collider meshes into GLTF models


## Entity collision


## Sound






-->


## Migrating XML to Type Script

If you have a static XML scene and want to add dynamic capabilities to it, you must migrate it to TSX format. This implies making some minor changes to the entity syntax.

### Data types

> **TL;DR**  
> in XML: `position="10 10 10"`  
> in TSX: `position={ { x:10, y: 10, z: 10 } }`

There are subtle differences between the `text/xml` representation and the TSX representation of a scene. Our approach is TSX-first, and the XML representation of the scene is only a compatibility view. Because of this, attributes in TSX must be objects, not
plain text.


```xml
<scene>
  <!-- XML -->
  <box position="10 10 10" />
</scene>
```

The static scene above becomes the following dynamic schen when migrating it to TSX:

```tsx
class Scene extends ScriptableScene {
  async render() {
    return (
      <scene>
        <box position={ { x: 10, y: 10, z: 10 } } />
      </scene>
    );
  }
}
```

#### Attribute naming

> **TL;DR**  
> in XML: `albedo-color="#ffeeaa"` (kebab-case)  
> in TSX: `albedoColor="#ffeeaa"` (camelCase)

HTML and XHTML are case insensitive for attributes, this generates conflicts with the implementation of certain attributes like `albedoColor`. Because reading `albedocolor` was confusing, and having hardcoded keys with hyphens in the code was so dirty, we decided to follow the React convention of having every property camel cased in code and hyphenated in the HTML/XML representation. 

```xml
<scene>
  <!-- XML -->
  <material id="test" albedo-color="#ffeeaa" />
</scene>
```

The static scene above becomes the following dynamic schen when migrating it to TSX:

```tsx
class Scene extends ScriptableScene {
  async render() {
    return (
      <scene>
        <material id="test" albedoColor="#ffeeaa" />
      </scene>
    );
  }
}
```
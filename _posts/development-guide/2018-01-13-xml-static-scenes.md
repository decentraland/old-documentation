---
date: 2018-01-12
title: XML static scenes
description: How to create a static XML scene
categories:
  - development-guide
type: Document
set: development-guide
set_order: 13
---

You can create a static scene with XML. The advantage of this is that the code is simpler and straight forward, very similar to the code of an [A-frame](aframe.io) scene. The disadvantage is that you can't make the scene dynamic or interactive in any way, users will only be able to walk around it.

## Create a static scene

Copy the [XML sample scene](https://github.com/decentraland/sample-scene-static-xml), following the steps in the [create scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-03-create-scene %}) to clone a sample scene.

## Elements of a static scene

Each XML tag in the scene represents an entity. Entities are nested into a single tree structure where child entities inherit properties from the parent entities, so for example if a parent is rotated, its children will be rotated in the same degree as well.

The scene tree structure must start with a `<scene>` tag in the root level.

```xml
<scene>
  <box position="5 5 1" ></box>
  <entity position=" 1 3 1"></ entity>
    <box position="0 0 0" ></box>
  </entity>
</scene>
```

#### Primitive shapes

You can add primitive shapes like boxes, cones, or spheres.

```xml
<box color="#ff00aa" position="1 2 3" ></box>
<sphere color="#00aaff" position="1 2 3" scale="4 4 4"></sphere>
<plane color="#00aaff" position="1 2 3" scale="4 4 4" rotation="-90 0 0" ></plane>
```

#### 3D Models

You can import 3D models in _glTF_ format into your scene. See [3D model considerations]({{ site.baseurl }}{% post_url /development-guide/2018-01-09-external-3d-models %}) for details about what can be supported in 3D models.

```xml
<gltf-model position="1 2 3" scale="4 4 4" src="models/dog.gltf"></gltf-model>
```

All `gltf-model` entities need to have an `src` attribute, pointing to a file for the 3D model.

#### Wrapper entities

You can use basic entities as wrappers to group and transform child entities. These entities are invisible, but any attributes they have are inherited by their children, which can make it easier to scale, rotate or position several entities as a group.

```xml
<entity position="5 0 0" rotation="0 90 0">
   <box color="#ff00aa" position="-2 0 0"></box>
   <box color="#00aaff" position="2 0 0"></box>
 </entity>
```

## XML attributes

Entities have different attributes depending on their type, for example it only makes sense for a cylinder to have _radiusTop_ and _radiusBottom_.

All entities have the following attributes:

- `position`: Requires three numbers, detailing the _x_, _y_ and _z_ coordinates.
- `rotation`: Requires three numbers, detailing _x_, _y_ and _z_ rotation angles, in degrees.
- `scale`: Can either have a single number, to maintain the entity’s proportions, or three numbers, in case you want to scale the _x_, _y_ and _z_ axis in different proportions.

See [entity interfaces]({{ site.baseurl }}{% post_url /development-guide/2018-01-13-xml-static-scenes %}) for a full list of all the available components per type of entity. Each component is expressed as an attribute in XML. Some of these components are only supported in TypeScript scenes.

## Migrate an A-frame to a Decentraland static scene

To migrate a scene that was developed in A-frame into decentraland:

- Create a new static scene with the CLI as explained in [Create scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-03-create-scene %}).
  > Note: If the size of the A-frame scene is larger than 1 Decentraland parcel, make sure you configure the scene to have enough parcels to fit it.
- Copy the entire entity structure from your the A-Frame's _index.html_ file. Paste it in the Decentraland's _scene.xml_ file, in between the `<scene>` and `</scene>` lines. Delete the existing boilerplate box, sphere and cylinder primitives from the scene.
- Make the following changes to the A-frame primitives:
  - In every tag name that starts with _a-_ remove the _a-_. So tags like `<a-entity>` and `<a-gltf-model>` become `<entity>` and `<gltf-model>`.
  - For all _position_ attributes, inverse the z axis. For example `position=”10 5 15”` should become `position=”10 5 -15”`.

<!--

## Migrating an XML scene to TypeScript

If you have a static XML scene and want to add dynamic capabilities to it, you must migrate it to TSX format. To do this, follow these steps:

- Create a new scene following the steps in [Create scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-03-create-scene %}) and choose the scene type _Basic_.
- Copy the entire contents of _scene.xml_ in the static scene. Paste it in the _scene.tsx_ file of the new scene, replacing the boilerplate content in the `return` statement of the `render()` function.
- Make some minor changes to the entity syntax that are explained in the subsections below.

#### Data types

> **TL;DR**
> in XML: `position="10 10 10"`
> in TSX: `position={ { x:10, y: 10, z: 10 } }`

There are subtle differences between the _text/xml_ representation and the _.tsx_ representation of a scene. Our approach is _TSX-first_, and the _XML_ representation of the scene is only a compatibility view. Because of this, attributes in _TSX_ must be objects, not
plain text.

```xml
<scene>
  <box position="10 10 10" />
</scene>
```

The static scene above becomes the following dynamic scene when migrating it to _TSX_:

{% raw %}

```tsx
class Scene extends ScriptableScene {
  async render() {
    return (
      <scene>
        <box position={{ x: 10, y: 10, z: 10 }} />
      </scene>
    )
  }
}
```

{% endraw %}
-->
<!--

#### Attribute naming

> **TL;DR**
> in XML: `albedo-color="#ffeeaa"` (kebab-case)
> in TSX: `albedoColor="#ffeeaa"` (camelCase)

HTML and XHTML are case insensitive for attributes, this generates conflicts with the implementation of certain attributes like `albedoColor`. Because reading `albedocolor` was confusing, and having hardcoded keys with hyphens in the code was so dirty, we decided to follow the React convention of having every property camel cased in code and hyphenated in the HTML/XML representation.

{% raw %}

```xml
<scene>
  <material id="test" albedo-color="#ffeeaa" />
</scene>
```

{% endraw %}

The static scene above becomes the following dynamic scene when migrating it to TSX:

{% raw %}

```tsx
// TSX
class Scene extends ScriptableScene {
  async render() {
    return (
      <scene>
        <material id="test" albedoColor="#ffeeaa" />
      </scene>
    )
  }
}
```

{% endraw %}

-->

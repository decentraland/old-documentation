---
date: 2018-01-01
title: Creating your first scene
description: Learn the basics of Decentraland scenes
categories:
  - documentation
type: Document
set: api-101
set_order: 2
---
## Entities

Entities are the basic unit in Decentraland scenes, those are our equivalent to Elements in a DOM tree. They share the
same basic shape, they have a tag, attributes and children. That means we can create trees of entities.

```ts
interface IEntity {
  // name of the entity
  tag: string;
  // dictionary of attributes a.k.a.: properties
  attributes: Dictionary<any>;
  // children entities
  children: IEntity[];
}
```

See also: **[Entities](Entities)**

## Kind of scenes

In Decentraland, the scene is the representation of the content of the scene. There is roughly two ways to create
scenes:

- **static scene**: xml file describing static objects in the scene
- **dynamic scene**: jsx/tsx files with dynamic content, those may create move and mutate entities in the scene

Since we decoupled the execution of the scenes from the underlying engine, we have abstracted the communication protocol
and that allows us to run the scenes both locally in a WebWorker and remotely in a Node.js server thru WebSockets.

## Basic scene structure

For both kinds of scenes, the structure is the same, a tree of entities represented in XML/JSX.  
The root of the tree is always a `<scene>` element like in this demo scene (xml)

```xml
<scene>
  <sphere position="1 1 1"></sphere>
  <box position="3.789 2.3 4.065" scale="1 10 1"></box>
  <box position="2.212 7.141 4.089" scale="2.5 0.2 1"></box>
  <obj-model src="crate/crate.obj" position="5 1 5"></box>
</scene>
```

Since the scene is a transform node, it can be translated, scaled and rotated. This becomes useful when you want to
change the center of coordinates of the parcel:

```xml
<scene position="5 5 5">
  <box position="0 0 0"></box>
  <!-- in this example the box is located at the world position 5 5 5 -->
</scene>
```

## Differences migrating to JSX

#### Data types

> TL;DR: `position="10 10 10"` in XML, `position={ { x:10, y: 10, z: 10 } }` in JSX

There are subtle differences between the `text/xml` representation and the JSX representation, unlike A-Frame, our
approach is JSX-first, and the XML representation is only a compatibility view. So the attributes must be objects, not
text.

```xml
<scene>
  <!-- XML -->
  <box position="10 10 10" />
</scene>
```
Becomes
```tsx
class Scene extends ScriptableScene {
  async render() {
    return (
      <scene>
        <box position={ { x:10, y: 10, z: 10 } } />
      </scene>
    )
  }
}
```

#### Attribute naming

> TL;DR: `albedo-color="#ffeeaa"` in XML, `albedoColor="#ffeeaa"` in JSX

HTML and XHTML are case insensitive for attributes, that generate conflicts with the implementation of certain
attributes like `albedoColor` because reading `albedocolor` sounds weird and having hardcoded keys with hyphens in the
code was so dirty, we followed the React convention of having every property camel cased in code and hyphenated in the
HTML/XML representation. Example:

```xml
<scene>
  <!-- XML -->
  <material id="test" albedo-color="#ffeeaa" />
</scene>
```

Becomes

```tsx
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

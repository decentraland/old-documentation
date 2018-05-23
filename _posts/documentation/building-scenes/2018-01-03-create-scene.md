---
date: 2018-01-01
title: Creating your first scene
description: Learn the basics of Decentraland scenes
categories:
  - documentation
type: Document
set: building-scenes
set_order: 2
---

## Entities

Entities are the basic unit in Decentraland scenes; those are our equivalent to Elements in a DOM tree. They share the same basic shape; they have a tag, attributes, and children. That means we can create trees of entities.

```ts
interface IEntity {
  tag: string;                 // name of the entity
  attributes: Dictionary<any>; // dictionary of attributes a.k.a.: properties
  children: IEntity[];         // children entities
}
```

## Kind of scenes

In Decentraland, the scene is the representation of the content of the scene. There are roughly two ways to create scenes:

* **static scene**: xml file describing static objects in the scene
* **dynamic scene**: jsx/tsx files with dynamic content, those may create move and mutate entities in the scene

Since we decoupled the execution of the scenes from the underlying engine, we have abstracted the communication protocol, and that allows us to run the scenes both locally in a WebWorker and remotely in a Node.js server thru WebSockets.

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

Since the scene is a transform node, it can be translated, scaled and rotated. Those capabilities become useful when you want to, i.e. change the center of coordinates of the parcel:

```xml
<scene position="5 5 5">
  <box position="0 0 0"></box>
  <!-- in this example the box is located at the world position 5 5 5 -->
</scene>
```

## Differences migrating to JSX

#### Data types

> **TL;DR**  
> in XML you do `position="10 10 10"`  
> in JSX you do `position={ { x:10, y: 10, z: 10 } }`

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
        <box position={ { x: 10, y: 10, z: 10 } } />
      </scene>
    );
  }
}
```

#### Attribute naming

> **TL;DR**  
> in XML you do `albedo-color="#ffeeaa"` (kebab-case)  
> in JSX you do `albedoColor="#ffeeaa"` (camelCase)

HTML and XHTML are case insensitive for attributes, that generate conflicts with the implementation of certain attributes like `albedoColor` because reading `albedocolor` sounds weird, and having hardcoded keys with hyphens in the code was so dirty. We followed the React convention of having every property camel cased in code and hyphenated in the HTML/XML representation. Example:

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
    );
  }
}
```

## Creating the files

To develop a scene you will need at least 2 files:

For the static scene

1.  `scene.json`: The manifest with metadata of the scene
2.  `scene.xml`: The content of the static scene

This tutorial will be focused on a dynamic scene, you will need:

1.  `scene.json`: The manifest with metadata of the scene
2.  `build.json`: The file with the instructions to build
3.  `tsconfig.json`: Typescript configuration file
4.  `scene.tsx`: The entry point of the scene

To scaffold this files use our CLI tool and execute `dcl init` in an empty folder.

The `dcl init` command creates a Decentraland **project** in your current working directory containing a **scene** using
the default structure outlined below. You will be prompted to enter some descriptive metadata that will be stored in
your [scene.json](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki) manifest file. All of this
metadata is optional except for scene type (static, dynamic & singleplayer, or dynamic & multiplayer). See below for a
description of each of these scene types.

> If you run `dcl init` in a folder containing other Decentraland projects, any existing files with duplicate names will
> be overwritten with the new, initialized project files.

## scene.json

The `scene.json` file is a JSON formatted manifest for a scene in the world. A scene can spawn multiple parcels of LAND,
or a single LAND parcel. The `scene.json` manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a
`scene.json` file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

## scene.tsx

If you are creating a locally run scene, this file contains the code that will run for each client that is visiting your parcel. An elementary example of these scenes looks like this:

```tsx
import { ScriptableScene, createElement } from "metaverse-api";

// The ScriptableScene class is a React-style component.
export default class MyScene extends ScriptableScene<any, any> {
  async render() {
    return (
      <scene>
        <box position={ { x: 5, y: 0, z: 5 } } scale={ { x: 1, y: 1, z: 1 } } />
      </scene>
    );
  }
}
```

> **Important note:** Always do `export default class` in your `scene.tsx` that is the way our SDK finds the class to initialize the scene.

## package.json

This file is used to give information to NPM that allows it to identify the project as well as handle the project's dependencies. Decentraland scenes need two packages:

* `metaverse-api`, which allows the scene to communicate with the world engine
* `typescript`, to compile the file scene.tsx to javascript

> You don’t need the `typescript` package when creating static scenes. This is only required when you are building remote and interactive scenes.

## build.json

Decentraland build configuration file.

We provide a tool called `metaverse-compiler`, it comes with the `metaverse-api` package. That tool is in charge of
reading that file and compile your scene in a way the client can run it. It is super simple indeed, it only bundles
Typescript code into a WebWorker using WebPack.

You can also use the same command line to create Node.js servers for the multiplayer experiences.

## tsconfig.json

Directories containing a `tsconfig.json` file are root directories for TypeScript Projects. The `tsconfig.json` file specifies the root files and options required to compile your project in JavaScript.

> **Why do we use Typescript?**  
> TypeScript is a superset of JavaScript and allows you to employ object-oriented programming and type declaration. Features like autocomplete and type-checking speed up development times and allow for the creation of a solid codebase. These features are all key components to a positive developer experience.
>
> You can use another tool or language instead of TypeScript, so long as your scripts are contented within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Preview your scene

To preview your rendered scene locally before uploading it to IPFS, run

```bash
dcl preview
```

This preview also provides some useful debugging information and tools to help you understand how different entities are rendered. The preview mode provides information describing parcel boundaries and environmental and resource information, like the number of entities being rendered, the current FPS rate, user position, and whether or not different elements are exceeding parcel boundaries.

> When previewing old scenes that you built before this release of the SDK, you will still have to install the latest versions of the `metaverse-api` and `metaverse-rpc` packages in your project.

---
date: 2018-01-01
title: Creating your first scene
description: Learn the basics of Decentraland scenes
categories:
  - documentation
type: Document
set: building-scenes
set_order: 2
tag: introduction
---



## Kinds of scenes

In Decentraland, a scene is the representation of the content of in an estate/LAND. All scenes are made up of [entities](../../api-reference/entity-interfaces/index.html), which represent all of the elements in the scene and are arranged into tree structures, very much like elements in a DOM tree in web development.


There are essentially two different types of scenes:

* **Static scenes**: An [XML](https://en.wikipedia.org/wiki/XML) file describes static objects in the scene.
* **Dynamic scenes**: A [TypeScript (TSX)](https://www.typescriptlang.org/docs/handbook/jsx.html) file, with a `.tsx` extension, that has dynamic content. Through these you can create, move and mutate the entities in the scene.


## Creating the file structure

Use our CLI tool to automatically build the initial scaffolding for a scene. To do so, run `dcl init` in an empty folder. See [SDK Overview](../../api-reference/SDK-Overview/index.html) for details on how to install and use the CLI.

The `dcl init` command creates a Decentraland **project** in your current working directory containing a **scene**. It prompts you to select a scene type (static, dynamic & singleplayer, or dynamic & multiplayer) and builds a different file structure depending on the case.

*A static scene* includes the following files:

1.  `scene.json`: The manifest that contains metadata for the scene.
2.  `scene.xml`: The content of the static scene.

*A dynamic scene* incldes the following files:

1.  `scene.json`: The manifest that contains metadata for the scene.
2.  `build.json`: The file with the instructions to build the scene.
3.  `tsconfig.json`: Typescript configuration file.
4.  `scene.tsx`: The entry point of the scene.


The `dcl init` command also prompts you to enter some descriptive metadata, these datais are stored in
the [scene.json](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki) manifest file for the scene. All of this
metadata is optional for building a scene locally, except for scene type.

> If you run `dcl init` in a folder containing other Decentraland projects, any existing files with duplicate names will be overwritten with the new, initialized project files.

## Scene.xml (static scenes)

For both static and dynamic scenes, the end result is the same: a tree of entities. The root of the tree is always a `<scene>` element. XML scenes call out this structure explicitly, Type Script scenes provide the script to build and update this structure.  


```xml
<scene>
  <sphere position="1 1 1"></sphere>
  <box position="3.789 2.3 4.065" scale="1 10 1"></box>
  <box position="2.212 7.141 4.089" scale="2.5 0.2 1"></box>
  <gitf-model src="crate/crate.gitf" position="5 1 5"></box>
</scene>
```

Since the root scene element is a transform node, it can also be translated, scaled and rotated. Those capabilities are useful to, for example, change the center of coordinates of the entire parcel:

```xml
<scene position="5 5 5">
  <box position="0 0 0"></box>
  <!-- in this example, the box is located at the world position 5 5 5 -->
</scene>
```

## scene.tsx (dynamic scenes)

This file contains the code that generates an entity tree, which is what end users of your parsel will see. Below is a basic example of a `scene.tsx` file:

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

> **Important note:** Your `scene.tsx` must always include an `export default class`, that's how our SDK finds the class to initialize the scene.


## scene.json

The `scene.json` file is a JSON formatted manifest for a scene in the world. A scene can span a single or multiple LAND parcels. The `scene.json` manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a
`scene.json` file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

## package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland scenes need two packages:

* `metaverse-api`, which allows the scene to communicate with the world engine.
* `typescript`, to compile the file `scene.tsx` to javascript.

> You don’t need the `typescript` package when creating static scenes. This is only required when you are building remote and interactive scenes.

## build.json

This is the Decentraland build configuration file.

We provide a tool called `metaverse-compiler`, it comes with the `metaverse-api` package. This tool is in charge of
reading the `build.json` file and compile your scene in a way that the client can run it. The only thing it really does is to bundle Typescript code into a WebWorker using WebPack.

> You can also use the CLI to create Node.js servers for multiplayer experiences.

## tsconfig.json

Directories containing a `tsconfig.json` file are root directories for TypeScript Projects. The `tsconfig.json` file specifies the root files and options required to compile your project in JavaScript.

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.


## Preview your scene

To preview your rendered scene locally (without uploading it to IPFS) run the following command on the scene's main folder:

```bash
dcl preview
```

Running a preview also provides some useful debugging information and tools to help you understand how different entities are rendered. The preview mode provides information that describes parcel boundaries, the environment and resources, for example the number of entities being rendered, the current FPS rate, user position, and whether or not different elements are exceeding parcel boundaries.

Every time you make changes to the scene, the preview reloads and updates automatically, so there's no need to launch it again.

You can add the following flags to the command:
* ` --no-browser` to prevent the preview from opening a new browser tab.
* `--port` to assign a specific to run the scene. Otherwise it will use whatever port is available.
* `--skip` to skip the confirmation prompt.

> To preview old scenes that were built for older versions of the SDK, you must install the latest versions of the `metaverse-api` and `metaverse-rpc` packages in your project. Check the CLI version via the command `dcl -v`


## Migrating XML to Type Script

If you have a static XML scene and want to add dynamic capabilities to it, you must migrate it to TSX format.

### Data types

> **TL;DR**  
> in XML you do `position="10 10 10"`  
> in TSX you do `position={ { x:10, y: 10, z: 10 } }`

There are subtle differences between the `text/xml` representation and the TSX representation of a scene. Unlike A-Frame, our approach is TSX-first, and the XML representation of the scene is only a compatibility view. Because of this, attributes must be objects, not
plain text.


```xml
<scene>
  <!-- XML -->
  <box position="10 10 10" />
</scene>
```

After migrating the XML to TSX, the static scene above becomes the dynamic scene below:

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
> in XML you use `albedo-color="#ffeeaa"` (kebab-case)  
> in TSX you use `albedoColor="#ffeeaa"` (camelCase)

HTML and XHTML are case insensitive for attributes, that generates conflicts with the implementation of certain attributes like `albedoColor`. Because reading `albedocolor` was confusing, and having hardcoded keys with hyphens in the code was so dirty, we decided to follow the React convention of having every property camel cased in code and hyphenated in the HTML/XML representation. 

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

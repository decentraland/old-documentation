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

In Decentraland, a scene is the representation of the content of an estate/LAND. All scenes are made up of [entities]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}), which represent all of the elements in the scene and are arranged into tree structures, very much like elements in a DOM tree in web development.

## Before you begin

Please make sure you first install the CLI tools. In Mac OS, you do this by running the following command:

```bash
npm install -g decentraland
```

See the [Installation Guide]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-01-installation-guide %}) for more details and specific instructions for Windows and Linux systems.

## Creating the file structure

Use our CLI tool to automatically build the initial boilerplate scene. To do so, run `dcl start` in an empty folder. See [SDK Overview]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-01-SDK-Overview %}) for details on how to install and use the CLI.

The `dcl start` command creates a Decentraland **project** in your current working directory containing a **scene**. It prompts you to answer a series of optional questions about the scene's ownership and where in Decentraland to eventually upload it, then it asks you to select a scene template to start from. Depending on what you choose for this option, the CLI builds a different file structure with different default content.

There are four different scene templates that you can use as a starting point:

- **Basic scene**: Defined in a simple TypeScript file that renders a single glTF model.
- **Local scene**: Defined in a TypeScript file featuring an example with a door that can be opened. This is the best template to start learning how to use the SDK. The scene features a basic state and handles click events. The scene state is stored locally in the users's browser, so a user's actions don't affect how other users see the scene rendered.
- **Remote scene**: Defined in a TypeScript file featuring the same example used for the local scene, but it differs in that the scene state is stored in a remote server that it communicates with over WebSockets. Because of this, all users see the scene rendered identically. If you're developing a game or another kind of interactive experience, this is most likely how you want it to work. To test your scene, you can run both the server and the client locally.
- **Static scene**: Defined in an **XML** file with a single glTF moel. You can't add any dynamic or interactive content to this type of scene, it can only display static entities in place.

## Scene contents

_A local scene_ incldes the following files:

1.  `scene.tsx`: The entry point of the scene.
2.  `scene.json`: The manifest that contains metadata for the scene.
3.  `package.json`:
4.  `build.json`: The file with the instructions to build the scene.
5.  `tsconfig.json`: Typescript configuration file.

The `dcl start` command also prompts you to enter some descriptive metadata, these datais are stored in
the [scene.json](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki) manifest file for the scene. All of this
metadata is optional for building a scene locally, except for scene type.

> If you run `dcl start` in a folder containing other Decentraland projects, any existing files with duplicate names will be overwritten with the new, initialized project files.

#### scene.tsx

This file contains the code that generates an entity tree, which is what end users of your parcel will see. Below is a basic example of a `scene.tsx` file:

{% raw %}

```tsx
import { ScriptableScene, createElement } from "metaverse-api"

// The ScriptableScene class is a React-style component.
export default class MyScene extends ScriptableScene<any, any> {
  async render() {
    return (
      <scene>
        <box position={{ x: 5, y: 0, z: 5 }} scale={{ x: 1, y: 1, z: 1 }} />
      </scene>
    )
  }
}
```

{% endraw %}

> **Important note:** Your `scene.tsx` must always include an `export default class`, that's how our SDK finds the class to initialize the scene.

#### scene.json

The `scene.json` file is a JSON formatted manifest for a scene in the world. A scene can span a single or multiple LAND parcels. The `scene.json` manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a
`scene.json` file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

#### package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland scenes need two packages:

- `metaverse-api`, which allows the scene to communicate with the world engine.
- `typescript`, to compile the file `scene.tsx` to javascript.

> You don’t need the `typescript` package when creating static scenes. This is only required when you are building remote and interactive scenes.

#### build.json

This is the Decentraland build configuration file.

We provide a tool called `metaverse-compiler`, it comes with the `metaverse-api` package. This tool is in charge of
reading the `build.json` file and compile your scene in a way that the client can run it. All it really does is bundle Typescript code into a WebWorker using WebPack.

> You can also use the CLI to create Node.js servers for multiplayer experiences.

#### tsconfig.json

Directories containing a `tsconfig.json` file are root directories for TypeScript Projects. The `tsconfig.json` file specifies the root files and options required to compile your project in JavaScript.

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Static scene contents

_A static scene_ includes the following files:

1.  `scene.json`: The manifest that contains metadata for the scene.
2.  `scene.xml`: The content of the static scene.

#### scene.xml (static scenes)

For both static and dynamic scenes, the end result is the same: a tree of entities. The root of the tree is always a `<scene>` element. XML scenes call out this structure explicitly, TypeScript scenes provide the script to build and update this structure.

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

## Preview your scene

To preview your rendered scene locally, run the following command on the scene's main folder:

```bash
dcl preview
```

Every time you make changes to the scene, the preview reloads and updates automatically, so there's no need to run the command again.

For more about what you can see in a scene preview, and instructions for how to run a preview of a remote scene, see [preview your scene]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-04-preview-scene %}).

## Edit your scene

To edit scenes, we recommend using a source code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/). An editor like this helps you create scenes a lot faster and with less errors, as it marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. With Visual Studio Code you can even click on an object to see the full definition of its class.

See [scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for simple instructions about adding content to your scene.

Once you're done creating the scene and want to upload it to your LAND, see [publishing]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-07-publishing %}).

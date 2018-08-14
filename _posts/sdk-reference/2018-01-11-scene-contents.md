---
date: 2018-01-10
title: Default scene contents
description: Default files created in a new scene
categories:
  - documentation
type: Document
set: sdk-reference
set_order: 11
---

After [creating a new scene]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-03-create-scene %}) using the CLI, the scene folder will have a series of files with default content. The file structure and content will vary depending on the type of scene you selected (_basic_, _interactive_, _remote_, or _static_).

## Local scene content

When you choose to create a _basic_ or an _interactive_ scene with the CLI, this creates a _local scene_.

Local scenes inclde the following files:

1.  **scene.tsx**: The entry point of the scene.
2.  **scene.json**: The manifest that contains metadata for the scene.
3.  **package.json** and **package-lock.json**: Specify the versions of all dependencies of the scene.
4.  **build.json**: The file with the instructions to build the scene.
5.  **tsconfig.json**: Typescript configuration file.

#### scene.tsx

This file contains the code that generates an entity tree, which is what end users of your parcel will see. Below is a basic example of a _scene.tsx_ file:

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

> **Important note:** Your _scene.tsx_ file must always include an `export default class`, that's how our SDK finds the class to initialize the scene.

#### scene.json

The _scene.json_ file is a JSON formatted manifest for a scene in the world. A scene can span a single or multiple LAND parcels. The _scene.json_ manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a
_scene.json_ file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

When you run the `dcl init` command, it prompts you to enter some descriptive metadata, these datais are stored in
the scene.json manifest file for the scene. All of this
metadata is optional for previewing the scene locally, but part of it is needed for deploying. You can change this information manually at any time.

#### package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland scenes need two packages:

- **metaverse-api**: allows the scene to communicate with the world engine.
- **typescript**: used to compile the file _scene.tsx_ to javascript.

> If you're creating a static _XML_ scene, you don’t need the `typescript` package.

#### package-lock.json

This file lists the versions of all the other dependencies of the project. These versions are locked, meaning that the compiler will use literally the same minor release listed here.

You can change any package version manually by editing this file.

#### build.json

This is the Decentraland build configuration file.

We provide a tool called _metaverse-compiler_, it comes with the _metaverse-api_ package. This tool is in charge of
reading the _build.json_ file and compile your scene in a way that the client can run it. All it really does is bundle Typescript code into a WebWorker using WebPack.

> You can also use the CLI to create Node.js servers for multiplayer experiences.

#### tsconfig.json

Directories containing a _tsconfig.json_ file are root directories for TypeScript Projects. The _tsconfig.json_ file specifies the root files and options required to compile your project in JavaScript.

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Remote scene contents

Remote scenes inclde the following files:

1.  **RemoteScene.tsx**: The entry point of the scene.
2.  **State.tsx**: Handles the scene state. This is executed in the remote server.
3.  **Server.ts**: Configuration for the remote server.
4.  **scene.json**: The manifest that contains metadata for the scene.
5.  **package.json** and **package-lock.json**: Specify the versions of all dependencies of the scene.
6.  **build.json**: The file with the instructions to build the scene.
7.  **tsconfig.json**: Typescript configuration file.

## Static scene contents

_A static scene_ includes the following files:

1.  **scene.json**: The manifest that contains metadata for the scene.
2.  **scene.xml**: The content of the static scene.

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

#### package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland static scenes need this package:

**metaverse-api**: allows the scene to communicate with the world engine.

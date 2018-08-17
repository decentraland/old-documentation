---
date: 2018-01-10
title: Files in a scene
description: Default files created in a new scene
categories:
  - documentation
type: Document
set: sdk-reference
set_order: 11
---

After [creating a new scene]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-03-create-scene %}) using the CLI, the scene folder will have a series of files with default content. The file structure and content will vary depending on the type of scene you selected (_basic_, _interactive_, _remote_, or _static_).

## Default files in a local scene

When you choose to create a _basic_ or an _interactive_ scene with the CLI, this creates a _local scene_.

Local scenes inclde the following files:

1.  **scene.tsx**: The entry point of the scene.
2.  **scene.json**: The manifest that contains metadata for the scene.
3.  **package.json** and **package-lock.json**: Specify the versions of all dependencies of the scene.
4.  **build.json**: The file with the instructions to build the scene.
5.  **tsconfig.json**: Typescript configuration file.

#### scene.tsx

In most cases, you'll only need to edit this file to create your scene. It contains the code that generates an entity tree, which is what end users of your parcel will see.

Below is a basic example of a _scene.tsx_ file:

{% raw %}

```tsx
import { ScriptableScene, createElement } from "decentraland-api"

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

- **decentraland-api**: allows the scene to communicate with the world engine.
- **typescript**: used to compile the file _scene.tsx_ to javascript.

#### package-lock.json

This file lists the versions of all the other dependencies of the project. These versions are locked, meaning that the compiler will use literally the same minor release listed here.

You can change any package version manually by editing this file.

#### build.json

This is the Decentraland build configuration file.

#### tsconfig.json

Directories containing a _tsconfig.json_ file are root directories for TypeScript Projects. The _tsconfig.json_ file specifies the root files and options required to compile your project from TypeScript into JavaScript.

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Default files in a remote scene

Remote scenes inclde the following files:

1.  **server/RemoteScene.tsx**: The entry point of the scene.
2.  **server/State.ts**: Handles the scene state. This is executed in the remote server.
3.  **server/Server.ts**: Configuration for the remote server.
4.  **server/ConnectedClients.ts**: Handles users of the scene.
5.  **server/build.json**: Instructions for the scene build.
6.  **server/tsconfig.json**: Typescript configuration file.
7.  **server/build.json**: The file with the instructions to build the scene.
8.  **package.json** and **package-lock.json**: Specify the versions of all dependencies of the scene.
9.  **scene.json**: The manifest that contains metadata for the scene.

#### RemoteScene.tsx

It contains the code that generates an entity tree, which is what end users of your parcel will see. Its biggest difference with the _scene.tsx_ file of a static scene is that it doesn't define a scene state, but instead it imports the state and functions to access it from _State.ts_.

Below is a basic example of a _RemoteScene.tsx_ file:

{% raw %}

```tsx
import * as DCL from "decentraland-api"
import { setState, getState } from "./State"

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

> **Important note:** Your _RemoteScene.tsx_ file must always include an `export default class`, that's how our SDK finds the class to initialize the scene.

#### State.ts

This file handles the scene state. Remote scenes keep the state stored in a remote server.

The file includes the definition of the scene state and two functions that are used to get and to set information from this remote state.

Below is a basic example of a _State.ts_ file:

{% raw %}

```tsx
import { updateAll } from "./ConnectedClients"

let state = {
  isDoorClosed: false
}

export function getState(): typeof state {
  return state
}

export function setState(deltaState: Partial<typeof state>) {
  state = { ...state, ...deltaState }
  console.log("new state:")
  console.dir(state)
  updateAll()
}
```

{% endraw %}

Learn more about how the scene state works in [scene state]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-04-scene-state %}).

#### scene.json

The _scene.json_ file is a JSON formatted manifest for a scene in the world. A scene can span a single or multiple LAND parcels. The _scene.json_ manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a
_scene.json_ file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

When you run the `dcl init` command, it prompts you to enter some descriptive metadata, these datais are stored in
the scene.json manifest file for the scene. All of this
metadata is optional for previewing the scene locally, but part of it is needed for deploying. You can change this information manually at any time.

#### package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland scenes need two packages:

- **decentraland-api**: allows the scene to communicate with the world engine.
- **typescript**: used to compile the file _scene.tsx_ to javascript.

#### package-lock.json

This file lists the versions of all the other dependencies of the project. These versions are locked, meaning that the compiler will use literally the same minor release listed here.

You can change any package version manually by editing this file.

#### build.json

This is the Decentraland build configuration file.

#### tsconfig.json

Directories containing a _tsconfig.json_ file are root directories for TypeScript Projects. The _tsconfig.json_ file specifies the root files and options required to compile your project from TypeScript into JavaScript.

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Default files in a static scene

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

**decentraland-api**: allows the scene to communicate with the world engine.

## Recommended file locations

Keep in mind that when you deploy your scene to Decentraland, any assets or external libraries that are needed to use your scene must be either packaged inside the scene folder or available via a remote server.

Anything that is meant to run in the user's client must located inside the scene folder. That includes external libraries like Babylon.js. You shouldn't reference libraries that are installed elsewhere in your local machine, because they won't not be available to the deployed scene.

We suggest using these folder names consistently for storing the different types of assets that your scene might need:

- 3d models: `/models`
- Videos: `/videos`
- Sound files: `/sounds`
- Image files for textures: `/materials`
- _.tsx_ definitions for reusable components `/components`

## The dclignore file

All scenes include a _.dclignore_ file, this file specifies what files in the scene folder to ignore when deploying a scene to Decentraland.

For example, you might like to keep the Blender files for the 3D models in your scene inside the scene folder, but you want to prevent those files from being deployed to Decentraland. In that case, you could add `*.blend` to _.dclignore_ to ignore all files with that extension.

| What to ignore | Example      | Description                                                                             |
| -------------- | ------------ | --------------------------------------------------------------------------------------- |
| Specific files | `BACKUP.tsx` | Ignores a specific file                                                                 |
| Folders        | `drafts/`    | Ignores entire contents of a folder and its subfolders                                  |
| Extensions     | `*.blend`    | Ignores all files with a given extension                                                |
| Name sections  | `test*`      | Ignores all files with names that match the query. In this case, that start with _test_ |

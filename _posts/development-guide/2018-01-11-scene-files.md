---
date: 2018-02-11
title: Files in a scene
description: Default files created in a new scene.
categories:
  - development-guide
redirect_from:
  - /documentation/scene-files/
type: Document
---

After [creating a new scene](https://docs.decentraland.org/#create-your-first-scene) using the CLI, the scene folder will have a series of files with default content.

## Default files in a local scene

Scenes include the following files:

- **src/game.ts**: The entry point of the scene.
- **scene.json**: The manifest that contains metadata for the scene.
- **package.json** and **package-lock.json**: Specify the versions of all dependencies of the scene.
- **tsconfig.json**: Typescript configuration file.
- **.dclignore**: Lists what files in your project not to deploy to IPFS.

#### game.ts

This is the entry point to your scene's code. You could fit your entire scene's logic into this file, although for clarity in most cases we recommend spreading out your code over several other _.ts_ files and importing them into _game.ts_.

In most cases, you'll only need to edit this file to create your scene. It contains the code that generates an entity tree, which is what end users of your parcel will see.

Below is a basic example of a _game.ts_ file:

```ts
// Create a component group to track entities with Transform components
let group = engine.getComponentGroup(Transform)

// Create a system
export class RotatorSystem {
  // The update() function runs on every frame.
  update() {
    // Cycle over the entities in the component group
    for (let entity of group.entities) {
      const transform = entity.getComponent(Transform)
      transform.rotation.y += 2
    }
  }
}

// Create an entity
const cube = new Entity()

// Add a cube shape to the entity
cube.addComponent(new BoxShape())

// Add a transform component to the entity
cube.addComponent(
  new Transform({
    position: new Vector3(5, 0, 5),
  })
)

// Add the entity to the engine
engine.addEntity(cube)

// Add the system to the engine
engine.addSystem(new RotatorSystem())
```

#### scene.json

The _scene.json_ file is a JSON formatted manifest for a scene in the world. A scene can span a single or multiple LAND parcels. The _scene.json_ manifest describes what objects exist in the scene, a list of any assets needed to render it.

contact information for the parcel owner, and security settings. For more information and an example of a
_scene.json_ file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

All of this metadata is optional for previewing the scene locally, but part of it is needed for deploying. You can change this information manually at any time.

#### package.json

This file provides information to NPM that allows it to identify the project, as well as handle the project's dependencies. Decentraland scenes need two packages:

- **decentraland-api**: allows the scene to communicate with the world engine.
- **typescript**: used to compile the file _game.ts_ to javascript.

#### package-lock.json

This file lists the versions of all the other dependencies of the project. These versions are locked, meaning that the compiler will use literally the same minor release listed here.

You can change any package version manually by editing this file.

#### tsconfig.json

Directories containing a _tsconfig.json_ file are root directories for TypeScript Projects. The _tsconfig.json_ file specifies the root files and options required to compile your project from TypeScript into JavaScript.

> You can use another tool or language instead of TypeScript, so long as your scripts are contained within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Recommended file locations

Keep in mind that when you deploy your scene to Decentraland, any assets or external libraries that are needed to use your scene must be either packaged inside the scene folder or available via a remote server.

Anything that is meant to run in the player's client must located inside the scene folder. You shouldn't reference files or libraries that are installed elsewhere in your local machine, because they won't be available to the deployed scene.

We suggest using these folder names consistently for storing the different types of assets that your scene might need:

- 3d models: `/models`
- Videos: `/videos`
- Sound files: `/sounds`
- Image files for textures (except for glTF models): `/materials`
- _.ts_ definitions for components `/src/components`
- _.ts_ definitions for systems `/src/systems`

> Note: Supporting files for glTF models, like their texture image files or _.bin_ files, should always be placed in the same folder as the model's _.gltf_ or _.glb_ file.

> Note: We recommend using always lower case names for all folders and file names, to avoid possible issues.

## The dclignore file

All scenes include a _.dclignore_ file, this file specifies what files in the scene folder to ignore when deploying a scene to Decentraland.

For example, you might like to keep the Blender files for the 3D models in your scene inside the scene folder, but you want to prevent those files from being deployed to Decentraland. In that case, you could add `*.blend` to _.dclignore_ to ignore all files with that extension.

| What to ignore | Example     | Description                                                                             |
| -------------- | ----------- | --------------------------------------------------------------------------------------- |
| Specific files | `BACKUP.ts` | Ignores a specific file                                                                 |
| Folders        | `drafts/`   | Ignores entire contents of a folder and its subfolders                                  |
| Extensions     | `*.blend`   | Ignores all files with a given extension                                                |
| Name sections  | `test*`     | Ignores all files with names that match the query. In this case, that start with _test_ |

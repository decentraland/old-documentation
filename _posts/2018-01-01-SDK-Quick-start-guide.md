---
date: 2018-01-02
title: SDK Quick start guide
description: Decentraland Software Development Kit
categories:
  - SDK
type: Document
set: getting-started-sdk
set_order: 3
---
The Decentraland CLI is distributed via [npm](https://www.npmjs.com/get-npm?utm_source=house&utm_medium=homepage&utm_campaign=free%20orgs&utm_term=Install%20npm), and is available for MacOS, Windows, and Linux based operating systems.

You can install the CLI with:

```
npm install -g decentraland
```

> Please make sure that you have the following dependencies installed before beginning your CLI installation
>  * [Python 2.7.14](https://www.python.org/downloads/)
>  * [node.js](https://github.com/decentraland/cli#nodejs-installation) version 8 or above with the [npm](https://www.npmjs.com/get-npm?utm_source=house&utm_medium=homepage&utm_campaign=free%20orgs&utm_term=Install%20npm) package manager (npm is bundled with node.js)
>  * [IPFS](https://dist.ipfs.io/#go-ipfs)

## Notes for installing on Windows

1. Install [Node.js v8 LTS](https://nodejs.org/en/download/)
2. Find the Command Prompt app and select **Run as Administrator**
3. Install windows-build-tools by running 
`npm install --global --production windows-build-tools`
4. Wait for both the Visual Studio Build Tools and Python installers to both read `Successfully installed xxxx`. Once these have installed successfully, you will be returned to the command prompt.
5. [Download git](https://git-scm.com/download/win) (you'll likely want the 64-bit Windows version)
6. Install git and when prompted choose to install **git bash**
7. When prompted for a default text editor select **Use the Nano editor by default**
8. When prompted to adjust your path environment, select **Use Git** from the Windows Command Prompt
9. When prompted to choose the SSH executable, select **Use OpenSSH**
10. When prompted to choose the HTTPS transport backend, select **Use the OpenSSL library**
11. When prompted to configure the line ending conversions, select **Checkout Windows-style, commit Unix-style line endings**
12. When prompted to configure the terminal emulator to use with Git Bash select **Use MinTTY**
13. On the final installation screen select the following options
  * **Enable file system caching**
  * **Enable Git Credential Manager**
  * **Enable symbolic links**

## Notes for installing on Linux

If you are installing the CLI on a Linux-based operating system, run
`npm i -g --unsafe-perm decentraland`

# Create Your First Scene

```
dcl init
```

The `dcl init` command creates a Decentraland **project** in your current working directory containing a **scene** using the default structure outlined below. You will be prompted to enter some descriptive metadata that will be stored in your [scene.json](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki) manifest file. All of this metadata is optional except for scene type (static, dynamic & singleplayer, or dynamic & multiplayer). See below for a description of each of these scene types.

> If you run `dcl init` in a folder containing other Decentraland projects, any existing files with duplicate names will be overwritten with the new, initialized project files.

## Default scene structure

**Scenes** in Decentraland are the collections of 3D objects, textures, and audio rendered on one or more LAND parcels. Scenes can be:

* **Static:** using an XML file, you can add simple 3D objects and audio to your scene.
* **Dynamic & Singleplayer:** scenes built using the SDK that allow a single player to interact with content in the scene. The script is run on a web worker.
* **Dynamic & Multiplayer:** you can run a server using the JSON-RPC API over WebSockets to generate and manipulate content rendered in your scene. Dynamic multiplayer scenes are still in beta, but we’ve included these in the SDK for you to start experimenting with.

Scenes are generated and stored within projects, and follow this basic structure:

```
├── scene.json  
├── scene.tsx (optional)
├── scene.xml (generated for static scenes)  
├── package.json
├── build.json
└── tsconfig.json
```

## scene.json

The scene.json file is a JSON formatted manifest for a scene in the world. A scene can spawn multiple parcels of LAND, or a single LAND parcel. The scene.json manifest describes what objects exist in the scene, a list of any assets needed to render it, contact information for the parcel owner, and security settings. For more information and an example of a scene.json file, please visit the [Decentraland specification proposal](https://github.com/decentraland/proposals/blob/master/dsp/0020.mediawiki).

## scene.tsx

If you are creating a locally run scene, this file contains the code that will be run for each client that is visiting your parcel. A very basic example of these scenes looks like this:

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

## package.json

This file is used to give information to npm that allows it to identify the project as well as handle the project's dependencies.  Decentraland scenes need two packages:

* `metaverse-api`, which allows the scene to communicate with the world engine
* `typescript`, to compile the file scene.tsx to javascript

> You don’t need the `typescript` package when creating static scenes. This is only required when you are building remote and interactive scenes.

## build.json

Decentraland build configuration file. This guides our command line tool and provides the context it needs to build a static scene, compile TypeScript, or generate the code to connect to a remote WebSocket.

## tsconfig.json

Directories containing a tsconfig.json file are root directories for TypeScript Projects. The tsconfig.json file specifies the root files and options required to compile your project in JavaScript. 

> **Why do we use Typescript?**  
> TypeScript is a superset of JavaScript and allows you to employ object oriented programming and type declaration. Features like autocomplete and type-checking speed up development times and allow for the creation of a solid codebase. These features are all key components to a positive developer experience.
> 
> You can use another tool or language instead of TypeScript, so long as your scripts are contented within a single Javascript file (scene.js). All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

# Scene types

## Static Scenes

Static scenes are merely collections of 3D objects, textures, and audio arranged in a scene using XML. You can take content from an application like [Blender](https://www.blender.org/), or a 3D model downloaded from [Sketchfab](https://sketchfab.com/) and using the markup stored in `scene.xml`, arrange it in your scene.

```xml
<scene>
  <gltf-model
    position="10 0 0"
    scale="0.5 0.5 0.5"
    src="models/Forest/Forest_20x20.gltf"
    id="Forest"
  />
  <!-- OBJ models are also supported:
    <obj-model position="10 0 0"
      scale="0.5 0.5 0.5"
      src="models/Forest/Forest_10x10.obj"
      mtl="models/Forest/Forest_10x10.mtl"
     id="Forest"/>
  -->
</scene>
```

## Dynamic Single Player Scenes

If you choose to generate a dynamic single player scene a `scene.tsx` file will be created. This file exports a `ScriptableScene` that lets you split the experience into independent, reusable pieces so that you can isolate your required behavior. 

### Scriptable Scene Lifecycle

Each `ScriptableScene` has several “lifecycle methods” that you can override to run code at particular times in the process. Methods prefixed with `will` are called right before something happens, and methods prefixed with `did` are called right after something happens.

```tsx
interface ScriptableScene<Props, State> {
  props: Props
  state: State

  /**
   * Called to determine whether the change in props and state should trigger a re-render.
   *
   * If false is returned, `ScriptableScene#render`, and `sceneDidUpdate` will not be called.
   */
  shouldSceneUpdate?(nextProps: Props, nextState: State): boolean

  /**
   * Called immediately before a scene is destroyed. Perform any necessary cleanup in this method, such as
   * cancelled network requests, or cleaning up any elements created in `sceneDidMount`.
   */
  sceneWillUnmount?(): void

  /**
   * Called immediately after a compoment is mounted. Setting state here will trigger re-rendering.
   */
  sceneDidMount?(): void

  /**
   * Called immediately after updating occurs. Not called for the initial render.
   */
  sceneDidUpdate?(prevProps: Readonly<Props>, prevState: Readonly<State>): void
}
```

For a better understanding of the API, refer to [this overview](https://docs.decentraland.org/docs/sdk-overview#section-elements-of-the-api) and start browsing through our [scene examples](https://github.com/decentraland/sample-scenes).

## Dynamic Multiplayer Scenes

All of the components that describe your experience are compiled into one script. When your parcels are rendered in the client, this script runs in the context of a WebWorker, or remotely in a server.  This makes it possible for you to run custom logic inside the player's client, allowing you to create richer experiences in Decentraland.

When you create a multiplayer scene, your scene.json will point to a host URL. The scene.json script will communicate with the host application through a JSON-RPC2 based protocol using a defined transport.  The CLI bootstraps a server that configures a WebSocketTransport and inits a RemoteScene.  For running this scene you should start the WebSocket server first. 

# Preview your scene

To preview your rendered scene locally before uploading it to IPFS, run

```
dcl preview
```

This preview also provides some useful debugging information and tools to help you understand how different entities are rendered. The preview mode provides information describing parcel boundaries and environmental and resource information, like the number of entities being rendered, the current FPS rate, user position, and whether or not different elements are exceeding parcel boundaries.

> When previewing old scenes that you built before this release of the SDK, you will still have to install the latest versions of the `metaverse-api` and `metaverse-rpc` packages in your project.

## Parcel limitations

In order to improve performance in the metaverse, we have established a set of limits that every scene must follow.  If a scene exceeds these limitations then the parcel won’t be loaded and the preview will display an error message. With *n* representing the number of parcels that a scene will fill, the following are the maximum number of elements allowed:

* **Triangles:** *log2(n+1) x 10000*
* **Entities:**  *log2(n+1)  x 200*
* **Materials:**  *log2(n+1) x 300*
* **Textures:**  *log2(n+1) x 10* (up to 512x512px each)

Parcel boundaries are enforced. If any content exceeds parcel boundaries, the preview will display highlight that content in red. **Height** is restricted to **log2(n+1)  x 20** meters where **n** is the number of parcels included in the scene.

When your parcel is rendered, any static content extending beyond your parcel’s boundaries will be replaced with an error message. All dynamic entities that cross your parcel boundaries will be deleted from the scene.

# Publish Your Scene

To publish your scene:

* Log into the Metamask account with the same public address associated with your parcel.
* Start up an IPFS daemon by following [these instructions](https://ipfs.io/docs/getting-started/).
* Finally, run `dcl deploy`

This will update your parcel with your latest changes in addition to uploading your content to IPFS. To improve performance and user experience, your content will be pinned to Decentraland’s main IPFS server to ensure that the data needed to render your parcel is readily available 

> You don’t have to pay a gas fee everytime you deploy your content. The smart contract for your LAND is only updated when you link your content to IPNS, the naming service for IPFS.

While this command will deploy your scene to your parcel, remember that users can’t currently explore Decentraland, so your content won’t be discoverable “in-world”.

## What is IPFS?

[IPFS](https://ipfs.io/) (short for Inter-Planetary File System) is a hypermedia protocol and a P2P network for distributing files. The filesystem is content-addressed, meaning that each file is identified by its contents, not an arbitrary filename.

We use IPFS to host and distribute all scene content in a similar way to BitTorrent, keeping the Decentraland network distributed. Of course, for better performance, we run an “IPFS Gateway”, which means that Decentraland is hosting most of the content referenced from the blockchain (after certain filters are applied) to improve the experience of exploring the world.

In order to upload your files, you’ll need to run an IPFS node. After “pinning” your scene’s content (that means, notifying the network that your files are available) our IPFS nodes will try to download the files using the IPFS network, eventually reaching your computer and copying over the files.

To run an IPFS node, please follow [these instructions](https://ipfs.io/docs/getting-started/).

### What does IPFS have to do with my LAND?

IPFS serves two primary functions for Decentraland.

1. IPFS stores and distributes all of the assets required to render your scenes.
2. The `dcl deploy` command links these assets with the LAND parcel specified in your **scene.json** file. Whenever you redeploy your scene, the CLI will update your LAND smart contract, if needed, to point to the most recent content available on IPFS.

# Scene examples

To get you up and running, and to illustrate what kind of experiences you can build using the SDK, we’ve put together some [code and scene examples](https://github.com/decentraland/sample-scenes).

## Static Scene

This is an example of a completely static scene. We've laid out a sample space to show off how you can use a layout from blender or a resource like [Sketchfab](https://sketchfab.com/) to build your first static Decentraland scene. [Link](https://github.com/decentraland/sample-scenes/tree/master/01-static-scene)

## Dynamic Animation

With this Dynamic Animation, we demonstrate how to employ simple data binding to objects in your scene. Translation, rotation, and scale are all properties you can bind to state values. [Link](https://github.com/decentraland/sample-scenes/tree/master/02-dynamic-animation)

## Interactive Content

The interactive door in this example shows how to handle reticle click input events from the user. The large, red dot in the center of the viewport determines which object you're currently focused on. [Link](https://github.com/decentraland/sample-scenes/tree/master/03-interactive-door)

## Skeletal Animations

In your scenes, you can load up an interactive GLTF model and trigger its animations. This is an example of how to do that. [Link](https://github.com/decentraland/sample-scenes/tree/master/04-skeletal-animation)

## Multiplayer Content

In this example, you can interact with a door by opening and closing it, while another player is in the same room. This simple example is built to give you a glimpse into how a multi-user environment will work where each user is able to interact with the same entities. [Link](https://github.com/decentraland/sample-scenes/tree/master/08-multiuser-EXPERIMENTAL)
---
date: 2018-01-02
title: SDK Quick start guide
description: Decentraland Software Development Kit
categories:
  - SDK
type: Document
set: getting-started
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
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

Use our CLI tool to automatically build the initial boilerplate scene. To do so, run `dcl init` in an empty folder. See [SDK Overview]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-01-SDK-Overview %}) for details on how to install and use the CLI.

The `dcl init` command creates a Decentraland **project** in your current working directory containing a **scene**. It prompts you to answer a series of optional questions about the scene's ownership and where in Decentraland to eventually upload it, then it asks you to select a scene template to start from. Depending on what you choose for this option, the CLI builds a different file structure with different default content.

There are four different scene templates that you can use as a starting point:

- **Basic scene**: Defined in a simple TypeScript file that renders a single glTF model.
- **Local scene**: Defined in a TypeScript file featuring an example with a door that can be opened. This is the best template to start learning how to use the SDK. The scene features a basic state and handles click events. The scene state is stored locally in the users's browser, so a user's actions don't affect how other users see the scene rendered.
- **Remote scene**: Defined in a TypeScript file featuring the same example used for the local scene, but it differs in that the scene state is stored in a remote server that it communicates with over WebSockets. Because of this, all users see the scene rendered identically. If you're developing a game or another kind of interactive experience, this is most likely how you want it to work. To test your scene, you can run both the server and the client locally.
- **Static scene**: Defined in an **XML** file with a single glTF moel. You can't add any dynamic or interactive content to this type of scene, it can only display static entities in place.

See [scene contents]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-11-scene-files %}) for an overview of the default files that are created in your scene.

## Preview your scene

To preview your rendered scene locally, run the following command on the scene's main folder:

```bash
dcl start
```

Every time you make changes to the scene, the preview reloads and updates automatically, so there's no need to run the command again.

For more about what you can see in a scene preview, and instructions for how to run a preview of a remote scene, see [preview your scene]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-04-preview-scene %}).

## Edit your scene

To edit scenes, we recommend using a source code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/). An editor like this helps you create scenes a lot faster and with less errors, as it marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. With Visual Studio Code you can even click on an object to see the full definition of its class.

- In _Basic_ and _Interactive_ scenes, you create the logic of your scene by editing the _Scene.tsx_ file.
- In _Remote_ scenes, you create the logic of your scene by editing the _RemoteScene.tsx_ file and the _State.tsx_.
- In _Static_ scenes, you create the content of your scene in the _scene.xm_ file.

See [scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for simple instructions about adding content to your scene.

Once you're done creating the scene and want to upload it to your LAND, see [publishing]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-07-publishing %}).

---
date: 2018-01-01
title: Creating your first scene
description: Learn the basics of Decentraland scenes
redirect_from:
  - /documentation/create-scene/
categories:
  - getting-started
type: Document
set: getting-started
set_order: 1
tag: introduction
---

In Decentraland, a scene is the representation of the content of an estate/LAND. All scenes are made up of [entities]({{ site.baseurl }}{% post_url /development-guide/2018-06-21-entity-interfaces %}), which represent all of the elements in the scene and are arranged into tree structures, very much like elements in a DOM tree in web development.

## Install the CLI

Make sure you first install the CLI tools. In Mac OS, you do this by running the following command:

```bash
npm install -g decentraland
```

See the [Installation Guide]({{ site.baseurl }}{% post_url /getting-started/2018-01-01-installation-guide %}) for more details and specific instructions for Windows and Linux systems.

## Create a default scene

Use our CLI tool to automatically build the initial boilerplate scene. To do so:

1. Create a new folder where you want to create the scene
2. Open Terminal in Mac or Command prompt in Windows and run the following command in the folder you just created:

   ```bash
   dcl init
   ```

The `dcl init` command creates a Decentraland **project** in your current working directory containing a **scene**.

The default scene is defined in a TypeScript file featuring an example with a door that can be opened. The scene features a basic state and handles click events.

<!--
There are four different scene templates that you can use as a starting point:

- **Basic scene**: Defined in a simple TypeScript file that renders a single glTF model.
- **Interactive scene**: Defined in a TypeScript file featuring an example with a door that can be opened. This is the best template to start learning how to use the SDK. The scene features a basic state and handles click events. The scene state is stored locally in the user's browser, so a user's actions don't affect how other users see the scene rendered.
- **Remote scene**: Defined in a TypeScript file featuring the same example used for the local scene, but it differs in that the scene state is stored in a remote server that it communicates with over WebSockets. Because of this, all users see the scene rendered identically. To test your scene, you can run both the server and the client locally.
- **Static scene**: Defined in an **XML** file with a single glTF model. You can't add any dynamic or interactive content to this type of scene, it can only display static entities in place. -->

See [scene contents]({{ site.baseurl }}{% post_url /development-guide/2018-01-11-scene-files %}) for an overview of the default files that are created in your scene.

## Clone a sample scene

Instead of creating a new scene, you can clone one of the existing [sample scenes]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}) and use that as a starting point.

To do so:

1. Go to [sample scenes]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %})
2. Find a sample you like and open the **Code** link to go to its GitHub repo.
3. From there you can either:
   1. Fork the repo to start working on your own version of it.
   2. Click **Clone or Download** and select to download it as a _.zip_ file.

## Preview your scene

To preview your rendered scene locally, run the following command on the scene's main folder:

```bash
dcl start
```

Every time you make changes to the scene, the preview reloads and updates automatically, so there's no need to run the command again.

For more about what you can see in a scene preview, and instructions for how to run a preview of a remote scene, see [preview your scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-04-preview-scene %}).

## Edit your scene

To edit scenes, we recommend using a source code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/). An editor like this helps you create scenes a lot faster and with less errors, as it marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. With Visual Studio Code you can even click on an object to see the full definition of its class.

- You create the logic of your scene by editing the _Scene.tsx_ file.
- You define scene properties, like the parcels it covers or owner information, in the _scene.json_ file.

See the [development guide]({{ site.baseurl }}{% post_url /development-guide/2018-01-21-scene-content %}) for simple instructions about adding content to your scene.

## Publish your scene

Once you're done creating the scene and want to upload it to your LAND, see [publishing]({{ site.baseurl }}{% post_url /getting-started/2018-01-07-publishing %}).

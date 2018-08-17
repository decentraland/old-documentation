---
date: 2018-01-01
title: SDK Overview
redirect_from:
  - /docs/sdk-overview
  - /docs/command-line-interface
  - /docs/sdk-quick-start-guide
description: Decentraland Software Development Kit
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 1
---

## Introduction

The **Decentraland Software Development Kit** includes the alpha version of our API, tools like the CLI, and all of the supporting documentation and examples that you need in order to create, test, manage, and deploy 3D content in Decentraland. The SDK allows content creators and developers to create either static or dynamic scenes that will run on the Decentraland platform.

#### Requirements

Please note that it’s not required to have LAND to develop a scene. Developing and testing a scene can be done completely offline, without the need to deploy a scene to the Ethereum network (the system Decentraland uses to establish ownership of LAND), or IPFS (the P2P network we use for distribution and delivery of content).

This SDK is intended to be used by developers or users comfortable working with code and a terminal. Most of our tools are built on top of the TypeScript and node.js ecosystem. That’s why you’ll need to have **npm** (the node packaging system) installed to develop a scene, even for basic static scenes built using markup instead of code.

#### Capabilities

At a very high level, the SDK allows you to do the following:

- Generate a default _project_ containing your first scene, the collection of assets needed to render and run your content.
- Build, test, and preview the content of your scene in your web browser - completely offline, and without having to make any Ethereum transactions or own LAND.
- Write TypeScript scripts using the API to add interactive and dynamic behavior to your scenes.
- Upload the content of your scene to [IPFS](https://ipfs.io).
- Link your LAND with the IPFS URL of the content you have uploaded.

#### What are scenes?

**Scenes** in Decentraland are the collections of 3D objects, textures, and audio rendered on one or more LAND parcels. Scenes can be:

- _Local scenes_: intended to run inside the user's client. Your scenes run inside a WebWorker, that means you don't need any server to create an experience.
- _Remote scenes_: useful to create richer experiences that require a centralized coordination of the scene's state or that are too sensible to execute in every user's computers. These scenes run in a Node.js server and connect with the clients through a WebSockets interface.
- _Static_: containing only 3D objects and audio, but no interaction.

Scenes are created in "projects" using the CLI.

##### Where will these scenes be hosted?

Scenes are deployed to **parcels**, the 10 meter by 10 meter pieces of virtual LAND, the scarce and non-fungible asset maintained in an Ethereum smart contract. These parcels of virtual space are where you will eventually upload and interact with the content you create using the SDK.

##### How will users be able to see and interact with these scenes?

We are developing the web client that will allow users to explore Decentraland. All of the content you upload to your LAND will be rendered and viewable through this client. We have included a preview tool in the SDK so that you can preview, test, and interact with your content in the meantime.

**The Decentraland client is still under active development. We're shooting for a public release by the end of 2018. Stay tuned for future updates!**

For additional terms, definitions, and explanations, please refer to our [complete Glossary]({{ site.baseurl }}{% post_url /general/2018-01-03-glossary %}).

## Installing the SDK

The SDK includes a lot of different parts and components. For detailed, step-by-step instructions on how to download and install everything in the SDK, please refer to the [SDK Quick Start Guide]({{ site.baseurl }}{% post_url documentation/building-scenes/2018-01-01-installation-guide %}).

#### CLI

The Decentraland Command Line Interface (CLI) allows you to create, deploy, and manage your scenes in a development environment that does not reside on the block-chain or IPFS (InterPlanetary File System).

After generating your new Decentraland scene locally on your own machine, you can immediately begin editing your scene using a text editor of your choice. After testing your scene locally, you can use the CLI to upload your content to IPFS.

For more step-by-step instructions on installing the CLI, please read our [SDK Quick Start Guide]({{ site.baseurl }}{% post_url documentation/building-scenes/2018-01-01-installation-guide %}) or the [CLI Tutorial](https://docs.decentraland.org/v1.0/docs/command-line-interface)

#### API

`decentraland-api` (formerly `metaverse-api` and still commonly referred to as _the API_) is the name for the TypeScript package containing the library of helper methods that allows you to create interactive singleplayer and multiplayer experiences. The API includes methods allowing you to create and manipulate objects on your LAND, in addition to methods that help facilitate in-world transactions between users or other applications.

## Elements of the API

The API includes everything within the package `decentraland-api`. This is all of the classes and helper methods that you will need to use when writing your TypeScript scenes, whether your scene is static, dynamic, or remote.

We have designed the Decentraland API to enable scene development using the Entity Component System, where **entities** include all of the assets that users will be able to interact with within their web browser (like audio files, video files, and 3D objects) and **components** function as the bridge between the low-level functionality of the client and the scripts that you write to control the entities in your scene.

#### What are entities?

Entities are all of the assets that you include in your scenes that users will be able to render, view, and interact with from their web browser. These include audio files and 3D objects.

Internally, the scene you present is generated through a tree of entities.

#### What are the components?

For a complete reference of the API, with descriptions of every component and method, please see the [API Reference](https://decentraland.github.io/cli/).

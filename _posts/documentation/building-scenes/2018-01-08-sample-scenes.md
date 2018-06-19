---
date: 2018-01-06
title: Sample scenes
description: Code and scene examples using our SDK
categories:
  - documentation
type: Document
set: building-scenes
set_order: 8
---
To get you up and running, and to illustrate what kind of experiences you can build using the SDK, we’ve put together some [code and scene examples](https://github.com/decentraland/sample-scenes).

## Static Scene

This is an example of a completely static scene. We've laid out a sample space to show off how you can use a layout from blender or a resource like [Sketchfab](https://sketchfab.com/) to build your first static Decentraland scene. [Link](https://github.com/decentraland/sample-scenes/tree/master/01-static-scene)

## Dynamic Animation

With this Dynamic Animation, we demonstrate how to employ simple data binding to objects in your scene. Translation, rotation, and scale are all properties you can bind to state values. [Link](https://github.com/decentraland/sample-scenes/tree/master/02-dynamic-animation)

## Interactive Content

The interactive door in this example shows how to handle click input events from the user. The large red dot in the center of the viewport determines which object you're currently focused on. [Link](https://github.com/decentraland/sample-scenes/tree/master/03-interactive-door)

## Skeletal Animations

In your scenes, you can load up an interactive GLTF model and trigger its animations. This is an example of how to do that. [Link](https://github.com/decentraland/sample-scenes/tree/master/04-skeletal-animation)

## Multiplayer Content

In this example, you can interact with a door by opening and closing it, while another player is in the same room. This simple example is built to give you a glimpse into how a multi-user environment will work where each user is able to interact with the same entities. [Link](https://github.com/decentraland/sample-scene-server)

## Multiplayer Content

In this example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/sdk-highlight-building-an-underwater-landscape-5bfcce73ff35), you can explore an underwater scene with animated fish. As the scene's state is shared amongst all users, other players see the fish in the same locations. [link](https://github.com/decentraland/sample-scenes/tree/master/08-multiuser-EXPERIMENTAL)

## Video Support

In this example, you can interact with two video players. One loads the video company into the scene's assets, the other streams it from an external source. You can also pause, stop and change the volume of the video players. [Link](https://github.com/decentraland/sample-scenes/tree/master/05-video-support)

## Simple Memory Game

In this example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/building-a-memory-game-using-decentralands-sdk-87ee35968f8d), you play with a "Simon Says" game. This game is a good example of how to add more complex logic into a scene and how to change its state based on how the user interacts with it. [link](https://github.com/decentraland/sample-scene-memory-game)
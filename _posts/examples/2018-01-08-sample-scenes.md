---
date: 2018-01-06
title: Sample scenes
description: Code and scene examples using our SDK
categories:
  - examples
type: Document
set: examples
set_order: 1
---

To get you up and running, and to illustrate what kind of experiences you can build using the SDK, we’ve put together some [code and scene examples](https://github.com/decentraland/sample-scenes).

## Beginner samples

### Static Scene

This is an example of a completely static scene. We've laid out a sample space to show off how you can use a layout from blender or a resource like [Sketchfab](https://sketchfab.com/) to build your first static Decentraland scene. [Link](https://github.com/decentraland/sample-scene-static)

### Dynamic Animation

With this Dynamic Animation, we're demonstrating how to employ simple data binding to objects in your scene. [Translation, rotation, and scale]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) are all attributes you can bind to state properties. [Link](https://github.com/decentraland/sample-scene-dynamic-animation)

### Interactive Content

This simple example shows a scene that you can interact with by opening and closing a door. Clicking the door creates an [event]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-03-event-handling %}), which changes the scene's state. The scene's state then changes the rotation of the door, which rotates smoothly thanks to a transition.
[Link](https://github.com/decentraland/sample-scene-script)

### Skeletal Animations

In your scenes, you can load up an interactive [GLTF model]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) and trigger its animations. This is an example of how to do that. [Link](https://github.com/decentraland/sample-scene-skeletal-animation)

## Intermediate samples

### Sound Support

This example features [sound]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) coming out of an entity, notice how the volume diminishes relative to distance from it. It also includes an animated GLTF object and a floor that randomly changes color. [Link](https://github.com/decentraland/sample-scene-sound-support)

### Video Support

In this example, you can interact with two video players. One loads the video company into the scene's assets, the other streams it from an external source. You can also pause, stop and change the volume of the video players. [Link](https://github.com/decentraland/sample-scene-video-support)

### Multiplayer Content

In this example, based on the door example in the beginner samples, you interact with a door by opening and closing it, while another player is in the same room seeing the door's state changes. This simple example is built to give you a glimpse into how a multi-user environment works where multiple users interact with the same entities. [Link](https://github.com/decentraland/sample-scene-server)

Note: A similar sample is discussed in greater detail in a [blogpost](https://blog.decentraland.org/sdk-highlight-building-an-underwater-landscape-5bfcce73ff35).

## Advanced samples

### Simple Memory Game

In this example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/building-a-memory-game-using-decentralands-sdk-87ee35968f8d), you play with a "Simon Says" game. This game is a good example of how to add more complex logic into a scene and how to change its state based on how the user interacts with it. [link](https://github.com/decentraland/sample-scene-memory-game)

### Pay to open

In this example, based on the door example in the beginner samples, you're only allowed to open the door if you've paid 10 MANA to a specific wallet. The sample shows how you can use the SDK to track blockchain transactions.
[link](https://github.com/decentraland/sample-scene-payments)

<!---
### Redux

-->

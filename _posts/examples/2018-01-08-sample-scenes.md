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

To get you up and running, and to illustrate what kind of experiences you can build using the SDK, we’ve put together some code and scene examples.

Some of these scenes feature a link to a version of the scene that's deployed on a remote server. There you can interact with it just as if you were running `dcl start` locally.

## Beginner samples

#### Static Scene

This is an example of a completely static scene. We've laid out a sample space to show off how you can use a layout from blender or a resource like [Sketchfab](https://sketchfab.com/) to build your first static Decentraland scene.

[code](https://github.com/decentraland/sample-scene-static)

[explore the scene](https://dcl-project-aobsbnmsdl.now.sh/?position=0%2C-1)

#### Dynamic Animation

With this Dynamic Animation, we're demonstrating how to employ simple data binding to objects in your scene. [Translation, rotation, and scale]({{ site.baseurl }}{% post_url /scene-coding-guide/2018-01-12-entity-positioning %}) are all attributes you can bind to state properties.

[code](https://github.com/decentraland/sample-scene-dynamic-animation)

[explore the scene](https://dcl-project-fkmccoyvhb.now.sh/?position=0%2C-1)

#### Interactive Content

This simple example shows a scene that you can interact with by opening and closing a door. Clicking the door creates an [event]({{ site.baseurl }}{% post_url /scene-coding-guide/2018-01-03-event-handling %}), which changes the scene's state. The scene's state then changes the rotation of the door, which rotates smoothly thanks to a transition.

[code](https://github.com/decentraland/sample-scene-script)

[explore the scene](https://dcl-project-inksbqgcjj.now.sh/?position=-41%2C-113)

#### Skeletal Animations

In your scenes, you can load up an interactive [GLTF model]({{ site.baseurl }}{% post_url /scene-coding-guide/2018-01-21-scene-content %}) and trigger its animations. This is an example of how to do that.

[code](https://github.com/decentraland/sample-scene-skeletal-animation)

[explore the scene](https://dcl-project-tiroqwvfop.now.sh/?position=0%2C1)

## Intermediate samples

#### Sound Support

This example features [sound]({{ site.baseurl }}{% post_url /scene-coding-guide/2018-01-21-scene-content %}) coming out of an entity, notice how the volume diminishes relative to distance from it. It also includes an animated GLTF object and a floor that randomly changes color.

[code](https://github.com/decentraland/sample-scene-sound-support)

[explore the scene](https://dcl-project-lolxizhsmy.now.sh/?position=-1%2C-1)

#### Jukebox: Buttons and Sound

This example, that's described in greater detail in a [video tutorial](https://steemit.com/tutorial/@hardlydifficult/decentraland-tutorial-creating-a-music-jukebox), you operate a jukebox. Each button plays a different song. Buttons are animated, and clicking on one raises any others that were previously clicked.

[code](https://github.com/decentraland/sample-scene-jukebox)

[explore the scene](https://dcl-project-nvahvjzeiz.now.sh/?position=42%2C42)

#### Video Support

In this example, you can interact with two video players. One loads the video company into the scene's assets, the other streams it from an external source. You can also pause, stop and change the volume of the video players.

[code](https://github.com/decentraland/sample-scene-video-support)

[explore the scene](https://dcl-project-ffueiuubku.now.sh/?position=0%2C-1)

#### Multiplayer Content

In this example, based on the door example in the beginner samples, you interact with a door by opening and closing it, while another player is in the same room seeing the door's state changes. This simple example is built to give you a glimpse into how a multi-user environment works where multiple users interact with the same entities.

[code](https://github.com/decentraland/sample-scene-server)

Note: A similar sample is discussed in greater detail in a [blogpost](https://blog.decentraland.org/sdk-highlight-building-an-underwater-landscape-5bfcce73ff35).

#### Dynamic number of entities

In this example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/developer-tutorial-creating-a-dynamic-flock-of-hummingbirds-8c2cd41f8296), a new bird appears and starts flying randomly around the scene each time you click on a tree. It's a good example of how to build multiple entities from an array and of how to handle 3D model animations.

[code](https://github.com/decentraland/sample-scene-array-of-entities/blob/master/README.md)

[explore the scene](https://dcl-project-xdoolmuwqt.now.sh/?position=0%2C-1)

## Advanced samples

#### Simple Memory Game

In this example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/building-a-memory-game-using-decentralands-sdk-87ee35968f8d), you play with a "Simon Says" game. This game is a good example of how to add more complex logic into a scene and how to change its state based on how the user interacts with it.

[code](https://github.com/decentraland/sample-scene-memory-game)

[explore the scene](https://dcl-project-asliohkpyt.now.sh/?position=0%2C0)

#### Pay to open

In this example, based on the door example in the beginner samples, you're only allowed to open the door if you've paid 10 MANA to a specific wallet. The sample shows how you can use the SDK to track blockchain transactions.

[code](https://github.com/decentraland/sample-scene-payments)

#### Block Dog

In this example, that's described in greater detail in a [video tutorial](https://steemit.com/tutorial/@hardlydifficult/decentraland-tutorial-basic-ai-with-block-dog), you control a pet dog. The dog has its own autonomous actions that it performs randomly. It also follows you around, sits when cicked and goes to drink when you click its bowl.

[code](https://github.com/decentraland/sample-scene-Block-Dog)

[explore the scene](https://dcl-project-meybigwwvv.now.sh/?position=42%2C41)

#### Chess game

This example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/developer-tutorial-port-a-redux-chess-game-to-decentraland-49f509b2eba6), takes an existing 2D chess game and builds a 3D scene around it in decentraland. The game can only start when two players have accepted to join the game, and each can only interact with the scene when it's their turn.

[code](https://github.com/cazala/decentraland-redux-chess-app)

#### Tower defense game

This example, that's described in greater detail in a [video tutorial](https://steemit.com/tutorial/@hardlydifficult/decentraland-tutorial-a-simple-tower-defense-game), shows a simple tower defense game. The game generates a random path, and places traps in random locations along that path. Then enemy entities are spawn and follow this path, unless you activate the traps to stop them. The game supports multiple players, has a scoreboard and has a reset button to restart the game at any time.

[code](https://github.com/decentraland/sample-scene-tower-defense-game)

#### Dog, cat, mouse, cheese

This example, that's described in greater detail in a [video tutorial](https://steemit.com/tutorial/@hardlydifficult/decentraland-tutorial-dog-cat-mouse-cheese-using-a-fsm) shows how to build a more complex scene that involves predators and prays, which can interchangeably be mice, cats or dogs. Each animal has a stack-based finite state machine (FSM) to manage its AI. Each animal uses the a\* path finding algorithm to find its way around obstacles and other animals.

[code](https://dcl-project-bfvkjmdtyf.now.sh)

[explore the scene](https://dcl-project-bfvkjmdtyf.now.sh/?position=42%2C43)

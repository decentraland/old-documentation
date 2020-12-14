---
date: 2018-01-06
title: SDK Scene examples
description: Code and scene examples using our SDK
categories:
  - examples
type: Document
---

To get you up and running, and to illustrate what kind of experiences you can build using the SDK, we’ve put together some code and scene examples.

Some of these scenes feature a link to a version of the scene that's deployed on a remote server. There you can interact with it just as if you were running `dcl start` locally.

# Clone an example scene

Instead of creating a new scene from scratch, you can clone one of the existing example scenes and use that as a starting point.

To do so:

1. Find an example you like from the ones listed below.
2. Open the **Code** link to visit its GitHub repo.
3. From there you can either:
   1. _Fork the repo_ to work on your own version of it, that will exist in a cloned GitHub repo that belongs to you.
   2. Click **Clone or Download** and select to download it as a _.zip_ file, to work on the files locally, without GitHub being involved.

# Essentials

## Shark animation

This simple scene shows how to add animations to a `GLTFComponent` and handle click events.

- glTF models
- animations
- click events

![]({{ site.baseurl }}/images/media/example-shark-animation.png)

[Code](https://github.com/decentraland-scenes/Shark-animation)

[Explore the scene](https://shark-animation-qehbwatsry.now.sh)

## Puffer fish

This simple scene shows how to use the [utils library](https://www.npmjs.com/package/decentraland-ecs-utils) to scale an entity gradually.

- glTF models
- scaling an entity
- delaying a function
- adding a sound clip

![]({{ site.baseurl }}/images/media/example-puffer.png)

[Code](https://github.com/decentraland-scenes/Puffer)

[Explore the scene](https://puffer.decentraland1.now.sh/?position=-132,-40)

## Hypno wheels

This simple scene features a couple of wheels that you can spin by clicking them.

- rotate an entity
- glTF models
- click events
- textures
- custom components
- component groups

![]({{ site.baseurl }}/images/media/example-hypno-wheel.png)

[Code](https://github.com/decentraland-scenes/Hypno-wheels)

[Explore the scene](https://hypno-wheels-xmirhqdurz.now.sh)

Read a tutorial [blog post](https://decentraland.org/blog/tutorials/intro-to-sdk-v5/) about this scene.

## Open the door

A simple interactive scene with a door that can be opened and closed.

- `Slerp()` function for rotation
- click events
- materials
- parent entities
- custom components
- component groups

![]({{ site.baseurl }}/images/media/example-door.png)

[Code](https://github.com/decentraland-scenes/Open-door)

[Explore the scene](https://open-door-inqgibkgwc.now.sh)

## Sliding door

A simple interactive scene with a two-sided door that can be opened by clicking.

- `Lerp()` function for moving
- click events
- materials
- parent entities
- custom components
- component groups

![]({{ site.baseurl }}/images/media/example-sliding-doors.png)

[Code](https://github.com/decentraland-scenes/Sliding-door)

[Explore the scene](https://sliding-door-nzpxlhlaiy.now.sh)

## Jukebox

A scene where you can play different songs by pressing buttons on a jukebox.

- audio
- glTF models
- `Lerp()` function for moving
- click events
- materials
- parent entities
- custom components
- component groups

![]({{ site.baseurl }}/images/media/example-jukebox.png)

[Code](https://github.com/decentraland-scenes/Jukebox)

[Explore the scene](https://jukebox-ilgtrpcfvb.now.sh)

## Basic interactions

A scene with a simple example of each way in which players can interact. Each shape's color is activated by interacting with it.

- Click events
- PointerUp and PointerDown events
- Player position
- Global pointer events
- Animations

![]({{ site.baseurl }}/images/media/example-basic-interactions.png)

[Code](https://github.com/decentraland-scenes/Basic-Interactions)

<!--
[Explore the scene]()
-->

## Dance floor

A scene with animations, sound, and tiles on the floor that randomly change color to the beat.

- audio
- glTF models
- animations
- materials
- custom components
- component groups

![]({{ site.baseurl }}/images/media/example-dance-floor.png)

[Code](https://github.com/decentraland-scenes/Dance-floor)

[Explore the scene](https://dancefloor-rsylsclrna.now.sh)

## Smoke

This scene shows how to handle a particle system to create smoke. Each smoke puff is an entity that moves in a specific direction. These entities are reused from an object pool instead of creating a new entity for each. When an entity floats away from the fire, it's removed from the scene and waits in the object pool to be reused.

![]({{ site.baseurl }}/images/media/example-smoke.png)

[Code](https://github.com/decentraland-scenes/Smoke)

[Explore the scene](https://smoke-sjjygzpfug.now.sh)

## Memory game

A Simon Says game, with click interactions and sequenced actions. The game generates a random sequence of colors and you must click buttons to match those.

- glTF models
- materials
- click events
- custom components
- component groups

![]({{ site.baseurl }}/images/media/example-memory-game.png)

[Code](https://github.com/decentraland-scenes/Memory-game)

[Explore the scene](https://memory-game-vkysoawcea.now.sh)

# Movement

## Hummingbirds

A scene where hummingbirds spawn when you click a tree. Each bird moves on its own to random positions.

![]({{ site.baseurl }}/images/media/example-hummingbirds.png)

[Code](https://github.com/decentraland-scenes/Hummingbirds)

[Explore the scene](https://hummingbirds-unrchjydpo.now.sh)

## Gnark patrolling

A scene that shows a character walking along a fixed path, using lerp over each segment of the path. If you approach it, it will switch to yelling at you.

![]({{ site.baseurl }}/images/media/example-gnark.png)

[Code](https://github.com/decentraland-scenes/Gnark-patrol)

[Explore the scene](https://gnark-patrol-ypvlmwbkhe.now.sh)

Read a tutorial blog post about this scene:

- [Part 1](https://decentraland.org/blog/tutorials/motion-animations-in-SDK-5/)
- [Part 2](https://decentraland.org/blog/tutorials/motion-animations-in-SDK-5-part-2/)

## Swimming shark

This scene shows a shark moving around in circles along a curved circular path, using lerp over each segment of the path. It also rotates smoothly with a spherical lerp function.

The speed of the shark and the intensity with which it swims depends on the steepness of the segment.

![]({{ site.baseurl }}/images/media/example-shark-animation.png)

[Code](https://github.com/decentraland-scenes/Swimming-shark)

[Explore the scene](https://swimming-shark-fnbuyslcqi.now.sh)

# Network connections

## Weather simulation

A scene that checks a weather API for the weather in a location and displays that weather condition, showing rain, thunder or snowflakes
Use real weather data from different locations by changing the coordinates, or change the value of the “fakeWeather” variable to see different weather conditions manifest.

- Call external REST API

![]({{ site.baseurl }}/images/media/example-weather.png)

[Code](https://github.com/decentraland-scenes/Weather-simulation)

[Explore the scene](https://weather-pkfkpxankv.now.sh)

## Remote door

A scene that uses a server and a REST API to sync a scene state amongst multiple players. It’s built around the basic “open the door” example.

- Create a REST server
- Call REST API

![]({{ site.baseurl }}/images/media/example-door.png)

[Code](https://github.com/decentraland-scenes/Remote-door)

<!--
[Explore the scene]()
-->

## Remote mural

A scene that uses a server and a REST API to sync a scene state amongst multiple players. You can paint pixels in a mural that other players can see. The colors of each pixel are stored in a remote server.

- Create a REST server
- Call REST API

![]({{ site.baseurl }}/images/media/example-remote-mural.png)

[Code](https://github.com/decentraland-scenes/Remote-mural)

<!--
[Explore the scene]()
-->

## Picture frame

A scene that displays a crypto collectible NFT in a picture frame. See [display a certified NFT]({{ site.baseurl }}{% post_url /development-guide/2018-02-01-display-a-certified-nft %}) for more details.

![]({{ site.baseurl }}/images/media/example-kitty.png)

[Code](https://github.com/decentraland-scenes/Certified-criptokitty)

# Custom UI

## Mining rocks

A simple scene that shows how to build a custom UI that can be interacted with by the player and that is upated as the player interacts with the world

[Code](https://github.com/decentraland-scenes/Mining-rocks)

[Explore the scene](https://mining-rocks-pjyyjqdfdt.now.sh)

# Blockchain transactions

## MANA Transfer

A simple scene that uses the MANA smart contract and the EthConnect library to send the player MANA on the Ropsten test network.

[Code](https://github.com/decentraland-scenes/MANA-Transaction)

[Explore the scene](https://mana-transaction-jfsdmqqnmp.now.sh)

## MANA Burning Altar

Fees collected by the Marketplace are stored in a wallet. This scene interacts with the MANA contract to burn this MANA that was collected.

The flame is created as a particle system, handling various entities that spiral around as they change colors.

![]({{ site.baseurl }}/images/media/example-mana-altar.png)

[Code](https://github.com/decentraland-scenes/MANA-Burning-Altar)

[Explore the scene](https://mana-altar-nmfgwmfbjo.now.sh)

# Advanced

## Block Dog

A scene with a simple AI character. It randomly chooses what action to take: follow you, sit or remain idle. You can also tell it to sit or stand up by clicking it, or tell it to drink water by clicking its bowl.

![]({{ site.baseurl }}/images/media/example-blockdog.png)

[Code](https://github.com/decentraland-scenes/Block-dog)

[Explore the scene](https://blockdog-flbnuykvwf.now.sh)

## Escape room

A full escape room game, where each room is a puzzle to be interacted with in different ways.

This scene is showcased by a [video tutorial series](https://www.youtube.com/watch?v=j7XbiTZ9GN0&list=PLAcRraQmr_GOhimaVZSlJrkzCvo8crIBQ) that walks you through all the mechanics, starting from the basic concepts.

![]({{ site.baseurl }}/images/media/example-escaperoom.png)

[Code](https://github.com/decentraland-scenes/dcl-escape-room-tutorial)

## Tower defense game (WIP)

A fully-fledged game where a random 2d path is generated along which enemies walk, and where traps are randomly placed. You need to activate the traps as the enemies advance along the path to kill them. It’s all about timing.

![]({{ site.baseurl }}/images/media/example-tower-defense.png)

[Code](https://github.com/decentraland-scenes/Tower-defense)

<!--
[Explore the scene]()
-->

## Castaway 2048 (WIP)

A fully fledged game, based on the popular game 2048, where the values are represented by a series of gems of increasing values. Click and drag to displace the gems on the board and merge them into greater values till you reach 2048.

![]({{ site.baseurl }}/images/media/example-2048.png)

[Code](https://github.com/decentraland-scenes/Castaway-2048)

<!--
[Explore the scene]()
-->

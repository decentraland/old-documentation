---
date: 2018-01-06
title: Scene examples
description: Code and scene examples using our SDK
categories:
  - examples
type: Document
set: examples
set_order: 1
---

To get you up and running, and to illustrate what kind of experiences you can build using the SDK, we’ve put together some code and scene examples.

Some of these scenes feature a link to a version of the scene that's deployed on a remote server. There you can interact with it just as if you were running `dcl start` locally.

## Static XML Scenes

#### Static XML Scene

A completely static scene. It's built entirely using XML, which makes it easier to write and edit, but doesn't support any changes over time or interactions with the user.

![](/images/media/example-static.png)

[Code](https://github.com/decentraland-scenes/XML-static-scene)


## Essentials

#### Static Scene with Animations

A simple static scene that just displays 3D models. The 3D models include animations to move the butterflies, flames, etc.

![](/images/media/example-muna.png)

[Code](https://github.com/decentraland-scenes/the-munastery)

[Explore the scene](https://the-munastery-lwbodqmcwg.now.sh/?position=-13%2C-14)


#### Hypno wheels

This simple scene features a couple of wheels that you can spin by clicking them. 

- rotate an entity
- glTF models
- click events
- textures
- custom components 
- component groups

![](/images/media/example-hypno-wheel.png)

[Code](https://github.com/decentraland-scenes/Hypno-wheels)

[Explore the scene](https://hypno-wheels-owyfnqfimw.now.sh/?position=0%2C-1)

Read a tutorial [blog post](https://decentraland.org/blog/tutorials/intro-to-sdk-v5) about this scene.

#### Shark animation

This simple scene shows how to add animations to a `GLTFComponent` and handle click events.

- glTF models
- animations
- click events

![](/images/media/example-shark-animation.png)

[Code](https://github.com/decentraland-scenes/Shark-animation)

[Explore the scene](https://shark-animation-xriykgapld.now.sh/)

#### Open the door

A simple interactive scene with a door that can be opened and closed.

- `Slerp()` function for rotation
- click events
- materials
- parent entities
- custom components 
- component groups

![](/images/media/example-door.png)

[Code](https://github.com/decentraland-scenes/Open-door)

[Explore the scene](https://open-door-gssoyhoyrt.now.sh)

#### Sliding door

A simple interactive scene with a two-sided door that can be opened by clicking.

- `Lerp()` function for moving
- click events
- materials
- parent entities
- custom components 
- component groups

![](/images/media/example-sliding-doors.png)

[Code](https://github.com/decentraland-scenes/Sliding-door)

[Explore the scene](https://slidingdoor-fmydyuprjl.now.sh)

#### Jukebox

A scene where you can play different songs by pressing buttons on a jukebox.

- audio
- glTF models
- `Lerp()` function for moving
- click events
- materials
- parent entities
- custom components 
- component groups

![](/images/media/example-jukebox.png)

[Code](https://github.com/decentraland-scenes/Jukebox)

<!--
[Explore the scene]()
-->

#### Dance floor
A scene with animations, sound, and tiles on the floor that randomly change color to the beat.

- audio
- glTF models
- animations
- materials
- custom components 
- component groups

![](/images/media/example-dance-floor.png)

[Code](https://github.com/decentraland-scenes/Dance-floor)

<!--
[Explore the scene]()
-->

#### Memory game

A Simon Says game, with click interactions and sequenced actions. The game generates a random sequence of colors and you must click buttons to match those.

- glTF models
- materials
- click events
- custom components 
- component groups

![](/images/media/example-memory-game.png)


[Code](https://github.com/decentraland-scenes/Memory-game)

<!--
[Explore the scene]()
-->

## Movement

#### Hummingbirds

A scene where hummingbirds spawn when you click a tree. Each bird moves on its own to random positions.

![](/images/media/example-hummingbirds.png)

[Code](https://github.com/decentraland-scenes/Hummingbirds)

[Explore the scene](https://hummingbirds-ujovmbtmui.now.sh)

#### Gnark patrolling

A scene that shows a character walking along a fixed path, using lerp over each segment of the path. If you approach it, it will switch to yelling at you.

![](/images/media/example-gnark.png)

[Code](https://github.com/decentraland-scenes/Gnark-patrol)

[Explore the scene](https://gnark-patrol-azhbtehsge.now.sh)

Read a tutorial blog post about this scene:

- [Part 1]((https://decentraland.org/blog/tutorials/motion-animations-in-SDK-5))
- Part 2 (coming soon)

## Network connections

#### Weather simulation

A scene that checks a weather API for the weather in a location and displays that weather condition, showing rain, thunder or snowflakes
Use real weather data from different locations by changing the coordinates, or change the value of the “fakeWeather” variable to see different weather conditions manifest.

- Call external REST API

![](/images/media/example-weather.png)

[Code](https://github.com/decentraland-scenes/Weather-simulation)

[Explore the scene](https://weather-yvahddfxgo.now.sh)

#### Remote door

A scene that uses a server and a REST API to sync a scene state amongst multiple users. It’s built around the basic “open the door” example.

- Create a REST server
- Call REST API

![](/images/media/example-door.png)

[Code](https://github.com/decentraland-scenes/Remote-door)

<!--
[Explore the scene]()
-->

#### Remote mural

A scene that uses a server and a REST API to sync a scene state amongst multiple users. You can paint pixels in a mural that other users can see. The colors of each pixel are stored in a remote server.

- Create a REST server
- Call REST API

![](/images/media/example-remote-mural.png)


[Code](https://github.com/decentraland-scenes/Remote-mural)

<!--
[Explore the scene]()
-->

## Blockchain transactions

#### MANA Transfer

A simple scene that uses the MANA smart contract and the EthConnect library to send the user MANA on the Ropsten test network.

[Code](https://github.com/decentraland-scenes/MANA-Transaction)

[Explore the scene](https://mana-transaction-sxjmryeayj.now.sh)

#### MANA Burning Altar

Fees collected by the Marketplace are stored in a wallet. This scene interacts with the MANA contract to burn this MANA that was collected.

The flame is created as a particle system, handling various entities that spiral around as they change colors.

![](/images/media/example-mana-altar.png)

[Code](https://github.com/decentraland-scenes/MANA-Burning-Altar)

[Explore the scene](https://mana-altar-master-iehcppnlvz.now.sh/)

## Advanced

#### Block Dog

A scene with a simple AI character. It randomly chooses what action to take: follow you, sit or remain idle. You can also tell it to sit or stand up by clicking it, or tell it to drink water by clicking its bowl.

![](/images/media/example-blockdog.png)

[Code](https://github.com/decentraland-scenes/Block-dog)

[Explore the scene](https://blockdog-wtciaozdbo.now.sh/?position=0%2C0)

#### Tower defense game (WIP)

A fully-fledged game where a random 2d path is generated along which enemies walk, and where traps are randomly placed. You need to activate the traps as the enemies advance along the path to kill them. It’s all about timing.

![](/images/media/example-tower-defense.png)

[Code](https://github.com/decentraland-scenes/Tower-defense)

<!--
[Explore the scene]()
-->

#### Castaway 2048 (WIP)

A fully fledged game, based on the popular game 2048, where the values are represented by a series of gems of increasing values. Click and drag to displace the gems on the board and merge them into greater values till you reach 2048.

![](/images/media/example-2048.png)

[Code](https://github.com/decentraland-scenes/Castaway-2048)

<!--
[Explore the scene]()
-->

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

## Static XML Scenes

#### Static XML Scene

A completely static scene. It's built entirely using XML, which makes it easier to write and edit, but doesn't support any changes over time or interactions with the user.

![](/images/media/example-static.png)

[Code](https://github.com/decentraland/sample-scene-static-xml)


## Essentials

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

[Explore the scene]()

#### Shark animation

This simple scene shows how to add animations to a `GLTFComponent` and handle click events.

- glTF models
- animations
- click events

![](/images/media/example-shark-animation.png)

[Code](https://github.com/decentraland-scenes/Shark-animation)

[Explore the scene]()

#### Open the door

A simple interactive scene with a door that can be opened and closed.

- `Slerp()` function for rotation
- click events
- materials
- parent entities
- custom components 
- component groups

![](/images/home/door.png)

[Code](https://github.com/decentraland-scenes/Open-door)

[Explore the scene]()

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

[Explore the scene]()

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

[Explore the scene]()


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

[Explore the scene]()

#### Memory game

A Simon Says game, with click interactions and sequenced actions. The game generates a random sequence of colors and you must click buttons to match those.

- glTF models
- materials
- click events
- custom components 
- component groups

![](/images/media/example-memory-game.png)


[Code](https://github.com/decentraland-scenes/Memory-game)

[Explore the scene]()

## Movement

#### Hummingbirds

A scene where hummingbirds spawn when you click a tree. Each bird moves on its own to random positions.

![](/images/home/hummingbirds.png)

[Code](https://github.com/decentraland-scenes/Hummingbirds)

[Explore the scene]()

#### Gnark patrolling

A scene that shows a character walking along a fixed path, using lerp over each segment of the path. If you approach it, it will switch to yelling at you.

![](/images/media/example-gnark.png)

[Code](https://github.com/decentraland-scenes/Gnark-patrol)

[Explore the scene]()


## Network connections

#### Weather simulation

A scene that checks a weather API for the weather in a location and displays that weather condition, showing rain, thunder or snowflakes
Use real weather data from different locations by changing the coordinates, or change the value of the “fakeWeather” variable to see different weather conditions manifest.

- Call external REST API

![](/images/media/example-weather.png)

[Code](https://github.com/decentraland-scenes/Weather-simulation)

[Explore the scene]()

#### Remote door

A scene that uses a server and a REST API to sync a scene state amongst multiple users. It’s built around the basic “open the door” example.

- Create a REST server
- Call REST API

![](/images/home/door.png)

[Code](https://github.com/decentraland-scenes/Remote-door)

[Explore the scene]()


#### Remote mural

A scene that uses a server and a REST API to sync a scene state amongst multiple users. You can paint pixels in a mural that other users can see. The colors of each pixel are stored in a remote server.

- Create a REST server
- Call REST API

![](/images/media/example-remote-mural.png)


[Code](https://github.com/decentraland-scenes/Remote-mural)

[Explore the scene]()

## Advanced

#### Block Dog

A scene with a simple AI character. It randomly chooses what action to take: follow you, sit or remain idle. You can also tell it to sit or stand up by clicking it, or tell it to drink water by clicking its bowl.

![](/images/home/blockdog.png)

[Code](https://github.com/decentraland-scenes/Block-dog)

[Explore the scene]()

#### Tower defense game (WIP)

A fully-fledged game where a random 2d path is generated along which enemies walk, and where traps are randomly placed. You need to activate the traps as the enemies advance along the path to kill them. It’s all about timing.

![](/images/media/example-tower-defense.png)

[Code](https://github.com/decentraland-scenes/Tower-defense)

[Explore the scene]()

#### Castaway 2048 (WIP)

A fully fledged game, based on the popular game 2048, where the values are represented by a series of gems of increasing values. Click and drag to displace the gems on the board and merge them into greater values till you reach 2048.

![](/images/media/example-2048.png)

[Code](https://github.com/decentraland-scenes/Castaway-2048)

[Explore the scene]()
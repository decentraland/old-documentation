---
date: 2018-02-22
title: Event listeners
description: Events that the scene can track, related to player actions and scene changes.
categories:
  - development-guide
type: Document
---

There are several events that the scene can subscribe to, to know the actions of the player while in or near the scene.

For button and click events performed by the player, see [Button events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}).

## Player connects/disconnects

Whenever another player starts or stops being rendered by the local engine, this creates an event you can listen to. Players may or may not be standing on the same scene as you, but must be within visual range (not necessarily in sight). The `onPlayerConnectedObservable` detects both when a player newly connects nearby or comes close enough to be in visual range, likewise the `onPlayerDisconnectedObservable` detects when a player ends their session or or walks far away.

```ts
onPlayerConnectedObservable.add((player) => {
  log("player entered: ", player.userId)
})

onPlayerDisconnectedObservable.add((player) => {
  log("player left: ", player.userId)
})
```

Keep in mind that if other players are already being rendered in the surroundings before the player has loaded your scene, this event won't notify the newly loaded scene of the already existing players. If you need to keep track of all present players, you can query for existing players upon scene loading, and then listen for this event for updates.

```ts
getConnectedPlayers().then((players) => {
  players.forEach((player) => {
    log("player was already here: ", player.userId)
  })
})
```

## Player enters or leaves the scene

Whenever the player steps inside or out of the parcels of land that make up your scene, or teleports in or out, this creates an event you can listen to.

```ts
onEnterSceneObservable.add(() => {
  log("onEnterSceneObservable")
})

onLeaveSceneObservable.add(() => {
  log("onLeaveSceneObservable")
})
```

These events are especially useful in a multiplayer scene, to connect and disconnect players from servers only when they are standing on the scene's parcels.

// TODO: your player only vs all players

> Note: The `onLeaveSceneObservable` is only triggered if the player leaves gracefully. If the player closes the browser abruptly, the events won't be picked up. Keep this in mind for multiplayer scenes.
> // TODO : does this also apply to other players?

> Note: This event only responds to players that are currently being rendered. In large scenes where the scene size exceeds the visual range, players entering in the opposite corner may not be registered. If the number of players in the region exceeds the capabilities of an island on Decentraland servers, players that are not sharing a same island aren't visible and are not tracked by these events either.

You can get the full list of players who are currently on your scene and being rendered by calling `getPlayersInScene()`.

```ts
getPlayersInScene().then((players) => {
  players.forEach((player) => {
    log("player was already here: ", player.userId)
  })
})
```

<!--
## Player moves

Whenever a player moves, this also generates events that can be listened to.

```ts
onPositionChangedObservable.add((eventData) => {
  log("position:", eventData.position)
  log("world position:", eventData.cameraPosition)
})
onRotationChangedObservable.add((eventData) => {
  log("rotation: ", eventData.rotation)
  log("quaternion: ", eventData.quaternion)
})
```

The event detected by `onPositionChangedObservable` includes the following data:

- position
- cameraPosition
- playerHeight

The event detected by `onRotationChangedObservable` includes the following data:

- rotation: The camera's rotation in Euler angles
- quaternion: The camera's rotation in Quaternion angles

> Note: The rotation refers to that of the camera, not to that of the avatar. So if the player is in 3rd person, the avatar may be facing a different direction than the camera.

Using these events is a lot more efficient than fetching the `Camera.instance.position` and `Camera.instance.rotation` on every frame, as there are no updates when the player stays still. Since this position & rotation data updates 10 times a second, it also means that checking these values on every frame (30 times a second) will result in many repeat readings. This gain in efficiency is especially noticeable when communicating position data to a multiplayer server.

```ts
const cube = new Entity()
cube.addComponent(new BoxShape())
let cubeTransform = new Transform({ position: new Vector3(5, 1, 5) })
cube.addComponent(cubeTransform)
engine.addEntity(cube)

onRotationChangedObservable.add((eventData) => {
  cubeTransform.rotation = eventData.rotation
})
```

The example above uses the player's rotation to set that of a cube in the scene.

> Note: The `onRotationChangedObservable`, `onPositionChangedObservable` data is updated at a throttled rate of 10 times per second. Due to this, positions may lag slightly in relation to the scene that runs at 30 FPS under ideal conditions.
-->

## Player changes camera mode

When the player changes the camera mode between 1st and 3rd person in or near your scene, this creates an event you can listen to.

```ts
onCameraModeChangedObservable.add(({ cameraMode }) => {
  log("Camera mode changed:", cameraMode)
})
```

The value of the returned property can either be `CameraMode.FirstPerson` or `CameraMode.ThirdPerson`.

This event informs changes to the camera mode once the player is already in or near your scene. To know the initial camera mode of the player when first arriving to your scene, check the value of `Camera.instance.cameraMode`. See [User Data]({{ site.baseurl }}{% post_url /development-guide/2018-02-22-user-data %}#check-the-players-camera-mode).

```ts
// intitial camera mode
log("Camera mode: ", Camera.instance.cameraMode)

// check for changes
onCameraModeChangedObservable.add(({ cameraMode }) => {
  log("Camera mode changed:", cameraMode)
})
```

## Player plays animation

Whenever the player plays an emote (dance, clap, wave, etc), you can detect this event.

```ts
onPlayerExpressionObservable.add(({ expressionId }) => {
  log("Expression: ", expressionId)
})
```

The event includes the following information:

- expressionId: Name of the emote performed (ie: _wave_, _clap_, _kiss_)

Note: This event is triggered any time the player makes an emote and the scene is loaded. The player could be standing in a nearby scene when this happens.

## Player goes idle

Whenever the player is inactive for a full minute, without interacting with any input being picked up by the Decentraland explorer, we can consider the player to be idle. Whenever this happens, it creates an event that you can listen to.

```ts
onIdleStateChangedObservable.add(({ isIdle }) => {
  log("Idle State change: ", isIdle)
})
```

The `isIdle` property is a boolean value that is _true_ when the player enters the idle mode and _false_ when the player leaves the idle mode.

This event is especially useful for multiplayer scenes, when you might want to disconnect from the server players who are likely away from the machine or left Decentraland in a tab in the background.

> Note: The idle state is inferred based on the player not using the keyboard or mouse for a full minute. This can of course produce false positives, for example a player might be watching other players interact or watching a video stream, standing still but fully engaged. Be mindful of these corner cases and what the experience is like for a player who stands still for a while.

## Scene finished loading

When the scene finishes loading, the `onSceneReadyObservable` gets called. This works both if the player loads straight into the scene, or if the player walks up to the scene from somewhere else. When all of the content in the scene has finished its initial load, including heavy models, etc, this event is called.

```ts
onSceneReadyObservable.add(() => {
  log("SCENE LOADED")
})
```

## Player starts/ends the tutorial

When a new player first enters Decentraland for the fist time, they go through a brief tutorial that shows the basic movements and UI elements. Typically players will experience this on Genesis Plaza, but a new player that enters a specific scene from an event as their first time in Decentraland will experience a shortened version of that tutorial wherever they are.

This tutorial includes some music, that could clash with the music of the scene that the player is currently on, so it's recommended to stop any background music in case the player is going through the tutorial.

```ts
import { tutorialEnableObservable } from "src/modules/tutorialHandler"

tutorialEnableObservable.add((tutorialEnabled) => {
  if (tutorialEnabled) {
    log("Player started tutorial")
    backgroundMusicSource.playing = false
  } else {
    log("Player finished tutorial")
    backgroundMusicSource.playing = true
  }
})
```

> Note: This event only occurs when the player starts or ends the tutorial. It doesn't get called at all in case the player has already experienced the tutorial in a prior session or scene.

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

## Player connects or disconnects

Whenever another player starts or stops being rendered by the local engine, this creates an event you can listen to. Players may or may not be standing on the same scene as you, but must be within visual range (not necessarily in sight). The `onPlayerConnectedObservable` detects both when a player newly connects nearby or comes close enough to be in visual range, likewise the `onPlayerDisconnectedObservable` detects when a player ends their session or or walks far away.

```ts
onPlayerConnectedObservable.add((player) => {
  log("player entered: ", player.userId)
})

onPlayerDisconnectedObservable.add((player) => {
  log("player left: ", player.userId)
})
```

Keep in mind that if other players are already being rendered in the surroundings before the player has loaded your scene, this event won't notify the newly loaded scene of the already existing players. If you need to keep track of all current players, you can query for existing players upon scene loading, and then listen to this event for updates.

```ts
import { getConnectedPlayers } from "@decentraland/Players"

executeTask(async () => {
  let players = await getConnectedPlayers()
  players.forEach((player) => {
    log("player was already here: ", player.userId)
  })
})
```

## Player enters or leaves scene

Whenever an avatar steps inside or out of the parcels of land that make up your scene, or teleports in or out, this creates an event you can listen to. This event is triggered by all avatars, including the player's.

```ts
onEnterSceneObservable.add((player) => {
  log("player entered scene: ", player.userId)
})

onLeaveSceneObservable.add((player) => {
  log("player left scene: ", player.userId)
})
```

> Note: This event only responds to players that are currently being rendered locally. In large scenes where the scene size exceeds the visual range, players entering in the opposite corner may not be registered. If the number of players in the region exceeds the capabilities of an island on Decentraland servers, players that are not sharing a same island aren't visible and are not tracked by these events either.

#### Only current player

You can filter out the triggered events to only react to the player's avatar, rather than other avatars that may be around.

```ts
import { getUserData } from "@decentraland/Identity"

executeTask(async () => {
  let myPlayer = await getUserData()

  onEnterSceneObservable.add((player) => {
    log("player entered scene: ", player.userId)
    if (player.userId === myPlayer?.userId) {
      log("I entered the scene!")
    }
  })

  onLeaveSceneObservable.add((player) => {
    log("player left scene: ", player.userId)
    if (player.userId === myPlayer?.userId) {
      log("I left the scene!")
    }
  })
})
```

This example first obtains the player's id, then subscribes to the events and compares the `userId` returned by the event to that of the player.

#### Query all players in scene

You can also get the full list of players who are currently on your scene and being rendered by calling `getPlayersInScene()`.

```ts
import { getPlayersInScene } from "@decentraland/Players"

executeTask(async () => {
  let players = await getPlayersInScene()
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

The values of the returned property can be:

- `CameraMode.FirstPerson`
- `CameraMode.ThirdPerson`

This event is fired once when the scene first obtains information about the player's current camera mode, and then any time the player changes camera mode while in or around your scene.

> Tip: To encourage players to use a particular camera mode in your scene, display a UI message advising them to switch modes whenever they use the wrong one.

Knowing the camera mode can be very useful to fine-tune the mechanics of your scene to better adjust to what's more comfortable using this mode. For example, small targets are harder to click when on 3rd person.

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

## Player clicks on another player

Whenever the player clicks on another player, you can detect an event.

```ts
onPlayerClickedObservable.add((clickEvent) => {
  log("Clicked ", clickEvent.userId, " details: ", clickEvent.ray)
})
```

Note: Both the player performing the click and the player being clicked must be standing within the parcels of the scene. This listener only detects events of the current player clicking on other players, not those of clicks performed by other players.

The event includes the following data:

- `userId`: The id of the clicked player
- `ray`: Data about the ray traced by the click
  - `direction`: _Vector3_ A normalized Vector3 that represents the direction from the point of origin of the click to the hit point of the click.
  - `distance`: _number_ The distance in meters from the point of origin to the hit point.
  - `origin`: _Vector3_ The point of origin of the click, the position of the player who did the click, relative to the scene.

Tip: The default behavior of clicking on another player is opening the player passport, where you can see additional information about that player, add them as a friend, etc. You can disable the opening of this UI so that it doesn't get in the way of the experience you want to build by adding an [Avatar Modifier Area]({{ site.baseurl }}{% post_url /development-guide/2020-09-24-avatar-modifiers %}).

## Player locks/unlocks cursor

Players can switch between two cursor modes: _locked cursor_ mode to control the camera or _unlocked cursor_ mode for moving the cursor freely over the UI.

Players unlock the cursor by clicking the _Right mouse button_ or pressing the _Esc_ key, and lock the cursor back by clicking anywhere in the screen.

This `onPointerLockedStateChange` event is activated each time a player switches between these two modes, while near the scene.

```ts
onPointerLockedStateChange.add(({ locked }) => {
  if (locked) {
    log("Pointer has been locked")
  } else {
    log("Pointer has been unlocked")
  }
})
```

> Note: This event is triggered even if the player is not standing directly inside the scene.

The `locked` property from this event is a boolean value that is _true_ when the player locks the cursor and _false_ when the player unlocks the cursor.

This event is useful if the player needs to change cursor modes and may need a hint for how to lock/unlock the cursor.

This can also be used in scenes where the player is expected to react fast, but the action can take a break while the player has the cursor unlocked.

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

## Player changes profile

Whenever the player makes a change to their profile, the `onProfileChanged` event is called. These changes may include putting on different wearables, changing name, description, activating portable experiences, etc.

```ts
onProfileChanged.add((profileData) => {
  log("Own profile data is ", profileData)
})
```

Event data includes only the ID of the player and a version number for that avatar's profile, according to the catalyst server. Every time a change is propagated, the version number increases by 1.

> Tip: When this event is triggered, you can then use the [getUserData()]({{ site.baseurl }}{% post_url /development-guide/2018-02-22-user-data %}#get-player-data) function to fetch the latest version of this information, including the list of wearables that the player has on. You may need to add a slight delay before you call `getUserData()` to ensure that the version this function returns is up to date.

When testing in preview, run the scene with `dcl start --web3` so that you connect with your wallet. Otherwise, you will be using a random avatar.

> Note: This event is only triggered by changes to the current player, not by changes on the profiles of other nearby players.

## Scene finished loading

When the scene finishes loading, the `onSceneReadyObservable` gets called. This works both if the player loads straight into the scene, or if the player walks up to the scene from somewhere else. When all of the content in the scene has finished its initial load, including heavy models, etc, this event is called.

```ts
onSceneReadyObservable.add(() => {
  log("SCENE LOADED")
})
```

## Video playing

When a `VideoTexture` changes its playing status, the `onVideoEvent` observable receives an event.

```ts
onVideoEvent.add((data) => {
  log("New Video Event ", data)
})
```

The input of a video event contains the following properties:

- `videoClipId` ( _string_): The ID for the `VideoTexture` component that changed status.
- `componentId` (_string_): The ID of the `VideoTexture` component that changed status.
- `currentOffset` (_number_): The current value of the `seek` property on the video. This value shows seconds after the video's original beginning. _-1_ by default.
- `totalVideoLength` (_number_ ): The length in seconds of the entire video. _-1_ if length is unknown.
- `videoStatus`: The value for the new video status of the `VideoTexture`, expressed as a value from the `VideoStatus` enum. This enum can hold the following possible values:

- `VideoStatus.NONE` = 0,
- `VideoStatus.ERROR` = 1,
- `VideoStatus.LOADING` = 2,
- `VideoStatus.READY` = 3,
- `VideoStatus.PLAYING` = 4,
- `VideoStatus.BUFFERING` = 5

Learn more about playing videos in Decentraland in [Video Playing]({{ site.baseurl }}{% post_url /development-guide/2020-05-04-video-playing %}).

## Player changes realm or island

Players in decentraland exist in separate _realms_, and in separate _islands_ within each realm. Players in different realms or islands cant see each other, interact or chat with each other, even if they're standing on the same parcels.

Each time the player changes realms or island, the `onRealmChangedObservable` event gets called.

```ts
onRealmChangedObservable.add((realmChange) => {
  log("PLAYER CHANGED ISLAND TO ", realmChange.room)
})
```

This event includes the following fields:

- **serverName**: _string_; The catalyst server name.
- **room**: _string_; The island name.
- **displayName**: _string_; The catalyst server name followed by a _-_ and the island name. For example `unicorn-x011`.
- **domain**: _string_; The url to the catalyst server being used.

As players move through the map, they may switch islands to be grouped with those players who are now closest to them. Islands also shift their borders dynamically to fit a manageable group of people in each. So even if a player stands still they could be changed island as others enter and leave surrounding scenes.

If your scene relies on a [3rd party server]({{ site.baseurl }}{% post_url /development-guide/2018-01-10-remote-scene-considerations %}) to sync changes between players in real time, then you may want to only share data between players that are grouped in a same realm+island, so it's a good practice to change rooms in the 3rd party server whenever players change island.

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

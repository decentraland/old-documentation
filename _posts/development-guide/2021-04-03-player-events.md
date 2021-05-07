---
date: 2018-02-22
title: Player events
description: Events triggered by the player's actions that the scene can track.
categories:
  - development-guide
type: Document
---

There are several events that the scene can subscribe to, to know the actions of the player while in or near the scene.

For button and click events, see [Button events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}).

## Player changes camera mode

When the player changes the camera mode between 1st and 3rd person in or near your sene, this creates an event you can listen to.

```ts
onCameraModeChangedObservable.add(({ cameraMode }) => {
  log("camera mode changed:", cameraMode)
})
```

The value of the returned property can either be `CameraMode.FirstPerson` or `CameraMode.ThirdPerson`.

> Note: This event informs you of changes to the camera mode once the player is already in or near your scene. To know the initial camera mode of the player when first arriving to your scene, check the value of `Camera.instance.cameraMode`. See [User Data]({{ site.baseurl }}{% post_url /development-guide/2018-02-22-user-data %}#check-the-player's-camera-mode)

## Player enters or leaves the scene

Whenever the player steps inside or out of the parcels of land that make up your scene, or teleports in or out, this creates an event you can listen to.

```ts
onEnterSceneObservable.add(({ userId }) => {
  log("onEnterSceneObservable: ", userId)
})

onLeaveSceneObservable.add(({ userId }) => {
  log("onLeaveSceneObservable: ", userId)
})
```

These events are especially useful in a multiplayer scene, to connect and disconnect players from servers only when they are standing on the scene's parcels.

> Warning: Currently these events don't work when running your scene in preview. They are only detectable when your scene runs in in production.

> Note: The event is only fired when the current player that is running the browser in their machine enters or leaves. Other players entering on leaving will only trigger the events in their running instances. The feature has been designed to eventually support detecting other players too, but that functionality is not implemented yet.

The `onLeaveSceneObservable` is only triggered if the player leaves gracefully. If the player closes the browser abruptly, the events won't be picked up.

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

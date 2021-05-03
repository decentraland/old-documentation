---
date: 2018-02-22
title: Player events
description: Events done by the player that you can track.
categories:
  - development-guide
type: Document
---

## Player changes camera mode

Whenever the player changes camera mode in or near your sene, this creates an event you can listen to.

```ts
onCameraModeChangedObservable.add(({ cameraMode }) => {
  log("camera mode changed:", cameraMode)
})
```

The value of the returned property can either be `CameraMode.FirstPerson` or `CameraMode.ThirdPerson`.

> Note: To know the initial camera mode that the player has on when first arriving to your scene, check the value of `Camera.instance.cameraMode`. See [User Data]({{ site.baseurl }}{% post_url /development-guide/2018-02-22-user-data %}#check-the-player's-camera-mode)

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

> Warning: Currently these events don't work when running your scene in preview. They are only detectable when your scene runs in in production.

> Note: The event is only fired when the current player that is running the browser in their machine enters or leaves. Other players entering on leaving will only trigger the events in their running instances. The feature has been designed to eventually support detecting other players too, but that functionality is not implemented yet.

## Player inactive

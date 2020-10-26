---
date: 2020-08-04
title: Move a player
description: Change a player's position inside the scene
categories:
  - development-guide
type: Document
---

To change the player's position in the scene, use the `movePlayerTo()` function. This function takes two arguments:

- `position`: Where to move the player, expressed as an object with _x_, _y_, and _z_ properties.
- `cameraTarget`: (optional) What direction to make the player face, expressed as an object with _x_, _y_, and _z_ properties that represent the coordinates of a point in space to stare at. If no value is provided, the player will maintain the same rotation as before moving.

```ts
import { movePlayerTo } from '@decentraland/RestrictedActions'
const respawner = new Entity()
respawner.addComponent(new BoxShape())
respawner.addComponent(new Transform({ position: new Vector3(8, 0, 8) }))
respawner.addComponent(
  new OnPointerDown(
    (e) => {
      movePlayerTo({ x: 1, y: 0, z: 1 }, { x: 8, y: 1, z: 8 })
    },
    { hoverText: "Move player" }
  )
)

engine.addEntity(respawner)
```

The player's movement occurs instantly, without any confirmation screens or camera transitions.

> Note: Players can only be moved if they already are standing inside the scene's bounds, and can only be moved to locations that are inside the limits of the scene's bounds. You can't use `movePlayerTo()` to transport a player to another scene. To move a player to another scene, see [Teleports]({{ site.baseurl }}{% post_url /development-guide/2020-05-18-external-links %}#teleports).

You must first add the `ALLOW_TO_MOVE_PLAYER_INSIDE_SCENE` permission to the `scene.json` file before you can use this feature. If not yet present, create a `requiredPermissions` property at root level in the JSON file to assign it this permission.

```json
"requiredPermissions": [
    "ALLOW_TO_MOVE_PLAYER_INSIDE_SCENE"
  ],
```

See [Required permissions]({{ site.baseurl }}{% post_url /development-guide/2018-02-26-scene-metadata %}#required-permissions) for more details.

> Note: To prevent abusive behavior that might damage a player's experience, the ability to move a player is handled as a permission. Currently, this permission has no effect in how the player experiences the scene. In the future, players who walk into a scene with this permission in the `scene.json` file will be requested to grant the scene the ability to move them.

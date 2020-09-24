---
date: 2020-09-24
title: Avatar Modifiers
description: Specify an area on your scene where player avatars behave differently
categories:
  - development-guide
type: Document
---

Avatars behave and look consistently throughout Decentraland as they walk across scenes. However, you can add an `AvatarModifierArea` to a region of your scene to affect how player avatars behave when they enter that area.

## Placing Avatar Modifier Areas

Add an entity with an `AvatarModifierArea` component and position this entity by using a `Transform` component.

```ts
const modArea = new Entity()
modArea.addComponent(
  new AvatarModifierArea({
    area: { box: new Vector3(16, 4, 16) },
    modifiers: [AvatarModifiers.HIDE_AVATARS],
  })
)
modArea.addComponent(
  new Transform({
    position: new Vector3(8, 0, 8),
  })
)
engine.addEntity(modArea)
```

When creating an `AvatarModifierArea` component, you must provide two arguments:

- Size and shape of the modifier area
- An array listing the modifiers to implement in the area

The only currently supported shape for the area is `box`. Specify the scale of this box as a `Vector3`, for example
`{ box: new Vector3(16, 4, 16) }`.

> Note: The entirety of the area should be inside the limits of your scene, so as to not affect neighbor scenes.

The supported modifiers are:

- `AvatarModifiers.HIDE_AVATARS`
- `AvatarModifiers.DISABLE_PASSPORTS`

All the effects of an `AvatarModifierArea` only take place within the region of their area. Players return to normal when they walk out of the area.

An `AvatarModifierArea` affects only players that are inside the area, entering the area doesn't affect how other players that are outside the area are perceived.

The effects of an `AvatarModifierArea` are calculated locally for each player. You can have an `AvatarModifierArea` that is only present in the scene for some players and not for others. For example, if the area hides avatars, then the players that don't have the area in their local version of the scene will see all avatars normally. Even those that experience themselves as hidden. Players that do have the area will experience themselves and all other avatars as affected by the area when they enter it.

## Hide avatars

When a player walks into an `AvatarModifierArea` that has the `HIDE_AVATARS` modifier, the player's avatar stops being rendered. This applies both for the player in 3rd person view, and for when other players walk into the area.

This allows you to replace the default Decentraland avatar with any custom avatar you might want to show in your scene. Note that if you want to see other players with custom avatars, you should handle the syncing of player positions yourself.

## Disable Passport Popup

When a player walks into an `AvatarModifierArea` that has the `DISABLE_PASSPORTS` modifier, clicking on them no longer opens up the passport UI that shows the player bio, inventory, etc.

This is especially useful in games where accidentally opening this UI could interrupt the flow of a game, for example in a multiplayer shooter game.

---
date: 2018-02-11
title: Smart items
description: Make your scenes interactive. Items with built-in behaviors.
categories:
  - development-guide
redirect_from:
  - /documentation/scene-files/
type: Document
set: development-guide
set_order: 3
---

## Overview

Smart items are items that come with their own built-in behavior

Smart items have a purple background and a star logo
(image)

For example a door opens when clicked, or a sign post lets you add custom text on it

## Configure

Select an item to open a contextual menu. All smart items have configurable parameters

## Connect items via actions

Several items can trigger actions from other items.

For example a button smart item has a _When Clicked_ field, where you can select an action on another item, for example the _Open_ action of a door.

Trigger multiple actions in a single field. By clicking the plus sign you can add multiple actions to be triggered together.

Remove actions by clicking the three dots next to an action an select _Delete_ to remove it.

## Special smart items

- _Invisible wall_: An invisible cube that stops the player from walking through it. This item can be enabled or disabled by any other smart item.

- _Trigger area_: An invisible cube that can trigger actions on other smart items when the player enters or leaves the area. This item can be enabled or disabled by any other smart item.

- _Click area_: An invisible cube that can be clicked by players to trigger actions on any other smart items. This item can be enabled or disabled by any other smart item.

- _Ambient sound_: A sound source to play a series of pre-defined ambient sounds.

- _Arrow_: Show a hint arrow, pointing at something that the player should interact with. This item can be enabled or disabled by any other smart item, when disabled the arrow is invisible.

- _Message_:

* _Tools_: It can perform various actions with other items
  - Move / Rotate / Scale another item gradually: It smoothly transitions from one state to another over a given period of time. It can act on any item, smart or not. You can choose to use _relative_ or absolute positions - Delay: Wait a given amount of seconds before triggering an action in another smart item - Interval: Trigger an action in another smart item at a regular interval

> Note: Once an interval action starts repeating an action, it can't be stopped.

    - Message: Display a text message on the player's screen for a given amount of seconds. This message can be just for the player that triggered this or for all players in the scene.

## Multiplayer

Almost all smart items have multiplayer behavior. If player A opens a door, player B also sees that door open. If player C then walks into the scene while the other players are still there, she will see the door open too.

However, if there are no players near the scene, then it's restored to its default state. So if all players leave, but then player A comes back, she will find the door closed again.

Make sure you design your scene so that the actions of one player don't sabotage the scene for others that come later. For example, if the scene is a puzzle game, you can perhaps you can use a _delay_ action on a _tools_ smart item to make all the items in the scene reset to their initial state a few seconds after the puzzle is solved.

If there's a chance that a player can pick up a key and run off with it and block other player's progress, you can look into ways to prevent this. Perhaps have a _trigger area_ on the scene's exit door that calls the _drop_ action on the key, so that it returns to its place of origin.

## Troubleshooting

Colliders blocking clicks?

## Create your own smart items

link

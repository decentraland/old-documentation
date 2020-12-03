---
date: 2018-02-11
title: Smart items
description: Make your scenes interactive. Items with built-in behaviors.
categories:
  - builder
type: Document
---

Smart items are Builder items that come with their own built-in interactive behavior.

They often have fields that can be configured, like a text field in a sign post. They also can trigger actions on other items, for example a button smart item can call a door smart item to open it.

Smart items can be easily told apart in the item catalogue because their preview image has a purple background and a star logo on them.

<img src="{{ site.baseurl }}/images/media/builder-smart-items.png" alt="Smart items" width="250"/>

## Configure an item

To configure a smart item select it in your scene and a contextual menu opens on the right, showing all the configurable fields.

Different smart items have different fields that can be configured, depending on what makes sense for each.

<img src="{{ site.baseurl }}/images/media/builder-smart-items-menu.png" alt="Smart item menu" width="250"/>

## Call an action on another item

Many smart items can trigger actions on other smart items.

For example, a button smart item has a _When Clicked_ field. In this field you can add an action from another item, for example the _Open_ action of a door.

<img src="{{ site.baseurl }}/images/media/builder-actions.png" alt="Smart item menu" width="250"/>

Trigger multiple actions in a single field. By clicking the plus sign you can add multiple actions to be triggered together.

Remove actions by clicking the three dots next to an action and selecting _Delete_ to remove it.

In these fields you can also call actions on the same smart item that's doing the triggering.

## Special smart items

Some smart items have unique characteristics that make them very handy for common scenarios:

- _Invisible wall_: An invisible cube that stops the player from walking through it. This item can be enabled or disabled by any other smart item, when disabled it will let players walk through it.

- _Trigger area_: An invisible cube that can trigger actions from other smart items when the player enters or leaves the area it covers. This item can be enabled or disabled by other smart items, when disabled it won't trigger any actions.

- _Click area_: An invisible cube that can be clicked by players to trigger actions on any other smart items. This item can be enabled or disabled by any other smart item, when disabled it won't be clickable. You can also set the text that players see when pointing their cursor at it.

- _Ambient sound_: A sound source that plays a series of predefined ambient sounds. It can be set to always play or to only do so when activated by other smart items. It can also be set to play once or loop.

- _Arrow_: Show a hint arrow, pointing at something that the player should interact with. This item can be enabled or disabled by other smart items, when disabled the arrow is invisible.

- _Message_: A 3d sign that starts minimized and can be expanded by players to be read.

The _Tools_ smart item is a super versatile collection of tools that can act upon other items. Drag one of these into a scene, then call its actions from any other smart item. You only need one instance of this item, use it as many times as you want or even use it to call its own actions recursively.

- _Move Item_: Smoothly move an item from one position to another. It can act on any item in the scene, smart or not. Choose _relative_ positions to specify how much to move it from where it is, or _absolute_ positions to move it to specific coordinates in the scene, regardless of where it was before.

  > Note: All measurements are in meters, consider that one parcel is 16x16 meters. If using _absolute positions_, all coordinates are measured from the bottom-left corner of the scene.

- _Rotate Item_: Smoothly rotate an item from one position to another. It can act on any item in the scene, smart or not. Choose _relative_ rotations to specify how much to rotate it from where it is, or _absolute_ rotations to rotate it to a specific direction, regardless of where it was facing.

- _Scale Item_: Smoothly transition an item from one scale to another. You can also scale it in different proportions for each axis. It can act on any item in the scene, smart or not.

- _Delay_: Wait a given amount of seconds before triggering an action in a smart item.

- _Interval_: Trigger an action in a smart item regularly, every given amount of seconds.

  > Note: Once an interval action starts repeating an action, it can't be stopped.

- _Print Message_: Display a text message on the player's screen for a given amount of seconds. The message can be just for the player that triggered the action, or for all players in the scene.

> Tip: You can call as many actions as you want in succession, using the _When transition finished_ field in the _Move Item_, _Rotate Item_ and _Scale Item_ actions.

## Multiplayer

Almost all smart items have multiplayer behavior, so that all players in the scene share the same experience as the items change state. If player A opens a door, player B also sees that door open. If player C then walks into the scene while the other players are still there, she will see the door as already open too.

However, if there are no players near the scene, then the scene is restored to its default state. So if all players leave, but then player A comes back, she will find the door closed (if that was the default state of the door).

Make sure you design your scene so that the actions of one player don't sabotage the scene for others that come later. For example, if the scene is a puzzle game, you can use a _delay_ action on a _tools_ smart item to make all the items in the scene reset to their initial state a few seconds after the puzzle is solved.

If there's a key in your scene that's essential for progressing, it's possible for a player to pick it up and run off, blocking other players from advancing. One possible way to prevent this scenario is to have a _trigger area_ on the scene's exit door that calls the _drop_ action on the key, so that it returns to its place of origin.

## Troubleshooting

- _An item in my scene should be clickable, but can't be clicked_.

Make sure that it's not being obstructed by something else. You can't click through other items. Some items have a _collider mesh_ that has a simplified geometry that may be obstructing your item, even though its visible shape doesn't seem to be doing it. Try moving the item to see what happens.

## Custom smart items

Besides the default collection of smart items that come with the Builder, you can develop your own to import into your Builder account and use freely. This requires writing code using the SDK. See [smart items]({{ site.baseurl }}{% post_url /development-guide/2020-02-20-smart-items %}) for instructions.

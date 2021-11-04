---
date: 2018-02-26
title: Scene metadata
description: Learn how to add metadata to a scene.
categories:
  - development-guide
type: Document
---

All scenes have a `scene.json` file where you can set metadata for the scene. Some fields in this file are predefined with information that's necessary for the Decentraland client.

You're also free to add any fields that you wish. In the future, custom fields can then be checked by alternative clients, or other scripts embedded in interactive inventory items.

## Scene parcels

When [deploying]({{ site.baseurl }}{% post_url /development-guide/2018-01-07-publishing %}) a scene, the `scene.json` file must include information about what parcels will be occupied by this scene in the Decentraland map. The CLI reads this information from off this field and deploys to those parcels directly.

```json
 "scene": {
    "parcels": [
      "54,-14"
    ],
    "base": "54,-14"
  }
```

The default scene has its coordinates set to _0,0_, this information is not necessary to change while developing a scene offline, unless you need to occupy multiple parcels. You will need to change this before deploying, to coordinates where you do have deploy permissions.

The `base` field defines which parcel to consider the base parcel. If your scene has a single parcel, the base should be that parcel. If your scene has multiple parcels, the base should be the bottom-left (South-West) parcel. All entity positions will be measured in reference to the South-West corner of this parcel.

To display multiple parcels in the scene preview, list as many parcels as you intend to use. They don't need to be the exact parcels you'll deploy to, but they should all be adjacent and arranged in the same way in relation to each other.

```json
 "scene": {
    "parcels": [
      "54,-14",  "55,-14"
    ],
    "base": "54,-14"
  }
```

### Set parcels via the command line

You can set the parcels in your scene by running the `dcl coords` command in your scene folder. This is especially useful for large scenes, as you don't need to list every parcel involved.

**Single parcel**

Pass a single argument with the scene coords. This coordinate is also set as the base parcel.

`dcl coords <parcel>`

For example:

`dcl coords 15,-26`

**Muliple parcels**

Pass two arguments: the South-West and the North-East parcels. The South-West parcel is also set as the base parcel.

`dcl coords <parcel> <parcel>`

> Tip: The South-West parcel is always the one with the lowest numbers on both the _X_ and _Y_ coordinates.

For example:

`dcl coords 15,-26 17,-24`

This command generates a 3x3 scene, with its base parcel in `15,-26`.

**Customize Base Parcel**

Pass three arguments: the South-West and the North-East parcels, and the parcel to use as a base parcel.

`dcl coords <parcel> <parcel> <parcel>`

> Note: The base parcel must be one of the parcels in the scene.

**Non-square scenes**

The above commands all generate rectangular-shaped scenes. Decentraland scenes can have L shapes or other configurations. You can generate a larger square with `dcl coords` and then manually remove excess parcels from the `scene.json` file.

> Note: The base parcel must be one of the parcels in the scene.

## Scene title, description, and image

Give your scene a title, a description and a thumbnail image to attract players to your scene and so they know what to expect.

Players will see these when they select the parcels of your scene on the map, they will also see these in a confirmation screen when being [teleported](({{ site.baseurl }}{% post_url /development-guide/2020-05-18-external-links %})) there by another scene.

<!-- screenshot -->

When players navigate the world and enter your scene, they are able to read the scene title from under the minimap.

<img src="{{ site.baseurl }}/images/media/scene-name.png" alt="Scene name" width="200"/>

```json
  "display": {
    "title": "My Cool Scene",
	"description": "You won't believe how cool this scene is",
	"navmapThumbnail": "images/scene-thumbnail.png",
    "favicon": "favicon_asset"
   }
```

The thumbnail should be a _.png_ or _.jpg_ image of a recommended size of _228x160_ pixels. The minimum supported size is _196x143_ pixels. The image may be stretched if the width-to-height proportions don't match _228x160_.

The image on `navmapThumbnail` should be a path to an image file in the project folder. It can also be a URL link to an image hosted elsewhere.

> Note: If you host an image elsewhere, make sure this is in a site that has permissive CORS policies for displaying content on other sites.

## Contact information

In case you want other developers to be able to reach out to you, you can add contact information into the `scene.json` file.

```json
  "contact": {
    "name": "author-name",
    "email": "name@mail.com"
  },
```

## Spawn location

The `spawnPoints` field defines where players spawn when they access your scene directly, either by directly typing in the coordinates into the browser or teleporting.

Your scene might have objects that can block players from moving if they happen to spawn right over them, like trees or stairs, or your scene might have an elevated terrain. It would be a bad experience for players if they spawned over something that doesn't let them move. That's why you have the option to set multiple spawn positions in ad-hoc locations.

```json
  "spawnPoints": [
    {
      "name": "spawn1",
      "default": true,
      "position": {
        "x": 5,
        "y": 1,
        "z": 4
      }
    }
  ],
```

The position is comprised of coordinates inside the scene. These numbers refer to a position within the parcel, similar to what you'd use in the scene's code in a Transform component to [position an entity]({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %}).

> Note: All spawn points must be within the parcels that make up the scene. You can't spawn a player outside the space of these parcels.

### Multiple spawn points

A single scene can have multiple spawn points. This is useful to limit the overlapping of players if they all visit a scene at the same time. To have many spawn points, simply list them as an array.

```json
  "spawnPoints": [
    {
      "name": "spawn1",
      "default": true,
      "position": {
        "x": 5,
        "y": 1,
        "z": 4
      }
	},
	{
      "name": "spawn2",
      "default": true,
      "position": {
        "x": 3,
        "y": 1,
        "z": 1
      }
    }
  ],
```

Spawn points marked as `default` are given preference. When there are multiple spawn points marked as `default`, one of them will be picked randomly from the list.

> Note: In future releases, when a player tries to spawn into a scene and the default spawn points are occupied by other players, the player will be sent to another of the listed locations. This will open the door to allowing players to teleport to a spawn point based on the spawn point's name, as described in the `scene.json`.

### Spawn regions

You can set a whole region in the scene to act as a spawn point. By specifying an array of two numbers on any of the dimensions of the position, players will appear in a random location within this range of numbers. This helps prevent the overlapping of entering players.

```json
  "spawnPoints": [
    {
      "name": "spawn1",
      "default": true,
      "position": {
        "x": [1,5],
        "y": [1,1],
        "z": [2,4]
      }
    }
  ],
```

In the example above, players may appear anywhere in the square who's corners are on _1,1,2_ and _5,1,4_.

### Rotation

You can also specify the rotation of players when they spawn, so that they're facing in a specific direction. This allows you to have better control over their first impression, and can be useful when wanting to help steer them towards a specific direction.

Simply add a `cameraTarget` field to the spawn point data. The value of `cameraTarget` should reference a location in space, with _x_, _y_ and _z_ coordinates relative to the scene, just like the `position` field.

```json
  "spawnPoints": [
    {
      "name": "spawn1",
      "default": true,
      "position": {
        "x": 5,
        "y": 1,
        "z": 4
      },
      "cameraTarget": {
        "x": 10,
        "y": 1,
        "z": 4
      }
    }
  ],
```

This example spawns a player on _5, 1, 4_ looking East at _10, 1, 4_. If the spawn position is a range, then the player's rotation will always match the indicated target. If there are multiple spawn points, each can have its own separate target.

## Required Permissions

The `requiredPermissions` property manages various controlled features that could be used in an abusive way and damage a player's experience.

The corresponding features are blocked from being used by the scene, unless the permission is requested in the `scene.json` file.

```json
"requiredPermissions": [
    "ALLOW_TO_MOVE_PLAYER_INSIDE_SCENE"
  ],
```

Currently, only the following permission is handled:

- `ALLOW_TO_MOVE_PLAYER_INSIDE_SCENE`: Refers to [moving a Player]({{ site.baseurl }}{% post_url /development-guide/2020-08-28-move-player %})
- `ALLOW_TO_TRIGGER_AVATAR_EMOTE`: Refers to [Playing emotes on the player avatar]({{ site.baseurl }}{% post_url /development-guide/2020-11-20-trigger-emotes %})

If a `requiredPermissions` property doesn't exist in your `scene.json` file, create it at root level in the json tree.

> Note: In future releases, when a player enters a scene that has items listed in the `requiredPermissions` property, the scene will prompt the player to grant these permissions. The player will be able to decline these permissions for that scene.

## Feature Toggles

There are certain features that can be dissabled in specific scenes so that players can't use these abusively. The `featureToggles` property manages these permissions.

The corresponding features are enabled by default, unless specified as _dissabled_ in the `scene.json` file.

```json
"featureToggles": {
    "voiceChat": "disabled"
},
```

Currently, only the following feature is handled like this:

- `voiceChat`: Refers to players using their microphones to have conversations over voice chat with other nearby players.

If a `featureToggles` property doesn't exist in your `scene.json` file, create it at root level in the json tree.

## Fetch metadata from scene code

You may need a scene's code to access the fields from the metadata, like the parcels that the scene is deployed to, or the spawn point positions. This is especially useful for scenes that are meant to be replicated, or for code that is meant to be reused in other scenes. It's also very useful for smart items, where the smart item's code might for example need to know where the scene limits are.

To access this data, first import the `ParcelIdentity` library to your scene:

```ts
import { getParcel } from "@decentraland/ParcelIdentity"
```

Then you can call the `getParcel()` function from this library, which returns a json object that includes much of the contents of the scene.json file.

The example bleow shows the path to obtain several of the more common fields you might need from this function's response:

```ts
import { getParcel } from '@decentraland/ParcelIdentity'

executeTask(async () => {
  const parcel = await getParcel()

  // parcels
  log('parcels: ', parcel.land.sceneJsonData.scene.parcels)
  log('base parcel: ', parcel.land.sceneJsonData.scene.base)

  // spawn points
  log('spawnpoints: ', parcel.land.sceneJsonData.spawnPoints)

  // general scene data
  log('title: ', parcel.land.sceneJsonData.display?.title)
  log('author: ', parcel.land.sceneJsonData.contact?.name)
  log('email: ', parcel.land.sceneJsonData.contact?.email)

  // other info
  log('tags: ', parcel.land.sceneJsonData.tags)
})
```

> Note: `getParcel()` needs to be run as an [async function]({{ site.baseurl }}{% post_url /development-guide/2018-02-25-async-functions %}), since the response may delay a fraction of a second or more in returning data.

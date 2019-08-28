---
date: 2018-02-26
title: Scene metadata
description: Learn how to add metadata to a scene.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 30
---


All scenes have a `scene.json` file where you can set metadata for the scene. Some fields in this file are predefined with information that's necessary for the Decentraland client.

You're also free to add any fields that you wish. In the future, custom fields can then be checked by alternative clients, or other scripts embedded in interactive inventory items.


## Scene parcels

When [deploying](({{ site.baseurl }}{% post_url /deploy/2018-01-07-publishing %})) a scene, the `scene.json` file must include information about what parcels will be occupied by this scene in the Decentraland map. The CLI reads this information from off this field and deploys to those parcels directly.

```json
 "scene": {
    "parcels": [
      "54,-14"
    ],
    "base": "54,-14"
  }
```

This information is not necessary while developing a scene offline, unless you're building a scene that occupies more than one parcel. 

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


## Contact information

In case you want other developers to be able to reach out to you, you can add contact information into the `scene.json` file.

```json
  "contact": {
    "name": "author-name",
    "email": "name@mail.com"
  },
```

## Spawn location

The `spawnPoints` field defines where users spawn when they access your scene directly, either by directly typing in the coordinates into the browser of teleporting. 

Your scene might have objects that can block users from moving if they happen to spawn right over them, like trees or stairs, or your scene might have an elevated terrain. It would be a bad experience for users if they spawned over something that doesn't let them move. That's why you have the option to set multiple spawn positions in ad-hoc locations.

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

The position is comprised of coordinates inside the scene. These numbers refer to a position within the parcel, similar to what you'd use in the scene's code in a Transform component to [position an entity](({{ site.baseurl }}{% post_url /development-guide/2018-01-12-entity-positioning %})). 


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
        "y": 1,
        "z": [2,4]
      }
    }
  ],
```

In the example above, players may appear anywhere in the square who's corners are on _1,1,2_ and _5,1,4_.


### Rotation

You can also specify the rotation of players when they spawn, so that they're facing a specific direction. This allows you to have better control over their first impression, and can be useful when wanting to help steer them towards a specific direction.

Simply add a `cameraTarget` field to the spawn point data.


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
		"x": 0,
        "y": 90,
        "z": 0
	  }
    }
  ],
```


## Custom metadata

You can extend the fields in the "policy" section to whatever you think is relevant. These fields might be taken into consideration by alternative community clients used to navigate the metaverse and be used to filter content or restrict users from doing certain actions like flying or battling. 

This metadata might also be used by scripts of interactive inventory items, for example a light sabre inventory item might only be possible to use on scenes that allow for battles to take place.

As clear use cases start to emerge, we plan to define more conventions over the metadata that can be added to this file.

```json
  "policy": {
    "contentRating": "E",
    "fly": true,
    "voiceEnabled": true,
    "blacklist": [],
    "teleportPosition": ""
  }
```

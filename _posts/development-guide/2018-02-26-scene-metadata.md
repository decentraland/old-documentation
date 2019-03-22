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

The `base` field defines which parcel to consider the base parcel. All entity positions will be measured in reference to the South-East corner of this parcel.

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

The `teleportPosition` field, inside the `policy` section defines where users spawn when they access your scene directly, either by directly typing in the coordinates into the browser of teleporting. 

Your scene might have objects that can block users from moving if they happen to spawn right over them, like trees or stairs, or your scene might have an elevated terrain. It would be a bad experience for users if they spawned over something that doesn't let them move. That's why you have the option to set a custom spawn position that differs from the default.

```json
  "policy": {
    "teleportPosition": "3, 0, 3"
  }
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

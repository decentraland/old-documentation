---
date: 2018-02-11
title: Builder 101
description: Getting started with the Builder
categories:
  - development-guide
redirect_from:
  - /documentation/scene-files/
type: Document
set: development-guide
set_order: 2
---

Besides the default assets in the Builder, you can import your own 3d models into the builder

## Create an asset pack

All custom items are stored in user-created asset packs. Each asset pack holds one or many assets.

To create a new asset pack:

1. Click _New Asset Pack_ at the bottom of the item menu, or the plus sign at the top of this same menu.
2. Drag your 3d models into the window
3. Click Import assets
4. Name each asset, and potentially add tags
5. Name the asset pack and click _Create Asset Pack_

Now you'll see a new folder in the items menu with your new asset pack, and you can use your new assets just like all the others.

## Supported models

All 3d models need to either be in _.glTF_ or _.glb_ format.

link to 3d modeling for instructions for addons and recomendation for exporting to supported formats

If the 3D model incudes external files like a _.bin_ or _.png_ file, or several of them, compress all the relevant files for the 3d model into a _.zip_ and import that

All 3d models must occupy less than 5mb

[Scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})

## Animations

If an imported model includes any animations, the first animation that's packed into the model will be played on a loop. Note that you don't have any control of when the animation starts or stops, or which one is played in case there are several, the first one will always be played on a loop.

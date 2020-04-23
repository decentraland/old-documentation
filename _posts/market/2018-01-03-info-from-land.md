---
date: 2018-01-03
title: Get parcel info
description: Get info from land parcels, estates or addresses using the CLI.
redirect_from:
  - /blockchain-interactions/info-from-land
  - /blockchain-integration/info-from-land
categories:
  - market
type: Document
---

You can use the Decentraland CLI to query info directly from LAND tokens in the blockchain and from the scene files uploaded to the content server.

To run these commands, you must first [Install the CLI]({{ site.baseurl }}{% post_url /development-guide/2018-01-01-installation-guide %}).

## Get info about a scene

The `dcl info` command returns the contents of a scene's _scene.json_ file, including owner, contact info, and parcels in the scene.

- `dcl info` from the scene's folder returns info about that specific scene.
- `dcl info x,y`, where _x_ and _y_ are parcel coordinates, returns info about the scene in that location.
  > Note: Don't add a space between both coordinates.
- `dcl info id`, where _id_ is an estate id, returns info about the scene with that estate id.

The `dcl status` command returns a list with the files deployed to a scene. This only includes file names and sizes. You can't access the contents of the files via the CLI.

- `dcl status` from the scene's folder returns info about that specific scene.
- `dcl status x,y`, where _x_ and _y_ are parcel coordinates (with no spaces between them), returns info about the scene in that location.
  > Note: Don't add a space between both coordinates.
- `dcl status id`, where _id_ is an estate id, returns info about the scene with that estate id.

> Note: Everything that's uploaded to our content server is public and reachable through that network. When you deploy a scene, by default you're not uploading the original source code for the scene, instead you upload a version that's compiled to minified JavaScript, which is a lot less readable.

## Get info from a wallet address

The `dcl info` command also lets you see info about an Ethereum wallet and the LAND tokens that it owns.

- `dcl info xxxx`, where _xxxx_ is the Ethereum address you're interested in, returns a list of all the LAND parcels and estates owned by that address and their details.

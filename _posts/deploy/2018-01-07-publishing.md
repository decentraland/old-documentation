---
date: 2018-01-06
title: Publishing the scene
description: How to publish my project?
redirect_from:
  - /documentation/publishing/
categories:
  - deploy
type: Document
set: deploy
set_order: 7
---

> Note: The currently released version of the CLI doesn't support deploying parcels to Decentraland. We're working on a new version of the CLI that will make the deployment process simpler.

<!--
## Before you begin

Make sure of the following:

- Your scene complies with all of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}). Most of these are validated each time you run a preview of your scene.

* You have a [Metamask](https://metamask.io/) account, with your LAND parcels assigned to it. The account must also hold a minimum amount of Ether to pay a transaction gas fee.

* You own the necessary amount of adjacent LAND parcels. Otherwise you can purchase LAND in the [Market]({{ site.baseurl }}{% post_url /blockchain-interactions/2018-01-01-marketplace %}).

* If you're deploying a single scene to multiple adjacent parcels, you must first merge them together into an _Estate_ before you can deploy to them. See [Marketplace]({{ site.baseurl }}{% post_url /blockchain-interactions/2018-01-01-marketplace %}) for instructions on how to create an estate.

## Check scene data

When deploying, the CLI reads information from the _scene.json_ to know where to deploy your scene to.

Open your scene's _scene.json_ file and verify the following:

- **Owner**: Needs to match your Ethereum wallet address. This same address needs to hold the LAND tokens, or have been granted permissions by the owner.

- **Parcels**: The coordinates of the parcels that will be occupied by your scene

- **Base**: The coordinates of the parcel that will be considered the [0,0] coordinate of the scene.

- **Estate**: The ID of the estate you're deploying to. If you're deploying to a single parcel, this field isn't necessary.

  > Note: To find your estate's id, open the estate's detail page in the Marketplace. The URL should include a number for the ID. For example if the URL is _market.decentraland.org/estates/84/detail_, the estate's ID is _84_.

## To publish the scene

1.  To make sure the scene has been locally built with your latest changes, run `npm run build`.
2.  Log into your Metamask account with the same public address associated with your parcels in Decentraland. That public address should be listed in the scene's _scene.json_ file.
3.  Run `dcl deploy` from the scene's folder.


Currently, as a measure to improve performance and your visitor's experience, your content will be pinned to Decentraland’s main server to ensure that the data needed to render your parcel is always readily available.

> Note: While this command deploys your scene to your parcel, remember that users can’t currently explore Decentraland, so your content won’t be discoverable “in-world”.

## Publish from a physical Ledger device

Instead of storing your LAND tokens in a Metamask account, you may find it more secure to store them in a [Ledger](https://www.ledger.com/) device that's phyisically plugged in to your computer.

If you're using one of these, the process of uploading content to your LAND is slightly different.

1.  To make sure the scene has been locally built with your latest changes, run `npm run build`.
2.  Plug your Ledger device in. Your parcels in Decentraland should be associated with that same wallet. The same public address should be listed in the scene's _scene.json_ file.
3.  Run `dcl deploy --https` from the scene's folder. This will open a tab on your browser where you need to confirm this action.
    > Note: Currently, the certificate is self-signed, so your browser might give you a warning before launching the page. The warning is displayed only because the certificate is self-signed by your machine, please ignore it and carry on.
4.  The Ledger device will then ask you for a confirmation, which you must give by pushing the device's buttons.

-->

<!--

## What is the content server

The content server has a filesystem that's content-addressed, meaning that each file is identified by its contents, not an arbitrary file name.

We use the content server to host and distribute all scene content in a similar way to BitTorrent, keeping the Decentraland network distributed.

1.  The content server stores and distributes all of the assets required to render your scenes.
2.  The `dcl deploy` command links these assets to the LAND parcel specified in your **scene.json** file. Whenever you redeploy your scene, the CLI will update your LAND smart contract, if needed, to point to the most recent content available on the content server.
-->

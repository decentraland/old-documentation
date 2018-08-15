---
date: 2018-01-06
title: Publishing the scene
description: How to publish my project?
categories:
  - documentation
type: Document
set: building-scenes
set_order: 7
---

## Before you begin

Make sure of the following:

- Your scene's _scene.json_ file reflects the correct properties, including your Metamask public address, and the LAND parcels where you want to upload the scene.

> Note: The CLI prompts you to provide this information when creating the scene, but you can also modify the file manually at any time.

- Your scene complies with all of the [scene limitations](({{ site.baseurl }}{% post_url /sdk-reference/2018-01-06-scene-limitations %})). Most of these are validated each time you run a preview of your scene.

* You installed IPFS correctly. To do so, follow [these steps](https://ipfs.io/docs/install/).

* You have a [Metamask](https://metamask.io/) account, with your LAND parcels assigned to it. The account must also hold a minimum amount of Ether to pay a transaction gas fee.

* You own the necessary ammount of adjacent LAND parcels. Otherwise you can purchase LAND in the [Market](({{ site.baseurl }}{% post_url /marketplace/2018-01-01-marketplace %})).

## To publish the scene

1.  To make sure the scene has been locally built with your latest changes, run `npm run build`.
2.  Log into your Metamask account with the same public address associated with your parcels in Decentraland. That public address should be listed in the scene's _scene.json_ file.
3.  Start up an IPFS daemon by following [these instructions](https://ipfs.io/docs/getting-started/).
4.  Finally, run `dcl deploy` from the scene's folder.

If this is your first time uploading this scene to the selected parcels,Metamask will ask you to approve a transaction for paying the gas fee after the file upload is completed. You only make this payment the first time you deploy content, as the smart contract for your LAND is only updated when you link your content to IPNS, the naming service for IPFS.

This updates your parcel with your latest changes in addition to uploading your content to IPFS.

Currently, as a measure to improve performance and your visitor's experience, your content will be pinned to Decentraland’s main IPFS server to ensure that the data needed to render your parcel is always readily available.

> Note: While this command deploys your scene to your parcel, remember that users can’t currently explore Decentraland, so your content won’t be discoverable “in-world”.

## Publish from a physical Ledger device

Instead of storing your LAND tokens in a Metamask account, you may find it more secure to store them in a [Ledger](https://www.ledger.com/) device that's phyisically plugged in to your computer.

If you're using one of these, the process of uploading content to your LAND is slightly different.

1.  To make sure the scene has been locally built with your latest changes, run `npm run build`.
2.  Plug your Ledger device in. Your parcels in Decentraland should be associated with that same wallet. The same public address should be listed in the scene's _scene.json_ file.
3.  Start up an IPFS daemon by following [these instructions](https://ipfs.io/docs/getting-started/).
4.  Run `dcl deploy --https` from the scene's folder. This will open a tab on your browser where you need to confirm this action.
    > Note: Currently, the certificate is self-signed, so your browser might give you a warning before launching the page. The warning is displayed only because the certificate is self-signed by your machine, please ignore it and carry on.
5.  The Ledger device will then ask you for a confirmation, which you must give by pushing the device's buttons.

## What is IPFS?

[IPFS](https://ipfs.io/) (short for Inter-Planetary File System) is a hypermedia protocol and a P2P network for distributing files. The filesystem is content-addressed, meaning that each file is identified by its contents, not an arbitrary file name.

We use IPFS to host and distribute all scene content in a similar way to BitTorrent, keeping the Decentraland network distributed. For better performance, we run an “IPFS Gateway”, which means that Decentraland is hosting most of the content referenced from the blockchain (after certain filters are applied) to improve the experience of exploring the world.

In order to upload your files, you’ll need to run an IPFS node. After “pinning” your scene’s content (which means notifying the network that your files are available) our IPFS nodes will try to download the files using the IPFS network, eventually reaching your computer and copying over the files.

To run an IPFS node, please follow [these instructions](https://ipfs.io/docs/getting-started/).

#### What does IPFS have to do with my LAND?

IPFS serves two primary functions for Decentraland.

1.  IPFS stores and distributes all of the assets required to render your scenes.
2.  The `dcl deploy` command links these assets to the LAND parcel specified in your **scene.json** file. Whenever you redeploy your scene, the CLI will update your LAND smart contract, if needed, to point to the most recent content available on IPFS.

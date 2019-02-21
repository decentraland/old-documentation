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

## Before you begin

Make sure of the following:

- Your scene complies with all of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}). Most of these are validated each time you run a preview of your scene.

- You have a [Metamask](https://metamask.io/) account, with your LAND parcels assigned to it. The account must also hold a minimum amount of Ether to pay a transaction gas fee.

- You own the necessary amount of adjacent LAND parcels. Otherwise you can purchase LAND in the [Market]({{ site.baseurl }}{% post_url /blockchain-interactions/2018-01-01-marketplace %}).

> Note: Multi-parcel scenes can only be deployed to adjacent parcels.

<!--
- If you're deploying a single scene to multiple adjacent parcels, you must first merge them together into an _Estate_ before you can deploy to them. See [Marketplace]({{ site.baseurl }}{% post_url /blockchain-interactions/2018-01-01-marketplace %}) for instructions on how to create an estate.
-->

## Check scene data

When deploying, the CLI reads information from the _scene.json_ to know where to deploy your scene to.

Open your scene's _scene.json_ file and verify the following:

- **Owner**: Needs to match your Ethereum wallet address. This same address needs to hold the LAND tokens, or have been granted permissions by the owner.

- **Parcels**: The coordinates of the parcels that will be occupied by your scene

- **Base**: The coordinates of the parcel that will be considered the [0,0] coordinate of the scene.

<!--

- **Estate**: The ID of the estate you're deploying to. If you're deploying to a single parcel, this field isn't necessary.

  > Note: To find your estate's id, open the estate's detail page in the Marketplace. The URL should include a number for the ID. For example if the URL is _market.decentraland.org/estates/84/detail_, the estate's ID is _84_.
  
-->

## To publish the scene

1.  To make sure the scene has been locally built with your latest changes, run `npm run build`.
2.  Log into your Metamask account with the same public address associated with your parcels in Decentraland.
3.  Run `dcl deploy` from the scene's folder.
4.  The command line lists the files it will upload. Confirm with _Y_.

    > Tip: If there are files in your project folder that you don't want to deploy, list them in the _.dclignore_ file.
    If you only want to deploy the files that have changed since your last deploy, add the flag `--p` to the deploy command.

5.  A browser tab will open, showing what parcels you're deploying to. Click **Sign and Deploy**.
6.  Metamask opens, notifying you that your signature is requested. Click **Sign** to confirm this action.

<!--
Currently, as a measure to improve performance and your visitor's experience, your content will be pinned to Decentraland’s main server to ensure that the data needed to render your parcel is always readily available.
-->

> Note: Although this command deploys your scene to your parcels, remember that users can’t currently explore Decentraland, so your content won’t be discoverable “in-world” yet.

> Tip: If you're implementing a continuous integration flow, where changes to your scene are deployed automatically, then you can use the `--y` flag to skip the manual confirmations when running the deploy command.

## Publish from a physical Ledger device

Instead of storing your LAND tokens in a Metamask account, you may find it more secure to store them in a [Ledger](https://www.ledger.com/) device that's physically plugged in to your computer.

If you're using one of these, the process of uploading content to your LAND is slightly different.

1.  To make sure the scene has been locally built with your latest changes, run `npm run build`.
2.  Plug your Ledger device in. Your parcels in Decentraland should be associated with that same wallet.
3.  Run `dcl deploy --https` from the scene's folder. 4. The command line lists the files it will upload. Confirm with _Y_.

    > Tip: If there are files in your project folder that you don't want to deploy, list them in the _.dclignore_ file.

4.  A browser tab will open, showing what parcels you're deploying to. Click **Sign and Deploy**.

    > Note: Currently, the certificate is self-signed, so your browser might give you a warning before launching the page. The warning is displayed only because the certificate is self-signed by your machine, please ignore it and carry on.

5.  The Ledger device will then ask you for a confirmation, which you must give by pushing the device's buttons.

> Tip: If you're implementing a continuous integration flow, where changes to your scene are deployed automatically, then you can use the `--y` flag to skip the manual confirmations when running the deploy command.

## Scene overwriting

When a new scene is deployed, it overwrites older content that existed on the parcels it occupies.

If a scene that takes up multiple parcels is only partially overwritten by another, its remaining parcels can't be rendered. Scenes can only be rendered in their entirety.

Suppose you deployed your scene _A_ over two parcels _[100, 100]_ and _[100, 101]_. Then you sell parcel _[100, 101]_ to a user who owns adjacent land and that deploys a large scene (_B_) to several parcels, including _[100, 101]_. 

Your scene _A_ can't be partially rendered in just one parcel, so _[100, 100]_ won't display any content. You must build a new version of scene _A_ that only takes up one parcel and deploy it to only parcel _[100, 100]_.


## What is the content server

The content server has a filesystem that's content-addressed, meaning that each file is identified by its contents, not an arbitrary file name.

We use the content server to host and distribute all scene content in a similar way to BitTorrent, keeping the Decentraland network distributed.

1.  The content server stores and distributes all of the assets required to render your scenes.
2.  The `dcl deploy` command links these assets to the LAND parcel specified in your **scene.json** file. Whenever you redeploy your scene, the CLI will update your LAND smart contract, if needed, to point to the most recent content available on the content server.

Anyone willing to host a copy of the content server will be free to replicate it. The information on each copy of the server will be verifiable, as each scene is signed by the LAND owner's hash. This means that someone hosting a copy of the server won't be able to tamper with the content to display something illegitimate.


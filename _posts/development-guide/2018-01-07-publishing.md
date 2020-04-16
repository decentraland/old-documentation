---
date: 2018-01-06
title: Publishing a scene
description: How to publish my project?
redirect_from:
  - /documentation/publishing/
  - /getting-started/publishing/
  - /deploy/publishing/
categories:
  - development-guide
type: Document
---

## Before you begin

Make sure of the following:

- Your scene complies with all of the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}). Most of these are validated each time you run a preview of your scene.

- You have a [Metamask](https://metamask.io/) account, with your LAND parcels assigned to it.

- You own the necessary amount of adjacent LAND parcels. Otherwise you can purchase LAND in the [Market]({{ site.baseurl }}{% post_url /market/2018-01-01-marketplace %}).

> Note: Multi-parcel scenes can only be deployed to adjacent parcels.

## Check scene data

When deploying, the CLI reads information from the _scene.json_ to know where to deploy your scene to.

Open your scene's _scene.json_ file and verify the following:

- **Owner**: Needs to match your Ethereum wallet address. This same address needs to hold the LAND tokens, or have been granted permissions by the owner.

- **Parcels**: The coordinates of the parcels that will be occupied by your scene

- **Base**: The coordinates of the parcel that will be considered the [0,0] coordinate of the scene. If your scene has multiple parcels, it should be the bottom-left (South-West) parcel.

> Note: See [scene metadata]({{ site.baseurl }}{% post_url /development-guide/2018-02-26-scene-metadata %}) for more details on how to set these parameters.

## To publish the scene

1.  To make sure the scene has been locally built with your latest changes, run `dcl start`.
2.  Log into your Metamask account with the same public address associated with your parcels in Decentraland.
3.  Run `dcl deploy` from the scene's folder.
4.  The command line lists the files it will upload. Confirm with _Y_.

    > Tip: If there are files in your project folder that you don't want to deploy, list them in the _.dclignore_ file.

5.  A browser tab will open, showing what parcels you're deploying to. Click **Sign and Deploy**.
6.  Metamask opens, notifying you that your signature is requested. Click **Sign** to confirm this action.

> Tip: If you're implementing a continuous integration flow, where changes to your scene are deployed automatically, then you can use the `--y` flag to skip the manual confirmations when running the deploy command.

## Publish from a physical Ledger device

Instead of storing your LAND tokens in a Metamask account, you may find it more secure to store them in a [Ledger](https://www.ledger.com/) device that's physically plugged in to your computer.

If you're using one of these, the process of uploading content to your LAND is slightly different.

1.  To make sure the scene has been locally built with your latest changes, run `dcl start`.
2.  Plug your Ledger device in. Your parcels in Decentraland should be associated with that same wallet.
3.  Run `dcl deploy --https` from the scene's folder. 4. The command line lists the files it will upload. Confirm with _Y_.

    > Tip: If there are files in your project folder that you don't want to deploy, list them in the _.dclignore_ file.

4.  A browser tab will open, showing what parcels you're deploying to. Click **Sign and Deploy**.

    > Note: Currently, the certificate is self-signed, so your browser might give you a warning before launching the page. The warning is displayed only because the certificate is self-signed by your machine, please ignore it and carry on.

5.  The Ledger device will then ask you for a confirmation, which you must give by pushing the device's buttons.

> Tip: If you're implementing a continuous integration flow, where changes to your scene are deployed automatically, then you can use the `--y` flag to skip the manual confirmations when running the deploy command.

## Scene overwriting

When a new scene is deployed, it overwrites older content that existed on the parcels it occupies.

If a scene that takes up multiple parcels is only partially overwritten by another, all of its parcels are either overwritten or erased.

Suppose you deployed your scene _A_ over two parcels _[100, 100]_ and _[100, 101]_. Then you sell parcel _[100, 101]_ to a user who owns adjacent land and that deploys a large scene (_B_) to several parcels, including _[100, 101]_.

Your scene _A_ can't be partially rendered in just one parcel, so _[100, 100]_ won't display any content. You must build a new version of scene _A_ that only takes up one parcel and deploy it to only parcel _[100, 100]_.

## What are the content servers

The content servers are a network of community-owned servers with a filesystem that's content-addressed, meaning that each file is identified by its contents, not by an arbitrary file name.

We use the content servers to host and distribute all scene content in a similar way to BitTorrent, keeping the Decentraland network distributed.

1.  The content servers store and distribute all of the assets required to render your scenes.
2.  The `dcl deploy` command links these assets to the LAND parcel specified in your **scene.json** file. Whenever you redeploy your scene, the CLI will update your LAND smart contract, if needed, to point to the most recent content available on the content servers.

The information on each copy of the server is verifiable, as each scene is signed by the LAND owner's hash. This means that someone hosting a copy of the server won't be able to tamper with the content to display something illegitimate. The community can also vote to approve or remove any of these servers using the DAO.

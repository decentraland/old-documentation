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

- You own the necessary amount of adjacent LAND parcels. Otherwise you can purchase LAND in the [Market](https://market.decentraland.org).

> Note: Multi-parcel scenes can only be deployed to adjacent parcels.

## Check scene data

When deploying, the CLI reads information from the _scene.json_ to know where to deploy your scene to.

Open your scene's _scene.json_ file and complete the following data:

- **title**: The title is displayed on the UI under the mini-map, whenever players enter your scene. It also shows on the teleport popup.

- **description**: A description of what players will find in your scene. This is displayed on the teleport popup.

- **navmapThumbnail**: An image that represents your scene. This is displayed on the teleport popup. The image should be a _.png_ or _.jpg_ image of a recommended size of _228x160_ pixels.

- **Parcels**: The coordinates of the parcels that will be occupied by your scene

- **Base**: The coordinates of the parcel that will be considered the [0,0] coordinate of the scene. If your scene has multiple parcels, it should be the bottom-left (South-West) parcel.

- **spawnPoints**: A set of coordinates inside the scene (relative to the scene's base parcel) where players spawn into. By default players spawn onto the _0,0,0_ location of the scene (bottom-left corner). Use this to start out in a specific location, set a region to prevent players from overlapping with each other when they first appear.

> Note: See [scene metadata]({{ site.baseurl }}{% post_url /development-guide/2018-02-26-scene-metadata %}) for more details on how to set these parameters.

## To publish the scene

1.  Log into your Metamask account with the same public address associated with your parcels in Decentraland.
2.  Run `dcl deploy` from the scene's folder.
    > Tip: If there are files in your project folder that you don't want to deploy, list them in the _.dclignore_ file before deploying.
3.  A browser tab will open, showing what parcels you're deploying to. Click **Sign and Deploy**.
4.  Metamask opens, notifying you that your signature is requested. Click **Sign** to confirm this action.

> Tip: If you're implementing a continuous integration flow, where changes to your scene are deployed automatically, then you can set the `export DCL_PRIVATE_KEY` environment variable to the private key of an account that has deploy permissions.

> Tip: `dcl deploy` runs a `dcl build`, which checks the scene for type errors more strictly than running `dcl start`. If these errors can't be avoided (eg: they happen in an external library) and they don't impact the scene, you can use `dcl deploy  --skip-build`  to skip the `dcl build` step and deploy the scene as it is.

## Publish from a hardware wallet

Instead of storing your LAND tokens in a Metamask account, you may find it more secure to store them in a hardware wallet device, such as a [Ledger](https://www.ledger.com/) or a [Trezor](https://trezor.io/), that's physically plugged in to your computer.

If you're using one of these devices, you can link the hardware wallet to Metamask to enable signing messages, while keeping the tokens more secure. See [this article from Metamask](https://metamask.zendesk.com/hc/en-us/articles/360020394612-How-to-connect-a-Trezor-or-Ledger-Hardware-Wallet) for instructions to connect your account.

Once your hardware wallet can be used via Metamask, you can deploy following the same steps as if your tokens were on a Metamask account.

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

## The test server

You can deploy content to the test catalyst server to run full tests with multiple users, the sourrounding scenes, and an environment that is identical to production. The test server is identical to all other catalyst servers, the difference is that the content that is deployed to this server isn't propagated to the others. Content deployed to other servers on the other hand does get propagated to this server, so surrounding scenes should look as they will in production.

To deploy to the test server, run:

`dcl deploy --target peer-testing.decentraland.org`

> Note: The same permissions apply as in production. You must be owner or have permissions on the parcels that you're deployng to.

Players are never directed to this server, the only way to access it is to explicitly provide a URL parameter to connect to it. 

To enter the content server, add `&CATALYST=peer-testing.decentraland.org` to the Decentraland URL

play.decentraland.org/&CATALYST=peer-testing.decentraland.org


If you're working in a confidential project that you don't want to unveil until launch, note that the test server is relatively hidden from players, but anyone explicitly using the test server's URL could potentially run into it.

## Verify deployment success

Once you deployed your scene, these changes will take a few minutes to be propagated throughout the various content servers in the network. If you enter Decentraland right after deploying, you might still see the previous version of your content, depending of what realm you enter.

To confirm that the new version of your content has been propagated throughout all of the servers in the network, run the following command:

`npx @dcl/opscli pointer-consistency --pointer '0,0'`

> Note: Use the coordinates of your scene instead of `0,0`. If your scene has multiple parcels, any one of its parcels will produce the same output.

The output of this command lists each of the servers that make up Decentraland's content network. For each server, it specifies the timestamp of the last uploaded change on that parcel. Each one of these servers refers to a different realm, you can reference how these server names map to realm names in the [catalyst monitor screen](https://catalyst-monitor.vercel.app/).



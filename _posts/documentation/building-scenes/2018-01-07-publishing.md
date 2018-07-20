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
To publish your scene:

发布您的场景：

1. Make sure the scene has been locally built with your latest changes. If not, run `npm run build`.
2. Log into the Metamask account with the same public address associated with your parcel.
3. Start up an IPFS daemon by following [these instructions](https://ipfs.io/docs/getting-started/).
4. Finally, run `dcl deploy` from the scene's folder.

5. 确保最近更改的场景已经在本地完成构建。如果还没有，请运行 `npm run build` 。
6. 使用跟您的土地关联的公共地址来登录 Metamask 帐户。
7. 按照[这里的说明](https://ipfs.io/docs/getting-started/)启动 IPFS 守护程序。
8. 最后，在场景的文件夹中运行 `dcl deploy`。


This updates your parcel with your latest changes in addition to uploading your content to IPFS. 

`dcl deploy` 除了将您的内容上传到 IPFS 之外，还会将您的最近更改更新到地块。

Currently, as a measure to improve performance and your visitor's experience, your content will be pinned to Decentraland’s main IPFS server to ensure that the data needed to render your parcel is always readily available.

目前，作为提高性能和访问者体验的措施，您的内容将在 Decentraland 的主要 IPFS 服务器上保存，以确保渲染您的地块所需的数据始终可用。

> You don’t have to pay an Ethereum gas fee everytime you deploy your content. The smart contract for your LAND is only updated when you link your content to IPNS, the naming service for IPFS.

> 部署内容时，不需支付以太坊矿工费。只有在将内容链接到 IPNS（IPFS 的命名服务）时，才会更新 LAND 上的智能合约。

While this command deploys your scene to your parcel, remember that users can’t currently explore Decentraland, so your content won’t be discoverable “in-world”.

虽然此命令将您的场景部署到了您的地块，要注意的是目前用户还无法使用 Decentraland 浏览探索，因此您的内容还无法在虚拟世界里展示。

## What is IPFS?

## 什么是IPFS？

[IPFS](https://ipfs.io/) (short for Inter-Planetary File System) is a hypermedia protocol and a P2P network for distributing files. The filesystem is content-addressed, meaning that each file is identified by its contents, not an arbitrary file name.

[IPFS](https://ipfs.io/)(星际文件系统的简称)是一个超媒体协议和一个用于分发文件的 P2P网络。文件系统是由内容来寻址的，这意味着文件是由其内容，而不是由随意的文件名称来识别。

We use IPFS to host and distribute all scene content in a similar way to BitTorrent, keeping the Decentraland network distributed. For better performance, we run an “IPFS Gateway”, which means that Decentraland is hosting most of the content referenced from the blockchain (after certain filters are applied) to improve the experience of exploring the world.

我们使用 IPFS 以类似于 BitTorrent 的方式托管和分发所有场景内容，从而保持Decentraland 网络的分散。为了获得更好的性能，我们运行了一个“ IPFS 网关”，这意味着Decentraland 正在托管着区块链中引用的大部分内容（在使用某些过滤之后），以改善用户探索世界的体验。

In order to upload your files, you’ll need to run an IPFS node. After “pinning” your scene’s content (which means notifying the network that your files are available) our IPFS nodes will try to download the files using the IPFS network, eventually reaching your computer and copying over the files.

要上传文件，您需要运行 IPFS 节点。在 “pinning”([使得 IPFS 保留本地备份](https://ipfs.io/ipfs/QmNZiPk974vDsPmQii3YbrMKfi12KTSNM7XMiYyiea4VYZ/example#/ipfs/QmRFTtbyEp3UaT67ByYW299Suw7HKKnWK6NJMdNFzDjYdX/pinning/readme.md)) 场景的内容（这意味着通知网络您的文件可用）之后，我们的 IPFS 节点将尝试从 IPFS 网络下载文件，最后到达您的计算机并复制文件。

To run an IPFS node, please follow [these instructions](https://ipfs.io/docs/getting-started/).

要运行 IPFS 节点，请按照[这些说明](https://ipfs.io/docs/getting-started/)进行操作。

### What does IPFS have to do with my LAND?

### IPFS 与我的 LAND 有什么关系？

IPFS serves two primary functions for Decentraland.

IPFS 为 Decentraland 提供了两个主要功能。

1. IPFS stores and distributes all of the assets required to render your scenes.

2. The `dcl deploy` command links these assets to the LAND parcel specified in your **scene.json** file. Whenever you redeploy your scene, the CLI will update your LAND smart contract, if needed, to point to the most recent content available on IPFS.

1. 渲染场景所需的所有资源由 IPFS 存储和分发。

2. `dcl deploy` 命令将这些资源链接到 **scene.json** 文件中指定的 LAND 地块。每当您重新部署场景时，CLI 将根据需要更新您的 LAND 智能合约，使之指向 IPFS 上可用的最新内容。
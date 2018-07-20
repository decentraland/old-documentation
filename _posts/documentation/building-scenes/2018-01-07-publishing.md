---
date: 2018-01-06
title: 发布场景
description: How to publish my project?
categories:
  - documentation
type: Document
set: building-scenes
set_order: 7
---

为了发布您的场景：

1. 确保最近更改的场景已经在本地完成构建。如果还没有，请运行 `npm run build` 。
2. 使用跟您的土地相关联的地址来登录 Metamask 帐户。
3. 按照[这里的说明](https://ipfs.io/docs/getting-started/)启动 IPFS 守护程序。
4. 最后，在场景的文件夹中运行 `dcl deploy`。

`dcl deploy` 除了将您的内容上传到 IPFS 之外，还会更新您地块内容。

目前，作为提高性能和访问者体验的措施，您的内容将在 Decentraland 的主要 IPFS 服务器上保存，以确保渲染您的地块所需的数据始终可用。

> 部署内容时，不需支付以太坊矿工费。只有在将内容链接到 IPNS（IPFS 的命名服务）时，才会更新 LAND 上的智能合约。

虽然此命令将您的场景部署到了您的地块，要注意的是目前用户还无法使用 Decentraland 浏览探索，因此您的内容还无法在虚拟世界里展示。

## 什么是IPFS？

[IPFS](https://ipfs.io/)(星际文件系统的简称)是一个超媒体协议和一个用于分发文件的 P2P网络。文件系统是由内容来寻址的，这意味着文件是由其内容，而不是由随意的文件名称来识别。

我们使用 IPFS 以类似于 BitTorrent 的方式托管和分发所有场景内容，从而保持Decentraland 网络的分散。为了获得更好的性能，我们运行了一个“ IPFS 网关”，这意味着Decentraland 正在托管着区块链中引用的大部分内容（在使用某些过滤之后），以改善用户探索世界的体验。

要上传文件，您需要运行 IPFS 节点。在 “pinning”([使得 IPFS 保留本地备份](https://ipfs.io/ipfs/QmNZiPk974vDsPmQii3YbrMKfi12KTSNM7XMiYyiea4VYZ/example#/ipfs/QmRFTtbyEp3UaT67ByYW299Suw7HKKnWK6NJMdNFzDjYdX/pinning/readme.md)) 场景的内容（这意味着通知网络您的文件可用）之后，我们的 IPFS 节点将尝试从 IPFS 网络下载文件，最后到达您的计算机并复制文件。

要运行 IPFS 节点，请按照[这些说明](https://ipfs.io/docs/getting-started/)进行操作。

### IPFS 与我的 LAND 有什么关系？

IPFS 为 Decentraland 提供了两个主要功能。

1. 渲染场景所需的所有资源由 IPFS 存储和分发。

2. `dcl deploy` 命令将这些资源链接到 **scene.json** 文件中指定的 LAND 地块。每当您重新部署场景时，CLI 将根据需要更新您的 LAND 智能合约，使之指向 IPFS 上可用的最新内容。
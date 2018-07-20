---
date: 2018-01-06
title: Sample scenes
description: Code and scene examples using our SDK
categories:
  - documentation
type: Document
set: building-scenes
set_order: 8
---

为了帮助您快速入门，并阐明可以使用 SDK 构建的各种体验类型，我们有一些[代码和场景示例](https://github.com/decentraland/sample-scenes)供您参考。

## 初级示例
### 静态场景

这是个完全静态的场景示例。用来展示如何使用 blender 或 [Sketchfab](https://sketchfab.com/) 等资源构建您的第一个静态 Decentraland 场景。请查看此[链接](https://github.com/decentraland/sample-scenes/tree/master/01-static-scene)


### 动态动画

With this Dynamic Animation, we're demonstrating how to employ simple data binding to objects in your scene. [Translation, rotation, and scale]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) are all attributes you can bind to state properties. [Link](https://github.com/decentraland/sample-scene-dynamic-animation)

通过此动态动画，我们演示了如何将简单的数据绑定到场景中的对象中。[移动，旋转和缩放]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %})等属性都可以绑定到状态属性中。[链接](https://github.com/decentraland/sample-scene-dynamic-animation)


### 交互式内容

此示例中的交互式门展示了如何处理来自用户的单击输入事件。视野中心的大红点指示了您当前关注的对象。 [链接](https://github.com/decentraland/sample-scenes/tree/master/03-interactive-door).


### 骨骼动画

在场景中，您可以加载交互式 [GLTF 模型]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %})并触发其动画。这是如何做到这一点的一个例子。 [链接](https://github.com/decentraland/sample-scenes/tree/master/04-skeletal-animation)


## 中级示例

### Sound Support

This example features [sound]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) coming out of an entity, notice how the volume diminishes relative to distance from it. It also includes an animated GLTF object and a floor that randomly changes color. [Link](https://github.com/decentraland/sample-scene-sound-support)

这个例子的特点是一个发出[声音]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %})的实体，注意音量是如何随着距离的增加而减小的。它还包括一个动态的 GLTF 对象和一个随机改变颜色的地板。[链接](https://github.com/decentraland/sample-scene-sound-support)

### Video Support

In this example, you can interact with two video players. One loads the video company into the scene's assets, the other streams it from an external source. You can also pause, stop and change the volume of the video players. [Link](https://github.com/decentraland/sample-scene-video-support)

在此示例中，您可以与两个视频播放器进行交互。一个将视频加载到场景的资源中，另一个使用外部源来加载。您还可以暂停、停止和更改视频播放器的音量。 [链接](https://github.com/decentraland/sample-scene-video-support)

### Multiplayer Content

在此示例中，基于初级示例中门的例子，您可以通过打开和关闭门来与门互动，而另一个玩家则在同一个房间，可以看到门状态的改变。构建这个简单的示例是为了让您了解多用户环境是如何工作的，其中有多个用户与同一实体交互。 [链接](https://github.com/decentraland/sample-scene-server)

注：类似的例子在[博客](https://blog.decentraland.org/sdk-highlight-building-an-underwater-landscape-5bfcce73ff35)中有更详细的讨论。


## 高级示例

### 简单记忆游戏

In this example, that's described in greater detail in a [blogpost](https://blog.decentraland.org/building-a-memory-game-using-decentralands-sdk-87ee35968f8d), you play with a "Simon Says" game. This game is a good example of how to add more complex logic into a scene and how to change its state based on how the user interacts with it. [link](https://github.com/decentraland/sample-scene-memory-game)

在这个例子中，在[博客](https://blog.decentraland.org/building-a-memory-game-using-decentralands-sdk-87ee35968f8d)中有更详细的描述，你玩的是一个“西蒙说”的游戏。这个游戏是如何将更复杂的逻辑添加到场景中以及如何根据用户与其交互方式更改其状态的一个很好的示例。 [链接](https://github.com/decentraland/sample-scene-memory-game)


### 付款使用

这是个基于初级示例中的门的例子，你只有支付 10 MANA 到特定的钱包，你才能打开这个门。这个示例展示了如何使用 SDK 来跟踪区块链交易。
[链接](https://github.com/decentraland/sample-scene-payments)


<!---
### Redux

-->
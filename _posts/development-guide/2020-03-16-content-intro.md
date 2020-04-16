---
date: 2018-02-11
title: Intro for content creators
description: How you can create content for Decentraland
categories:
  - development-guide
redirect_from:
  - /documentation/scene-files/
type: Document
---

# Let’s build the metaverse together

Decentraland is made up of _parcels_ of LAND, each 16 meters by 16 meters. A _scene_ is an experience is is built on one or several parcels.

There are two tools you can use for creating Decentraland scenes:

- The [Builder](builder.decentraland.org): a simple _drag and drop_ editor. No coding required, everything is visual and many default items are at your disposal to use.
- The Decentraland SDK: write code to create your scene. This gives you much greater freedom and is a lot more powerful.

The Builder uses the Decentraland SDK under the hood, generating the required code without you ever needing to look at it. You can start a scene with the Builder, and then export it to continue working on it with the SDK.

> Note: You can only import scenes that were created with the Builder back into the Builder. If a scene is created by or modified by the SDK, you can't import it back.

Scenes are displayed one next to the other and players can freely walk from one to the other. Each scene is its own contained little world, items from one scene can't extend out into another scene, and the code for each scene is sandboxed from all others.

# The Builder

Go to the [Builder](builder.decentraland.org) and try it out!

Take a look at our video tutorials

# The SDK

### The Decentraland SDK provides everything you need to build interactive 3D content for Decentraland.

Install the CLI by running:

```bash
npm install -g decentraland
```

Then go to the [SDK 101]({{ site.baseurl }}{% post_url /development-guide/2020-03-16-SDK-101 %}) tutorial.

## Shortcuts

<div class="shortcuts">
  <a href="{{ site.baseurl }}{% post_url /development-guide/2018-01-02-coding-scenes %}">
    <div>
      <div class="image"><img src="/images/home/1.png"/></div>
      <div class="title">Coding scenes</div>
      <div class="description">An overview of the tools and the essential concepts surrounding the SDK.</div>
    </div>
  </a>
  <a href="https://github.com/decentraland/ecs-reference">
    <div>
      <div class="image"><img src="/images/home/2.png"/></div>
      <div class="title">Component and object reference</div>
      <div class="description">A complete reference of the default components and other available objects, with their functions.</div>
    </div>
  </a>
  <a href="{{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}">
    <div>
      <div class="image"><img src="/images/home/3.png"/></div>
      <div class="title">Scene examples</div>
      <div class="description">Several code examples to get you started, and inspire your creations.</div>
    </div>
  </a>
</div>

Several libraries are built upon the Decentraland SDK to help you build faster:

- [Utils library](https://www.npmjs.com/package/decentraland-ecs-utils): Simplifies a lot of common tasks like moving or rotating an entity, or triggering a function when the player walks into a cube.

- [Decentral API](https://www.decentral.io/docs/dcl/overview/): Simplifies making fast and cheap blockchain transactions triggered by the scene, using the Matic network.

## SDK Scene examples

<div class="examples">
  <a target="_blank" href="https://github.com/decentraland-scenes/Hypno-wheels">
    <div>
      <img src="/images/home/example-hypno-wheel.png"/>
      <span>Hypno wheels</span>
    </div>
  </a>
  <a target="_blank" href="https://github.com/decentraland-scenes/Hummingbirds">
    <div>
      <img src="/images/home/hummingbirds.png"/>
      <span>Hummingbirds</span>
    </div>
  </a>
  <a target="_blank" href="https://github.com/decentraland-scenes/Gnark-patrol">
    <div>
      <img src="/images/home/example-gnark.png"/>
      <span>Gnark patrolling</span>
    </div>
  </a>
</div>

See [scene examples]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}) for more scene examples.

Also see [tutorials]({{ site.baseurl }}{% post_url /tutorials/2018-01-03-tutorials %}) for detailed instructions for building scenes like these.

## Other useful information

- [Design constraints for games]({{ site.baseurl }}{% post_url /design-experience/2018-01-08-design-games %})
- [3D modeling]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %})
- [Scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})

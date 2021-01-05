---
date: 2018-02-11
title: Overview
description: How you can create content for Decentraland
categories:
  - development-guide
type: Document
---

Decentraland is made up of _parcels_ of LAND, each 16 meters by 16 meters. A _scene_ is an experience that is built on one or several parcels.

Scenes are displayed one next to the other and players can freely walk from one to the other. Each scene is its own contained little world, items from one scene can't extend out into another scene, and the code for each scene is sandboxed from all others.

There are two tools you can use for creating interactive Decentraland scenes:

- **The Builder**: a simple _drag and drop_ editor. No coding required, everything is visual and many default items are at your disposal to use.

- **The Decentraland SDK**: write code to create your scene. This gives you much greater freedom and is a lot more powerful.

The Builder uses the Decentraland SDK under the hood, generating the required code without you ever needing to look at it. You can start a scene with the Builder, and then export it to continue working on it with the SDK.

> Note: If a scene is created by or modified by the SDK, you can't import it into the Builder. You can only go from the Builder to the SDK, not in the other direction.

# The Builder

Open the [Builder](https://builder.decentraland.org) and try it out!

Take a look at our [video tutorials](https://www.youtube.com/playlist?list=PLAcRraQmr_GPi-8qgv17ewdGl50OHuOhH)

Or read the [documentation]({{ site.baseurl }}{% post_url /builder/2020-03-16-builder-101 %})

# The SDK

Follow the [SDK 101]({{ site.baseurl }}{% post_url /development-guide/2020-03-16-SDK-101 %}) tutorial for a quick crash course.

Take a look at the [escape room video tutorial series](https://hardlydifficult.github.io/dcl-escape-room-tutorial/).

Or read the [documentation]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %})

## Shortcuts

<div class="shortcuts">
  <a href="{{ site.baseurl }}{% post_url /development-guide/2018-01-02-coding-scenes %}">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/home/1.png"/></div>
      <div class="title">Coding scenes</div>
      <div class="description">An overview of the tools and the essential concepts surrounding the SDK.</div>
    </div>
  </a>
  <a href="https://github.com/decentraland/ecs-reference">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/home/2.png"/></div>
      <div class="title">Component and object reference</div>
      <div class="description">A complete reference of the default components and other available objects, with their functions.</div>
    </div>
  </a>
  <a href="https://github.com/decentraland-scenes/Awesome-Repository#Examples">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/home/3.png"/></div>
      <div class="title">Scene examples</div>
      <div class="description">Several code examples to get you started, and inspire your creations.</div>
    </div>
  </a>
</div>

Several libraries are built upon the Decentraland SDK to help you build faster, see the full list in the [Awesome Repository](https://github.com/decentraland-scenes/Awesome-Repository#libraries)

## SDK Scene examples

<div class="examples">
  <a target="_blank" href="https://github.com/decentraland-scenes/Hypno-wheels">
    <div>
      <img src="{{ site.baseurl }}/images/home/example-hypno-wheel.png"/>
      <span>Hypno wheels</span>
    </div>
  </a>
  <a target="_blank" href="https://github.com/decentraland-scenes/Hummingbirds">
    <div>
      <img src="{{ site.baseurl }}/images/home/hummingbirds.png"/>
      <span>Hummingbirds</span>
    </div>
  </a>
  <a target="_blank" href="https://github.com/decentraland-scenes/Gnark-patrol">
    <div>
      <img src="{{ site.baseurl }}/images/home/example-gnark.png"/>
      <span>Gnark patrolling</span>
    </div>
  </a>
</div>

See [scene examples](https://github.com/decentraland-scenes/Awesome-Repository#Examples) for more scene examples.

Also see [tutorials](https://github.com/decentraland-scenes/Awesome-Repository#Tutorials) for detailed instructions for building scenes like these.

## Other useful information

- [Design constraints for games]({{ site.baseurl }}{% post_url /design-experience/2018-01-08-design-games %})
- [3D modeling]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %})
- [Scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})

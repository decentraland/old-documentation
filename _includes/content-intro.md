# Let’s build the metaverse together

Decentraland is made up of _parcels_ of LAND, each 16 meters by 16 meters. A _scene_ is an experience that is built on one or several parcels.

Scenes are displayed one next to the other and players can freely walk from one to the other. Each scene is its own contained little world, items from one scene can't extend out into another scene, and the code for each scene is sandboxed from all others.

There are two tools you can use for creating interactive Decentraland scenes:

- **The Builder**: a simple _drag and drop_ editor. No coding required, everything is visual and many default items are at your disposal to use.

- **The Decentraland SDK**: write code to create your scene. This gives you much greater freedom and is a lot more powerful.

The Builder uses the Decentraland SDK under the hood, generating the required code without you ever needing to look at it. You can start a scene with the Builder, and then export it to continue working on it with the SDK.

> Note: If a scene is created by or modified by the SDK, you can't import it into the Builder. You can only go from the Builder to the SDK, not in the other direction.

# The Builder

[Try the Builder](https://builder.decentraland.org)! It's a fun tool to explore on your own.

See our [video tutorials]({{ site.baseurl }}{% post_url /tutorials/2020-03-16-builder-video-tutorials %}).

Or read the [documentation]({{ site.baseurl }}{% post_url /builder/2020-03-16-builder-101 %}).

# The SDK

Follow the [SDK 101]({{ site.baseurl }}{% post_url /development-guide/2020-03-16-SDK-101 %}) tutorial for a quick crash course.

Take a look at the [escape room video tutorial series](https://hardlydifficult.github.io/dcl-escape-room-tutorial/).

Or read the [documentation]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}) to grasp some of the fundamental concepts.

#### SDK Shortcuts

<div class="shortcuts">
  <a href="{{ site.baseurl }}{% post_url /general/2018-01-01-introduction %}">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/BackWorld.png" width="380" height="380"/></div>
      <div class="title">World</div>
      <div class="description">General info for players.</div>
    </div>
  </a>
  <a href="{{ site.baseurl }}{% post_url /market/2018-01-01-marketplace %}">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/BackMarket.png" width="380" height="380"/></div>
      <div class="title">Market</div>
      <div class="description">Learn how to trade exclusive tokens.</div>
    </div>
  </a>
  <a href="{{ site.baseurl }}{% link content-intro.html %}">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/BackCreate.png" width="380" height="380"/></div>
      <div class="title">Create</div>
      <div class="description">Learn to build and share your creations.</div>
    </div>
  </a>
  <a href="{{ site.baseurl }}{% post_url /blockchain-integration/2020-02-17-get-a-wallet %}">
    <div>
      <div class="image"><img src="{{ site.baseurl }}/images/BackEth.png" width="380" height="380"/></div>
      <div class="title">Ethereum Essentials</div>
      <div class="description">Learn how we use the blockchain.</div>
    </div>
  </a>
</div>

Several libraries are built upon the Decentraland SDK to help you build faster:

- [Utils library](https://www.npmjs.com/package/decentraland-ecs-utils): Simplifies a lot of common tasks like moving or rotating an entity, or triggering a function when the player walks into a cube.

- [Decentral API](https://www.decentral.io/docs/dcl/overview/): Simplifies making fast and cheap blockchain transactions triggered by the scene, using the Matic network.

#### SDK Scene examples

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

See more [scene examples](https://github.com/decentraland-scenes/Awesome-Repository#examples).

Also see [tutorials](https://github.com/decentraland-scenes/Awesome-Repository#Tutorials) for detailed instructions for building scenes like these.

# 3d Modeling

If you have experience with 3D modeling, you can use any 3rd party modeling tool to create 3D models that can be used in Decentraland scenes. It's easy to [import them into the Builder]({{ site.baseurl }}{% post_url /builder/2020-03-16-import-items %}).

See [3D modeling]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %}) for tips and tricks, and information about supported features and formats for 3D models.

# Design your experience

No matter which tools you'll use, it's always recommended that you think carefully about what you want to build before you start building it. Read the [Design experiences]({{ site.baseurl }}{% post_url /design-experience/2018-06-26-mvp-guidelines %}) section to better understand the context, limitations and possibilities that you'll have as your design space when creating a scene for Decentraland.

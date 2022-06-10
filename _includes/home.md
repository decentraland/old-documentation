# Let’s build the metaverse together

Decentraland is made up of _parcels_ of LAND, each 16 meters by 16 meters. A _scene_ is an experience that is built on one or several parcels.

Scenes are displayed one next to the other and players can freely walk from one to the other. Each scene is its own contained little world, items from one scene can't extend out into another scene, and the code for each scene is sandboxed from all others.

Each parcel of land is tokenized as an NFT. To be allowed to [publish]({{ site.baseurl }}{% post_url /development-guide/2018-01-07-publishing %}) a scene to a land parcel, you either need to own that NFT or be given permissions by the owner.

<!--
You can also create smart wearables, which are wearable items of clothes that come with their own behavior. Players that put on that wearable can access a whole other layer of experiences on top of Decentraland. -->

## The Decentraland SDK

The Decentraland SDK allows you to create your scene by writing in TypeScript (JavaScript + types).

- Follow the [SDK 101]({{ site.baseurl }}{% post_url /development-guide/2020-03-16-SDK-101 %}) tutorial for a quick crash course.

- Read the [documentation]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}) to grasp some of the fundamental concepts.

- Check out scene [examples](https://github.com/decentraland-scenes/Awesome-Repository#examples).


## Graphical editing tools

There are a number of tools that can help with arranging 3d models into position in a Decentraland scene. You still need to resort to the SDK to add interactivity to these items, but setting positions visually is a big help.

- [**DCL Edit**](https://dcl-edit.com/): A community-built tool that allows you to drag and drop 3d models into your scene. You can then work on adding interactivity to the resulting scene using the SDK.

- **In-world Builder**: While running Decentraland, open the settings and select **Build**, you can then create non-interactive scenes by dragging and dropping 3d models.

- [**Legacy Builder**](https://builder.decentraland.org): a simple drag and drop editor. No coding required, some items include built-in functionality. You can start a scene with the Builder, and then export it to continue working on it with the SDK.

	Read the [documentation]({{ site.baseurl }}{% post_url /builder/2020-03-16-builder-101 %}).

	> Note: If a scene is created by or modified by the SDK, you can't import it into the Builder. You can only go from the Builder to the SDK, not in the other direction.




## 3d Modeling

You can use any 3rd party modeling tool to create 3D models that can be used in Decentraland scenes. It's easy to [import them into the Builder]({{ site.baseurl }}{% post_url /builder/2020-03-16-import-items %}).

See [3D modeling]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %}) for tips and tricks, and information about supported features and formats for 3D models.

## Design your experience

No matter which tools you'll use, it's always recommended that you think carefully about what you want to build before you start building it. Read the [Design experiences]({{ site.baseurl }}{% post_url /design-experience/2018-06-26-mvp-guidelines %}) section to better understand the context, limitations and possibilities that you'll have as your design space when creating a scene for Decentraland.

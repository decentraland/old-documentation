---
date: 2018-02-11
title: Manage Builder scenes
description: Getting started with the Builder
categories:
  - builder
type: Document
---

## Export a scene

While editing a scene, press the _Download scene_ icon to download the contents of the scene as a _.zip_ file. In the scene selector screen, you can also press the _three dots_ icon and select _Download scene_.

![]({{ site.baseurl }}/images/media/builder-export.png)

You can then share this scene with another Builder user, or edit the scene with more freedom by using the Decentraland SDK.

See [SDK 101]({{ site.baseurl }}{% post_url /development-guide/2020-03-16-SDK-101 %}) if you're not yet familiar with coding with the Decentraland SDK.

## Import a scene

In the scene selector screen, press _Import scene_, then drag one or several _.zip_ files from exported Builder scenes and press _Import_.

If a scene is too large to import, try this:

1. Decompress the scene _.zip_ file.
2. Look for the `builder.json` inside the uncompressed folder. Compress that single file into a new _.zip_ file.
3. Import this new _.zip_ file.

> Note: You can only import scenes that have been built with the Builder. You can't import a scene that was built with the SDK or modified with it.

## Delete a scene

In the scene selector screen, press the _three dots_ icon and select _Delete scene_.

## Scene storage

If your Builder account is accessed via an in-browser wallet, like Metamask or Dapper, all of your existing scenes are saved and updated to a cloud storage that you can access from any other device where you're logged in.

If you don't have your account connected to an in-browser wallet, your scenes are stored in the browser's cache storage. They won't be available if you log in from another device. Be careful not to clear the browser's storage, as you will lose your scenes. We advise exporting your scenes to keep a backup in your local disk.

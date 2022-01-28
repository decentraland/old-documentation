---
date: 2021-01-11
title: Performance Optimization
description: Optimize your scene to load fast and run smoothly for all players.
categories:
  - development-guide
type: Document
---

There are several aspects you can optimize in your scenes to ensure the best possible experience for players who visit them. This document covers some best practices that can make a big difference in how fast your scene loads and how smoothly it runs for players that are on it or on neighboring scenes.

Keep in mind that many players may be visiting Decentraland using hardware that is not built for gaming, and via the browser, which limits how much of the hardware's processing power is available to use. The experience of visiting your scene should be smooth for everyone.

The Decentraland explorer enforces many optimizations at engine level. These optimizations make a big difference, but the challenge of rendering multiple user-generated experiences simultaneously in a browser is a big one. We need your help to make things run smoothly.

## Timing

#### Video playing

Playing videos is one of the most expensive things for the engine to handle. If your scene includes videos, make sure that only _ONE_ VideoTexture is in use at a time. You can have dozens of planes sharing the same VideoTexture without significant impact on performance, but as soon as you add a second VideoTexture, its effects on framerate become very noticeable.

You should also avoid having videos playing in regions where they can't be seen. For example, if you have a screen indoors, toggle the video using a trigger area based on when the player walks in and out.

> TIP: A trick several scenes have used is to stream a single video with multiple regions that are mapped differently to different planes. Each video screen uses [UV mapping]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}#using-textures) ) to only show a distinct part of the VideoTexture. Thanks to this, it can appear that there are separate videos playing without the cost of multiple VideoTextures.

> TIP: When players are standing outside your scene, VideoTextures are not updated on every frame. This helps reduce the impact for surrounding scenes. It's nevertheless ideal only turn on the playing of any videos when players [step inside your scene]({{ site.baseurl }}{% post_url /development-guide/2021-04-03-event-listeners %}#player-enters-or-leaves-scene) ) .

#### Lazy loading

If your scene is large, or has indoor areas that are not always visible, you can choose to not load the entire set of entities from the very start. Instead, load the content by region as the player visits different parts of the scene. This can significantly reduce the load time of the scene, and also the amount of textures and 3d content that the engine needs to handle on every frame.

For example, the main building of a museum could load from the start, but the paintings on each floor only load for each player as they visit each floor.

See [this example scene](https://github.com/decentraland-scenes/lazy-loading) for how that might work.

For the best result in terms of avoiding hiccups, hide entities by switching their shape's `visible` property to false. With this approach, you add them to the engine when creating them, but you simply don't make their models visible.

An alternative is to not add the entities to the engine until needed. This may result in some hiccups when the entities appear for the first time, and they might also take a couple of seconds to become visible. The advantage of this approach is that it's a valid way to get around the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %})). Keep in mind that the scene limitations count is for the content that is being rendered in the scene at any given time, not for the total content that could be rendered. Loading and unloading parts of the scene should allow you to work around those limitations.

> Note: Entities that are not visible but are added to the engine do count towards the scene limitations.

You can also toggle animations on or off for entities that are far or occluded. For example, for an NPC that plays a very subtle idle animation, you could make it only play that animation when the player is at less than 20 meters away. Use a trigger area around the NPC and toggle its animations on or off accordingly.

> TIP: When an entity is far away and small enough, it's culled by the engine. This culling helps at a drawcall level, removing entities from the engine is always better. This culling also doesn't take occlusion by other entities into account, so entities that are not so small but hidden by a wall are still rendered.

#### Async blocks

Blocks of [async code]({{ site.baseurl }}{% post_url /development-guide/2018-02-25-async-functions %})) are processed in a separate thread from the rest of the scene, to prevent blocking the progress of everything else.

Any processes that rely on responses from asynchronous services, such as `getPlayerData()` or `getRealmData()` should always run in async blocks, as they otherwise block the rest of the scene's loading while waiting for a response. The same applies to any calls to third party servers.

Note that the scene will be considered fully loaded when everything that isn't async is done. Async processes might still be running when the player enters the scene. Avoid situations where an async process results in the loading of an entity that could potentially get the player stuck inside of its geometry.

#### Rely on Events

Try to make the scene's logic rely on listening to [events]({{ site.baseurl }}{% post_url /development-guide/2021-04-03-event-listeners %})) as much as possible, instead of running checks every frame.

The `update()` function in a [system]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %})) runs on every frame, 30 times per second (ideally). Avoid doing recurring checks if you can instead subscribe to an event.

For example, instead of constantly checking the player's wearables, you can subscribe to the `onProfileChanged` event, and check the player's wearables only when they've changed.

If you must use a system, avoid doing checks or adjustments on every single frame. You can include a timer as part of the update function and only run the check once per every full second, or whatever period makes sense.

## Optimize 3d models

There are several ways in which your 3d models can be optimized to be lighter.

- When possible, share textures across 3d models. A good practice is to use a single texture as an atlas map, shared across all models in the scene. It's better to have 1 large shared texture of 1024x1024 pixels instead of several small ones.

  > Note: Avoid using the same image file for both the albedo texture and the normal map or the emissive map of a material. Use separate files, even if identical. Assigning a same image file to different types of texture properties may introduce unwanted visual artifacts when compressed to asset bundles.

- _.glb_ is a compressed format, it will always weigh less than a _.gltf_. On the other hand, with _.gltf_ it's easy to share texture images by exporting textures as a separate file. You can have the best of both worlds by using the [following pipeline](https://github.com/AnalyticalGraphicsInc/gltf-pipeline), that allows you to have _.glb_ models with external texture files.

- Avoid using blended transparencies. Blended transparencies have to bypass quite a few of the rendering optimizations. If possible, favor opaque or alpha tested geometry.

- Avoid skinned meshes. They can drag down the performance significantly.

> TIP: Read more on 3d model best practices in the [3d Modeling Section]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-09-3d-models %}))

#### Asset Bundle conversion

About once a day, the Decentraland content servers run a process to compress every _.gltf_ and _.glb_ model in every newly deployed scene to asset bundle format. This format is _significantly_ lighter, making scenes a lot faster to load and smoother to run on the browser.

> Tip: When planning an event in Decentraland, make sure you deploy your scene a day in advance, so that the models are all converted to asset bundles by then. If you don't want to spoil the surprize before the event, you can deploy a version of your scene that includes all the final 3d models in the project folder, but where these are not visible or where their size is set to 0.

> Note: If you make _any_ change to a 3d model file, even if just a name change, it will be considered a new file, and must be converted to asset bundle format again.

## Connectivity

If your scene connects to any 3rd party servers or uses the [messagebus]({{ site.baseurl }}{% post_url /development-guide/2018-01-10-remote-scene-considerations %})) to send messages between players, there are also some things you might want to keep in mind.

- Your scene should only have one active WebSockets connection at a time.
- HTTP calls are funneled by the engine so that only one is handled at a time. Any additional requests are queued internally and must wait till other requests are completed. This queuing process is handled automatically, you don't need to do anything.
- When using the [messagebus]({{ site.baseurl }}{% post_url /development-guide/2018-01-10-remote-scene-considerations %})) to send messages between players, be mindful that all messages are sent to all other players in the server island. Avoid situations where an incoming message directly results in sending another message, as the number of messages can quickly grow exponentially when there's a crowd in the scene.

## Scene UI

Scene UIs can become costly to render when they are made up of many individual elements. Keep in mind that each UI element requires a separate drawcall on the engine.

> TIP: Try to merge multiple elements into one single image. For example if you have a menu with multiple text elements, it's ideal to have the text from the tiles and any additional images baked into the background image. That saves the engine from doing one additional drawcall per frame for each text element.

Avoid making adjustments to the UI on every frame, those are especially costly and can end up getting queued. For example, if there's a health bar in your UI that should shrink over period of time, players would probably not notice a difference between if it updates at 10 FPS instead of at 30 FPS (on every frame). The system that updates this bar can use a brief timer that counts 100 milliseconds, and only affect the UI when this timer reaches 0.

Avoid having many hidden UI elements, these also have an effect on performance even if not being rendered. When possible, try to create UI components on demand.

## Monitor Performance

The best metric to know how well a scene is performing is the FPS (Frames Per Second). In preview, you can see the current scene FPS in the debug panel. You should aim to always have 30 FPS or more.

In the deployed scene, you can toggle the panel that shows these metrics by writing `/showfps` into the chat window.

One of the main bottlenecks in a scene’s performance is usually the sending of messages between the scene’s code and the engine.

When you run a scene in preview, note that on the top-right corner it says “Y = Toggle Panel”. Hit Y on the keyboard to open a panel with some useful information that gets updated in real time.

As you interact with things that involve messages between the SDK and the engine, you’ll notice the ‘Processed Messages’ number grows. You should closely watch the ‘Pending on Queue’ number, it should always be 0 or close to 0. This tells you how many of these messages didn't get to be processed, and got pushed to a queue. If the ‘Pending on Queue’ count starts to grow, then you’ve entered the danger zone and should think about doing more optimizations to your scene.

> Note: Don’t keep the panel open while you’re not using it, since it has a negative impact on performance.

Keep in mind that the performance you experience in preview may differ from that in production:

- Surrounding neighboring scenes might have a negative impact
- The compression of the scenes' 3d models into asset bundles can have a positive impact
- Some players visiting your scene may be running on less powerful hardware

It's always a good practice to try deploying your scene first to the [test environment]({{ site.baseurl }}{% post_url /development-guide/2018-01-07-publishing %}#the-test-server)) to do some more thorough testing.

Always ask players for feedback. Never take for granted that how you experience the scene is the same for everyone else.

<!--
## Desktop

Check if your player is using desktop, show heavier models in that case


-->

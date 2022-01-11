---
date: 2021-01-11
title: Performance Optimization
description: Optimize your scene to load fast and run smoothly for all players.
categories:
  - development-guide
type: Document
---

There are a number of things you can optimize in your scene to ensure the best possible experience for players visiting. This document will cover a number of best practices that can make a big difference in how fast your scene loads and how smoothly it runs for players that are on it. Keep in mind that many players may be visiting Decentraland using hardwarde that is not designed for gaming, and via the browser, which heavily limits how much of the hardware's processing power is available to use.

## Loading timing

#### Video playing

Playing videos is one of the most expensive things for the engine to handle. If your scene includes videos, make sure that only _ONE_ VideoTexture is in use at a time. You can have dozens of planes sharing the same VideoTexture without significant impact on performance, but as soon as you add a second VideoTexture, its effect on framerate becomes very noticeable.

You should also avoid having videos playing in regions where they can't be seen. For example, if you have a screen indoors, turn the video on or off with a trigger area based on when the player walks in and out. This also makes you a better neighbor to the scenes around you.

> TIP: A trick several scenes have used is to stream a single video with multiple regions that are meant to be mapped differently to different planes. Then each video screen uses UV mapping to only show a distinct part of the VideoTexture, and it may appear like there are separate videos playing without the cost of multiple VideoTextures.

#### Lazy loading

If your scene is large, or has indoor areas that are not always visible, you can choose to not load the entire set of entities from the very start, but instead load the content by region as the player visits different parts of the scene. This can significantly reduce the load time of the scene, and also the amount of textures and 3d content that the engine needs to handle on every frame.

For example, the main building of your museum could load from the start, but the paintings on each floor only load as you visit each floor.

> TIP: The [scene limitations] are all for the content that is being rendered in the scene at any given time, not for the total content that could be rendered. So loading and unloading parts of the scene is also a great way to get around those limitations.

Link to example

In a similar spirit, you can toggle animations on or off for entities that are far or occluded. For example, an NPC that plays a very subtle idle animation might only play that animation when the player is at less than 20 meters away, as it would hardly be noticeable from a greater distance. You could use a trigger area around the PC and toggle its animations on or off accordingly.

#### Async blocks

Blocks of [async code] are processed in a separate thread from the rest of the scene, not blocking the progress of everything else.

Any processes that rely on responses from asynchronous services, such as getPlayerData() or getRealmData() should always run in async blocks, as they otherwise block the rest of the scene's loading while waiting for a response.

Note that the scene will be considered fully loaded even if these async processes are still running. Avoid situations where entities that are loaded later could potentially get the player stuck inside their geometry.

## Optimize 3d models

There are several ways in which your 3d models can be optimized to be lighter.

- When possible, share textures across 3d models. Map a same texture to all of them
- GLB is a compressed format unlike GLTF, but it's more complicated to share textures across multiple GLB files. You can do this however with ...

link

- asset bundle conversions: allow time

## Connectivity

If your scene connects to any 3rd party servers or uses the messagebus to send messages between players, there are also some things you might want to keep in mind.

- Your scene should only have one active WebSockets connection at a time.
- HTTP calls are funneled by the engine so that only one is handled at a time. Any additional requests are queued internally and must wait till other requests are completed. You don't need to do anything for this to happen, this optimization is implemented on all scenes.
- When using the messagebus to send messages between players, be mindful that messages are sent to all other players in the server island. If each message is then responded, then that response is also sent to all other players in the server island, which can grow exponentially. For example, if a new player loading the scene sends a message to request the state of a door in the scene, expecting other players to respond, it's not ideal to have all players respond with the door's state. If there are 10 other players in the scene, that would lead to 100 response messages being sent.

## Scene UI

Scene UI elements can become costly to render if there are many of them. Keep in mind that each UI element is a separate drawcall to the engine. To optimize, try to merge multiple elements into one image, for example if you have an elaborate menu with multiple titles, it's better to have the text from the tiles baked into the background image.

## Monitor Performance

The best indication to know how well a scene is performing is to see the FPS (Frames Per Second). In preview, you can see the current scene FPS in the bottom-right corner.

In the deployed scene, you can see these metrics by writing `/showfps` in the chat window.

One of the main bottlenecks in a scene’s performance is usually the sending of messages that happens between the scene’s code and the engine.

When you run the scene in preview mode, note that on the top-right corner it says “P = Toggle Panel”. Hit P on the keyboard to open panel with some useful information that gets updated in real time as you interact.

As you interact with things that involve messages between the SDK and the engine, you’ll notice the ‘Processed Messages’ number grows. That’s alright as long as the ‘Pending on Queue’ number remains in 0 or close to 0. If that number starts to grow, then you’ve entered the danger zone and you know you need to do more optimizations.

> Note: Don’t keep the panel open while you’re not using it, since it has an impact on performance.

Keep in mind that the performance you experience in preview may differ from that in production:

- Surrounding neighboring scenes might have a negative impact
- The compression of the scenes' 3d models into asset bundles can have a positive impact
- Some players visiting your scene may be running on less powerful hardware

Because of this, it's a good practice to try deploying your scene first to the test enviroment (link) to do some more thorough testing. And of course, it's always good to ask players for feedback.

<!--
## Desktop

Check if your player is using desktop, show heavier models in that case


-->

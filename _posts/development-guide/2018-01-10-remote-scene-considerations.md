---
date: 2018-01-10
title: About remote scenes
description: Tips and tricks for remote scenes with multiple users
redirect_from:
  - /documentation/remote-scene-considerations/
categories:
  - development-guide
type: Document
set: development-guide
set_order: 30
---

By default, the current version of Decentraland runs scenes locally in a user's machine. This is the simplest way to code a scene, but it has its limitations. Users are able to see each other and interact directly, but each interacts with the environment independently. If a user opens a door and walks into a house, other users will see that door still closed and the user will appear to walk directly through the closed door.

Remote scenes use a remote server to synchronize data amongst all users in a scene, which allows them to see the same content and to interact in more meaningful ways.

## Create remote scenes

To copy one of the [sample scenes]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}) that implements a remote server, follow the steps in the [create scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-03-create-scene %}) to clone a sample scene.

To transform an existing local scene into remote, we recommend cloning the [remote door scene]() and then copying the _game.ts_ file of the old scene into the new remote scene folder.

## Preview remote scenes

To preview a remote scene, you must run both the scene and the server it relies on. The server can also be run locally in the same machine as the preview.

To start the server, go to the `/server` folder and run `npm start`.

Once the server is running, either remotely or locally, you can run `dcl start` on the scene as you normally do for local scenes.

Once the scene preview is running, you can open multiple browser tabs pointing at the same local address. Each tab will instantiate a separate user in the same scene, these users will share the same scene state.

See [preview a scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-04-preview-scene %}) for more details.

## Multiplayer persistance

Unlike local scenes that are newly mounted each time a user walks into them, remote scenes have a life span that extends well beyond when the user enters and leaves the scene.

You must therefore design the experience taking into account that users won't always find the scene in the same initial state.
Any changes made to the scene will linger on for other users to find, you must make sure that these don't interfere with future user's experiences in an undesired way.

#### Reset the state

When loading the scene, make sure its built based on the shared information stored in the server, and not in a default state.

In some cases, it makes sense to include some kind of reset button in the scene. Pressing the reset button would reset the scene gracefully.

Sometimes, this just implies setting the variables in the scene state back to default values. But resetting the scene might also involve unsubscribing listeners and stopping loops in the server side. If empty loops remain each time the scene is reset, these would keep piling up and will have an ill effect on the scene's performance. 

> Tip: To stop a time-based loop, you can use `clearInterval()`, passing it the loop's id.

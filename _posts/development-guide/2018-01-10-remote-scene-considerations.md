---
date: 2018-01-10
title: Remote scene considerations
description: Tips and tricks for remote scenes with multiple users
redirect_from:
  - /documentation/remote-scene-considerations/
categories:
  - development-guide
type: Document
set: development-guide
set_order: 10
---

## Scene state in remote scenes

Remote scenes store their state in a remote server instead of in each user's local client. This means that all users of the scene share the same state, which allows them to see the same content in the scene and to interact in more meaningful ways. See [scene state]({{ site.baseurl }}{% post_url /development-guide/2018-01-04-scene-state %}) for more about the scene state.

## Create remote scenes

To copy one of the [sample scenes]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}) that implements a remote server, follow the steps in the [create scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-03-create-scene %}) to clone a sample scene.

To transform an existing local scene into remote, we recommend cloning the [sample multiplayer scene](https://github.com/decentraland/sample-scene-server) and then copying the contents from the _scene.tsx_ file of the old scene into the _RemoteScene.tsx_ file of the new remote scene.

You should also make the following changes to the scene's code:

- Remove the state definition from the scriptable scene object in _scene.tsx_. Paste that same state definition in the _State.ts_ file.
- Replace all uses of `this.state.<variable>` with `getState().<variable>`.
- Replace all uses of `this.setState()` with `setState()`.

## Preview remote scenes

To preview a remote scene, you must run both the scene and the server it relies on. The server can also be run locally in the same machine as the preview.

Once the server is running, either remotely or locally, you can run `dcl start` on the scene as you normally do for local scenes.

Once the scene preview is running, you can open multiple browser tabs pointing at the same local address. Each tab will instantiate a separate user in the same scene, these users will share the same scene state.

See [preview a scene]({{ site.baseurl }}{% post_url /getting-started/2018-01-04-preview-scene %}) for more details.

## Multiplayer persistance

Unlike local scenes that are newly mounted each time a user walks into them, remote scenes have a life span that extends well beyond when the user enters and leaves the scene.

You must therefore design the experience taking into account that users won't always find the scene in the same initial state.
Any changes made to the scene will linger on for other users to find, you must make sure that these don't interfere with future user's experiences in an undesired way.

#### Reset the state

You shouldn't set the scene state to default values in the `sceneDidMount()` method. If you do, this would ensure that each user that walks into your scene finds it in the same state. The problem is that if a second user enters the scene, `sceneDidMount()` would be called again and the scene state would be reset for all users. This is generally a poor experience for the user that was already in the scene.

In some cases, it makes sense to include some kind of reset button in the scene. Pressing the reset button would reset the scene gracefully.

Sometimes, this just implies setting the variables in the scene state back to default values. But resetting the scene might also involve unsubscribing listeners and stopping loops. If empty loops remain each time the scene is reset, these would keep piling up and will have an ill effect on the scene's performance. To stop a time-based loop, you can use `clearInterval()`, passing it the loop's id.

#### Subscribe to all possible events

More likely, you'll want new users that walk into the scene to be able to interact with everything that's there.

One thing that's commonly overlooked is that new users must be subscribed to all the events that are available in the scene. Since the scene state may vary, so can the available events if they relate to the state.

For example, suppose your scene has blob enemies that spawn randomly. When one of these is spawned, the scene state is updated to add the new blob's position to an array and the client subscribes to a click event for that blob. Users that were present in the scene at the time that a blob was spawned should be able to see it and interact with it. On the other hand, new users that arrive to the scene after it was already spawned will see it (as they have access to the scene state) but won't be subscribed to its click event.

You can solve this by subscribing new users to click events for each blob that is currently in the scene at the time they arrive.

{% raw %}

```tsx
sceneDidMount() {
    for(blob trap of getState().blobs) {
      this.eventSubscriber.on(blob.id + "_click", () =>
      {
        this.killBlob()
      }
    }
  }
```

{% endraw %}

## User distinction

When multiple users are interacting with your scene, you might care about which user performed what action.

You can extract a user's id from an event when listening to events through `subscribeTo()`. For example, the example below listens for click events and registers the user's id in the scene state.

{% raw %}

```tsx
  async sceneDidMount() {
    this.subscribeTo("click", e => {
      setState({ lastUserToClick: e.pointerId })
      console.log(getState().lastUserToClick)
    })
  }
```

{% endraw %}

User id's are assigned to users when they enter Decentraland, but they don't persist from session to session. If you care about keeping track of long term user identity, you can identify users through their public wallet address. You can obtain a user's address through the `getPublicKey()` method. See [Blockchain operations]({{ site.baseurl }}{% post_url /blockchain-interactions/2018-01-07-scene-blockchain-operations %}) for details about what you need to import in order to run this method.

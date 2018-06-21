---
date: 2018-01-05
title: Scriptable scene
description: Learn how to make a scriptable scene and its events
categories:
  - api-reference
type: Document
set: api-reference
set_order: 5
---

We provide a high level API to create scenes that mimic the way in which React.Component handles events. We created a class called `ScriptableScene` that hooks the underlying low-level API to a series of lifecycle events you can use for your scenes.

Each `ScriptableScene` has several *lifecycle methods*, you can override these to run code at particular times in the process. 
* Methods prefixed with `will` are called right before something happens.
* Methods prefixed with `did` are called right after something happens.

Below is an example containing a class and hooks to lifecycle methods.

```tsx
import { ScriptableScene, createElement } from 'metaverse-api'

interface State {
  counter: number
}

interface Props {

}

export default class Scene extends ScriptableScene<Props, State> {
  eventSubscriber: EventSubscriber
  timer: number
  state: State = { counter: 0 }

  /**
   * Called immediately after the scene is mounted. Setting a state here
   * will trigger re-rendering.
   *
   * You must start your processes, timers, pollers only after this method
   * is called
   */
  async sceneDidMount() {
    this.eventSubscriber = new EventSubscriber(this.entityController)

    this.eventSubscriber.on('button_click', evt => {
      this.setState({ counter: this.state.counter + 1 })
    })
  }

  /**
   * The render function should return a tree of entities to be serialized and sent
   * to the engine.
   */
  async render() {
    const barScale = {
      x: 1,
      y: 1 + this.state.counter,
      z: 1
    }

    return (
      <scene>
        <box id="button" color="#ff0000" scale={2}/>
        <box scale={barScale} />
      </scene>
    )
  }

  /**
   * Called to determine whether a change in state or props should trigger a re-render.
   *
   * If this method returns `true`, `ScriptableScene#render`, and `sceneDidUpdate` are called.
   */
  async shouldSceneUpdate(newProps: Props) {
    return true
  }

  /**
   * Called immediately after any change occurs to the state or props, 
   * unless shouldSceneUpdate == false. 
   * Not called for the initial render.
   */
  async sceneDidUpdate() {
    // stub
  }

  /**
   * Called immediately before a scene is destroyed. Perform any necessary cleanup in this
   * method, such as cancelled network requests, or cleaning up any elements created in
   * `sceneDidMount`.
   */
  async sceneWillUnmount() {
    // gracefully tear down created things.
  }

  /**
   * Makes a subscription to remote events, those events occur in the context of the game and are sent thru the wire
   * protocol.
   *
   * @param event name of the remote event to listen
   * @param handler an async
   */
  subscribeTo<T extends IEventNames>(event: T, handler: (data: IEvents[T]) => void | Promise<void>)
}
```

The protocol and internals are explained in the [metaverse-rpc](https://github.com/decentraland/metaverse-rpc)
respository. It's important to understand the way `entityController` gets injected into the class.

1. The class is decorated with an injected API, like this:
  ```tsx
class ScriptableScene extends Script {
  @inject('EntityController')
  entityController: EntityController = null
}
  ```
2. An instance of your class is created using a [transport](https://github.com/decentraland/metaverse-rpc#transports) as an argument.
3. Once the class is created, it requires an instance of `EntityController` to the host (the engine) , this is an asynchronous call.
4. The host responds to that request and a proxy is created and assigned to the property `entityController`.
5. Once all requirements are fulfilled, the scene calls the `sceneDidMount()` method and you can be sure the required apis are loaded in your class instance.

## Client side scenes

Client-side scenes, also known as "Local scenes", are compiled using the `metaverse-compiler` into a WebWorker. The `scene.json` points to the compiled `scene.js` file.

The entry point for the WebWorker is defined in the `build.json`:

```json
[{
  "name": "Compile local scene",
  "kind": "Webpack",
  "file": "./scene.tsx",
  "target": "webworker"
}]
```

> **Note:** The file `scene.tsx` must include an `export default` statement for the class of the scene. The loader of the engine requires this statment to instantiate the scene.

## Server side scenes

For local scenes, all of the components that describe your experience are compiled into one script. When your parcels are rendered in the client, this script runs in the context of a WebWorker, or remotely in a server.  This makes it possible for you to run custom logic inside the player's client, allowing you to create richer experiences in Decentraland.

When you create a multiplayer scene, your `scene.json` will point to a host URL. The `scene.json` script will communicate with the host application through a RPC based protocol using a defined transport.  The CLI bootstraps a server that configures a `WebSocketTransport` and inits a RemoteScene.  For running this scene you should start the WebSocket server first.

You can take a look at the [remote scene sample code](https://github.com/decentraland/sample-scene-server) for more implementation details.
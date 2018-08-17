---
date: 2018-01-05
title: Scriptable scene object
description: Learn how to make a scriptable scene and its events
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 5
---

The `ScriptableScene` object is the base template for all Decentraland scenes. By working with this object, you can ignore the complexities of the low-level API below it. You build your scene by creating a custom class that extends `ScriptableScene`. Your custom class uses the parent's default functions except for the functions you want to override and define explicitly.

The way that `ScriptableScene` works mimics the way in which a [React component](https://reactjs.org/docs/thinking-in-react.html) works. Like when defining a React component, the scene object has:

- **State**: variables for data that is meant to change over time.
- **Props**: porperties used to pass information on from parent to child.
- **Lifecycle methods**: a series of default methods that are executed at different times relative to when the scene is mounted, updated and unmounted.

## Scene state

The scene state is made up of a series of variables that change over time.

You can define the type for the state object by declaring a custom interface. Doing this is optional but we recommend it, especially for complex scenes, as it helps validate inputs and makes debugging easier.

```tsx
export interface IState {
  buttonState: number
  isDoorClosed: boolean
  boxPosition: Vector3Component
}

export default class Scene extends ScriptableScene<any, IState> {
  state = {
    buttonState: 0,
    isDoorClosed: false,
    queboxPosition: { x: 0, y: 0, z: 0 }
  }
  // (...)
}
```

The `ScriptableScene` class optionally takes two arguments: the properties (`any` in this case, as none are used) and the scene state, which in this case must match the type `IState`, described in the custom interface.

You can access the scene's state by writing `this.scene.<variableName>` anywhere in the scene object.

See [scene state]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-04-scene-state %}) for more on how to work with the scene state.

## Props

Properties are used for passing information from parent to child when instancing a class. In a scene object, they should be used for information that is meant to remain unchanged as the user interacts with the scene. Information that is meant to be changed should be part of the scene _state_.

You can pass props as an argument when instancing your custom scene class:

```tsx
export default class Scene extends ScriptableScene<Props, State> {
  // (...)
}
```

If you're using properties in your class, we recommend defining a custom interface for the properties, specifying what properties are expected and their types, this helps validate inputs and makes debugging easier.

You can access the scene's properties by writing `props.<propertyName>` anywhere in the scene object.

## Lifecycle methods

The `ScriptableScene` object has several _lifecycle methods_ that are executed at different times relative to when the scene is loaded, interacted with or abandoned. When you define your custom scene class, you override the default lifecycle methods of the `ScriptableScene` class, this lets you write code that runs at particular times in the process.

As general rules, remember that:

- Methods prefixed with **will** are called right before something happens.
- Methods prefixed with **did** are called right after something happens.

Below is an example containing a class and hooks to lifecycle methods.

```tsx
import { ScriptableScene, createElement } from "decentraland-api"

interface State {
  counter: number
}

interface Props {}

export default class Scene extends ScriptableScene<Props, State> {
  eventSubscriber: EventSubscriber
  timer: number
  state: State = { counter: 0 }

  /**
   * Called immediately after the scene is mounted. You must start your
   * processes, timers, pollers in this method.
   * Setting the value of a state variable here would trigger re-rendering of
   * the scene.
   */
  async sceneDidMount() {
    this.eventSubscriber = new EventSubscriber(this.entityController)

    this.eventSubscriber.on("button_click", evt => {
      this.setState({ counter: this.state.counter + 1 })
    })
  }

  /**
   * This method is called when the scene is initially created and then each
   * time the scene's state or props are updated, unless the `shouldSceneUpdate()`
   * method prevents it.
   * This method should return a tree of entities to be serialized and sent
   * to the engine. This tree should have a single <scene> as the root entity.
   */
  async render() {
    const barScale = {
      x: 1,
      y: 1 + this.state.counter,
      z: 1
    }

    return (
      <scene>
        <box id="button" color="#ff0000" scale={2} />
        <box scale={barScale} />
      </scene>
    )
  }

  /**
   * Called to determine whether a change in state or props should trigger a
   * re-render.
   *
   * If this method returns _true_, `render()`, and `sceneDidUpdate()` are called.
   */
  async shouldSceneUpdate(newProps: Props) {
    return this.state.counter < 20
  }

  /**
   * Called immediately after any change occurs to the state or props,
   * unless `shouldSceneUpdate()` returns _false_.
   * Not called for the initial render.
   */
  async sceneDidUpdate() {
    // stub
  }

  /**
   * Called immediately before a scene is destroyed. Perform any necessary
   * cleanup in this method, such as cancelled network requests, or cleaning up
   * any elements created in
   * `sceneDidMount()`.
   */
  async sceneWillUnmount() {
    // gracefully tear down created things.
  }

  /**
   * Makes a subscription to remote events, those events occur in the context of
   * the game and are sent thru the wire protocol.
   *
   * @param event name of the remote event to listen
   * @param handler an async
   */
  subscribeTo<T extends IEventNames>(
    event: T,
    handler: (data: IEvents[T]) => void | Promise<void>
  )
}
```

These steps summarize when each of the methods above are called:

1.  The user enters your scene, a series of processes are run in the backround by the low level API.
2.  After all requirements are fulfilled, `sceneDidMount()` is called.
3.  `render()` is then called for the first time.
4.  The user then navigates the scene, creating various events by interacting with it. If any of those events leads to a change in the scene's state, then `shouldSceneUpdate()` is called. If this function returns `true`, then:

    1.  `sceneDidUpdate()` is called.
    2.  `render()` is called again.

5.  If the user then leaves the scene, then `sceneWillUnmount()` is called to gracefully clean up the scene before it is unmounted.

## Client side scenes

Client-side scenes, also known as "Local scenes", are compiled using the `decentraland-compiler` into a WebWorker. The _scene.json_ points to the compiled _scene.js_ file.

The entry point for the WebWorker is defined in the _build.json_:

```json
[
  {
    "name": "Compile local scene",
    "kind": "Webpack",
    "file": "./scene.tsx",
    "target": "webworker"
  }
]
```

> **Note:** The file _scene.tsx_ must include an `export default` statement for the class of the scene. The loader of the engine requires this statment to instantiate the scene.

## Server side scenes

For local scenes, all of the components that describe your experience are compiled into one script. When your parcels are rendered in the client, this script runs in the context of a WebWorker, or remotely in a server. This makes it possible for you to run custom logic inside the player's client, allowing you to create richer experiences in Decentraland.

When you create a multiplayer scene, your _scene.json_ will point to a host URL. The _scene.json_ script will communicate with the host application through a RPC based protocol using a defined transport. The CLI bootstraps a server that configures a `WebSocketTransport` and inits a RemoteScene. For running this scene you should start the WebSocket server first.

You can take a look at the [remote scene sample code](https://github.com/decentraland/sample-scene-server) for more implementation details.

## Low level API

The protocol and internals that the `ScriptableScene` object interfaces with in the background are explained in the [decentraland-rpc](https://github.com/decentraland/decentraland-rpc)
respository.

It's important to understand the way `entityController` gets injected into the class.

1.  The `ScriptableScene` class is decorated with the `EntityController` as an injected API, like this:

    ```tsx
    class ScriptableScene extends Script {
      @inject("EntityController") entityController: EntityController = null
    }
    ```

2.  An instance of the scene class you defined is created using a [transport](https://github.com/decentraland/decentraland-rpc#transports) as an argument.
3.  Once the class is created, it requires an instance of `EntityController` from the host (the engine), this is an asynchronous call.
4.  The host responds to that request and a proxy is created and assigned to the property `entityController`.
5.  Once all requirements are fulfilled, the scene object calls the `sceneDidMount()` method. At this point, you can be sure the required APIs are loaded in your class instance.

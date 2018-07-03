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


The `ScriptableScene` object is the base template for all Decentraland scenes. By working with this object, you can ignore the complexities of the low-level API below it. You build your scene by extending `ScriptableScene` with custom properties and methods that define how your scene looks and behaves.

The way that `ScriptableScene` works to create scenes mimics the way in which React.Component handles events.

## Scene state

The scene object can have a series of properties that make up its state. These properties change over time, usually by the occurance of [events](), and they can have an effect on how the scene is rendered.


```tsx
    state = {
        buttonState: 0
        isDoorClosed: false,
        boxPosition: { x: 0, y: 0, z: 0 },
    };
```

You can set the value of a state variable from any method in the scene object. To do so, use `this.setState` as shown below:

```tsx

async buttonPressed()
 {
   this.setState({buttonState : 1 });
  };
```

You can reference the value a state variable from anywhere in the scene object by declaring this.state.<variable name>.

```tsx

async checkDoor()
 {
   return this.state.isDoorClosed;
  };
```

You can also use a state variable to define dynamic content in the scene. The rendering of the scene is updated each time the scene state changes, so the position of the box will always follow the state variable.

{% raw %}
```tsx
async render() {
  return (
    <scene>
          <box position={this.state.boxPosition} ignoreCollisions />
    </scene>
    );
  }
```
{% endraw %}


<!---
The state variables of the scene can be of any type, you can even define your own type. For example


enum simon says



export default class MemoryGame extends ScriptableScene<any, IState>{
properties: a type for both the received properties (none in this case), and a type for the state that this scene will hold


export interface IState {
  difficulty: number; 
  sequence: Panel[];
  guessSequence: Panel[];
  activePanel: Panel | null;
  lockedInput: boolean;
}
-->



## Lifecycle methods

The `ScriptableScene` object has several *lifecycle methods* that are executed on specific moments relative to when the scene is loaded, interacted with or abandoned. The scene object you define can override the default lifecycle methods, which leys you run code at particular times in the process. 

* Methods prefixed with `will` are called right before something happens.
* Methods prefixed with `did` are called right after something happens.

Below is an example containing a class and hooks to lifecycle methods. 


Note that all these methods are asynchronous

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
   * Called immediately after the scene is mounted. You must start your processes, timers, pollers in this method.
   * Setting the value of a state variable here would trigger re-rendering of the scene.
   *
   * 
   */
  async sceneDidMount() {
    this.eventSubscriber = new EventSubscriber(this.entityController)

    this.eventSubscriber.on('button_click', evt => {
      this.setState({ counter: this.state.counter + 1 })
    })
  }

  /**
   * This method is called when the scene is initially created and then each time the scene's state or props are updated, unless the `shouldSceneUpdate` method prevents it.
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
        <box id="button" color="#ff0000" scale={2}/>
        <box scale={barScale} />
      </scene>
    )
  }

  /**
   * Called to determine whether a change in state or props should trigger a re-render.
   *
   * If this method returns `true`, `render`, and `sceneDidUpdate` are called.
   */
  async shouldSceneUpdate(newProps: Props) {
    if (this.state.counter < 20 )
      { return true } else { return false }
  }

  /**
   * Called immediately after any change occurs to the state or props, 
   * unless shouldSceneUpdate returns false. 
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


## Low level API

The protocol and internals that the `ScriptableScene` object interfaces with in the background are explained in the [metaverse-rpc](https://github.com/decentraland/metaverse-rpc)
respository. 

It's important to understand the way `entityController` gets injected into the class.

1. The `ScriptableScene` class is decorated with the `EntityController` as an injected API, like this:
  ```tsx
class ScriptableScene extends Script {
  @inject('EntityController')
  entityController: EntityController = null
}
  ```
2. An instance of the scene class you defined is created using a [transport](https://github.com/decentraland/metaverse-rpc#transports) as an argument.
3. Once the class is created, it requires an instance of `EntityController` to the host (the engine) , this is an asynchronous call.
4. The host responds to that request and a proxy is created and assigned to the property `entityController`.
5. Once all requirements are fulfilled, the scene object calls the `sceneDidMount()` method. At this point, you can be sure the required APIs are loaded in your class instance.
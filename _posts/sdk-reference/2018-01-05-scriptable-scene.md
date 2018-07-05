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

* State: variables for data that is meant to change over time.
* Props: porperties used to pass information on from parent to child.
* Lifecycle methods: a series of default methods that are executed at different times relative to when the scene is mounted, updated and unmounted.



## Scene state

The scene state is made up of a series of variables that change over time. State variables are usually changed by the occurance of [events]({{ site.baseurl }}{% post_url /documentation/building-scenes/2018-01-03-event-handling %}) that are triggered by the user, and they can have an effect on how the scene is rendered.


```tsx
    state = {
        buttonState: 0
        isDoorClosed: false,
        boxPosition: { x: 0, y: 0, z: 0 },
    };
```
Each state variable must be given an intial value for when the scene is first rendered. You can define the type for the state object by declaring a custom interface. Doing this is optional but we recommend it, especially for complex scenes, as it helps validate inputs and makes debugging easier.

```tsx

export interface myState {
    buttonState: number;
    isDoorClosed: boolean;
    boxPosition: vector3
}

export default class Scene extends ScriptableScene<any, myState> {
 
    state = {
        buttonState: 0
        isDoorClosed: false,
        queboxPosition: { x: 0, y: 0, z: 0 },
    };

(...)
```

>Note: The `ScriptableScene` class optionally takes two arguments: the properties (`any` in this case, as none are used) and the scene state, which in this case must match the type `myState`, described in the custom interface.

The variables you choose to make up your scene's state should be the minimal possible set that represents the scene, you shouldn't add redundant information. It's generally better to compute certain values on demand than to hold an additional variable. For example, if your scene has a pond with a set of fish that can be fished out of the water and the scene's state has an array to represent the remaining fish, you don't need an additional variable to keep track of the number of fish remaining in the pond, you can obtain this information by taking the length of the fish array that already exists.

To determine if you should include a piece of information as part of the state, ask yourself:

* Does this information change over time? If it doesn't, it probably shouldn't be part of the state.
* Is this information passed in when instantiating the scene class, if so it probably should be part of `Props` rather than of the state.
* Can you compute this information based on other state variables or the props? If so, don't include it.


### Set the state

You can set the value of a state variable from any method in the scene object. To do so, use `this.setState` as shown below:

```tsx

async buttonPressed()
 {
   this.setState({buttonState : 1 });
  };
```

Unless intentionally set, each time the scene's state is updated, the `render()` function is called to render the scene using the new state.

If the state holds multiple variables and your `setState` statement only affects one of them, it will leave all other variables untouched.

It's important that each time you change the state you do it through the `setState` function, NEVER do it by directly setting a value. Otherwise this will cause problems with the lifecycle of the scene.

```tsx
// Wrong
this.state.buttonState = 1;

// Correct
this.setState({buttonState: 1});
```

### Reference the state

You can reference the value a state variable from anywhere in the scene object by writing `this.state.<variable name>`.

```tsx
async checkDoor()
 {
   return this.state.isDoorClosed;
  };
```

In the example below, the `render()` method draws a dynamic scene where the position of an entity is based on a variable in the status. As soon as the value of that variable changes, the rendered scene changes as well.

{% raw %}
```tsx
async render() {
  return (
    <scene>
          <box position={this.state.boxPosition} />
    </scene>
    );
  }
```
{% endraw %}

#### Reference the state from a child component

Unlinke React, where all components can have their own state, only your custom scene class is allowed to have a state. In react terms, all child components of your scene are [controlled components](https://reactjs.org/docs/forms.html#controlled-components), this means that they can have properties but no state of their own, and they are controlled by their parent component. 

For example, you could declare a type of entity called `elevator`, and embed a series of child entities in it and define its own functions to open and close the doors and handle the buttons. If you're planning to have many elevators in your scene, that would make the code for your scene a lot more efficient and cleaner. The downside is that any functions in this child entity would no longer have easy access to the scene's state. From the `elevator` entity, it would not be valid to use the expression `this.state`, as `this` no longer refers to your custom scene class, it refers to the current instance of the `elevator` entity. In order to access the information stored in the scene's state you can:

* Copy the values of the scene state in the properties of the child component. Functions in the elevator could then access this data via `props.<propertyName>`. If there are multiple levels of inheritance in your scene, for example if the elevator's buttons are custom entities with their own functions, the state data can be passed down from the properties of the parent to the properties of the children recurrently as many times as necessary, but by doing this the code can get difficult to read.

* Import a library like [Redux](https://redux.js.org/) to create a univesal store that can hold the state data and that can be consistently referenced from anywhere. If your scene has multiple levels of inheritance, this might be ideal.




## Props

Properties are used for passing information from parent to child when instancing a class. In a scene object, they should be used for information that is meant to remain unchanged as the user interacts with the scene. Information that is meant to be changed should be part of the scene *state*.

You can pass props as an argument when instancing your custom scene class:

```tsx
export default class Scene extends ScriptableScene<Props, State> {
{

(...)
```

If you're using properties in your class, we recommend defining a custom interface for the properties, specifying what properties are expected and their types, this helps validate inputs and makes debugging easier.

You can access the scene's properties by writing `props.<propertyName>` anywhere in the scnee object.


## Lifecycle methods

The `ScriptableScene` object has several *lifecycle methods* that are executed at different times relative to when the scene is loaded, interacted with or abandoned. When you define your custom scene class, you override the default lifecycle methods of the `ScriptableScene` class, this lets you write code that runs at particular times in the process. 

As general rules, remember that:

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

These steps summarize when each of the methods above are called:

1. The user enters your scene, a series of processes are run in the backround by the low level API.
2. After all requirements are fulfilled, `sceneDidMount()` is called.
2. `render()` is then called for the first time.
3. The user then navigates the scene, creating various events by interacting with it. If any of those events leads to a change in the scene's state, then `shouldSceneUpdate()` is called. If this function returns `true`, then:

    1. `sceneDidUpdate()` is called.
    2. `render()` is called again.
5. If the user then leaves the scene, then `sceneWillUnmount()` is called to gracefully clean up the scene before it is unmounted.


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
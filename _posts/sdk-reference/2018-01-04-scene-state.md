---
date: 2018-01-05
title: Scene state
description: Learn how the scene's state variables are updated and retrieved.
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 4
---

The scene state is made up of a series of variables that change over time. The state changes by the occurance of [events]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-03-event-handling %}) in the scene. When the state changes, this retriggers the rendering of the scene, using the new values of the state.

![](/images/media/events_state_diagram.jpeg)

If you're familiar with the [React](https://reactjs.org/docs/thinking-in-react.html) framework, you'll find that the scene handles its states in a way that's very similar to how components in React do this.

```tsx
state = {
  buttonState: 0,
  isDoorClosed: false,
  boxPosition: { x: 0, y: 0, z: 0 }
}
```

The state should contain **only** data, and no logic or methods. We don't recommend assigning instances of objects that have methods of their own to variables in the state. All of the scene's logic should be carried out in your custom class that extends the [scriptable scene]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}) class.

Each state variable must be given an intial value for when the scene is first rendered.

The variables you choose to make up your scene's state should be the minimal possible set that represents the scene, you shouldn't add redundant information. To determine if you should include a piece of information as part of the state, ask yourself:

- Does this information change over time? If it doesn't, it should probably be declared as a constant instead of as the state.
- Is this information passed in when instantiating the scriptable scene class? If so, it probably should be part of `Props` rather than of the state.
- Can you easily compute this information based on other state variables or the props? If so, you should consider computing it each time instead of storing it in the state. Keep in mind that this has an impact on the scene performance, so in some cases it might be better to store more information in the scene state.

## Local and remote scenes

**Local scenes** store the scene state locally as part of the scriptable scene object. For example, when you create scenes with the Decentraland CLI, the default scenes for the options _Basic_ and _Interactive_ are both local scenes.

{% raw %}

```tsx
export default class Scene extends ScriptableScene {
  state = {
    buttonState: 0,
    isDoorClosed: false,
    queboxPosition: { x: 0, y: 0, z: 0 }
  }

  // (...)
}
```

{% endraw %}

Local scenes run entirely in the user's local client. When the value of a variable in the scene state changes, it only changes the local representation in the client, and isn't propagated to other users of the scene. That means each user might be having a different perception of what the scene looks like, even though the users might see each other moving around.

For example, if a user opens a door, other users won't see this door open, because users can only affect their own local representation of the scene state.

**Remote scenes** store the scene state in a remote server. The local client retrieves information from this server to render the scene lcoally. When the value of a variable in the scene state is changed, this change is pushed to the remote server to update its representation of the scene state. All users of the scene will then render their scenes locally based on the scene state that's stored in the remote server, so all users will see the change.

Referring back to the previous example: in a remote scene, if a user opens a door, all other users should see this door open as well.

## Define an interface for the scene state

You can define the type for the state object by declaring a custom interface. Doing this is optional but we recommend it, especially for complex scenes, as it helps validate inputs and makes debugging easier.

The example bleow defines a custom interface for the scene state and passes it to the scriptable scene object.

{% raw %}

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

{% endraw %}

The `ScriptableScene` class optionally takes two arguments: the properties (`any` in this case, as none are used) and the scene state, which in this case must match the type `IState`, described in the custom interface.

## Get the state

You can reference the value a state variable from anywhere in the scene object.

#### In a local scene

In a _local_ scene the state is stored in the scene object itself, so you fetch it by writing `this.state.<variable name>`.

{% raw %}

```tsx
async checkDoor(){
  return this.state.isDoorClosed
}
```

{% endraw %}

In the example below, the `render()` method draws a dynamic scene where the position of an entity is based on a variable in the state. As soon as the value of that variable changes, the rendered scene changes as well.

{% raw %}

```tsx
async render() {
  return (
    <scene>
      <box position={this.state.boxPosition} />
    </scene>
  )
}
```

{% endraw %}

#### In a remote scene

In a _remote_ scene the state is stored in a remote server. This is handled by a file called _State.ts_. You get the state by calling the `getState()` function, that's defined in _State.ts_.

{% raw %}

```tsx
async checkDoor(){
  return getState().isDoorClosed
}
```

{% endraw %}

## Set the state

You can set the value of a state variable by using `setState()`.

`setState()` only affects the variables that are explicitly called out by it. If there are other variables in the scene state that aren't named, these are left untouched.

When dealing with arrays in the scene state, you can't update a single element in the array at a time. You must set a new value for the variable consiting of an entire new array, including any elements that haven't changed.

Each time the scene's state is updated, the `render()` function is called to render the scene using the new state.

> Note: To prevent the scene from being rendered every time, you can use the [`shouldSceneUpdate()` function]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}) so that it only runs the `Render()` function conditionally based on some rule.

#### In a local scene

In a _local_ scene the state is stored in the scriptable scene object, so you set it with `this.setState()` as shown below:

{% raw %}

```tsx
async buttonPressed(){
  this.setState({
    buttonState : 1,
    isDoorClosed: false
    })
}
```

{% endraw %}

#### In a remote scene

In a _remote_ scene the state is stored in a remote server. This is handled by a file called _State.ts_. You set the state by calling the `setState()` function, that's defined in _State.ts_.

{% raw %}

```tsx
async buttonPressed(){
  setState({
    buttonState : 1,
    isDoorClosed: false
    })
}
```

{% endraw %}

## Force update

If you always change the scene state through `setState()`, the rendering of your scene should always be in sync with the scene state. However, for exceptional cases you might need to refresh the rendering of the scene manually. To do this, call the `forceUdate()` method.

```
this.forceUpdate()
```

## Practices you must avoid

#### Always use setState to change state values

It's important that each time you change the state you do it through the `setState` function, NEVER do it by directly setting a value. Otherwise this will cause problems with the lifecycle of the scene.

{% raw %}

```tsx
// Wrong
this.state.buttonState = 1

// Correct for local scenes
this.setState({ buttonState: 1 })

// Correct for remote scenes
setState({ buttonState: 1 })
```

{% endraw %}

#### Avoid making multiple calls to setSate

If you need to set the values of several variables from the scene state at the same time, do them all inline in a single call to `setState()`.

Each time you call `setState()`, the `render()` function is triggered too. So by making several calls to `setState()` you're also running several unnecessary renders of the scene. Each of these renders is asynchronous, so potentially the last render to be finished could be from an older state, leaving your rendered scene outdated.

{% raw %}

```tsx
// Wrong
async buttonPressed(){
  setState({ buttonState : 1 })
  setState({ isDoorClosed: false })
}

// Correct
async buttonPressed(){
  setState({
    buttonState : 1,
    isDoorClosed: false
    })
}
```

{% endraw %}

## Reference the state from a child object

Unlinke React, where all components can have their own state, only your custom scene class is allowed to have a state. In react terms, all child components of your scene are [controlled components](https://reactjs.org/docs/forms.html#controlled-components), this means that they can have properties but no state of their own, and they are controlled by their parent component.

For example, you could declare a type of entity called `elevator`, and embed a series of child entities in it and define its own functions to open and close the doors and handle how the buttons are rendered. If you're planning to have many elevators in your scene, that would make the code for your scene a lot more efficient and cleaner. The downside is that any functions in this child entity would no longer have easy access to the scene's state. From the `elevator` entity, it would not be valid to use the expression `this.state`, as `this` no longer refers to the instance of your custom scene class, it refers to an instance of the `elevator` entity. In order to access the information stored in the scene's state you can:

- Copy the values of the scene state in the properties of the child component. Functions in the elevator could then access this data via `props.<propertyName>`. If there are multiple levels of inheritance in your scene, for example if the elevator's buttons are custom entities with their own functions, the state data can be passed down from the properties of the parent to the properties of the children recurrently as many times as necessary, but by doing this the code can get difficult to read.

- Import a library like [Redux](https://redux.js.org/) to create a univesal store that can hold the state data and that can be consistently referenced from anywhere. If your scene has multiple levels of inheritance, this might be ideal.

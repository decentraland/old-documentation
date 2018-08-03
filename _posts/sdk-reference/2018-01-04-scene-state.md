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

Each state variable must be given an intial value for when the scene is first rendered. You can define the type for the state object by declaring a custom interface. Doing this is optional but we recommend it, especially for complex scenes, as it helps validate inputs and makes debugging easier.

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

The variables you choose to make up your scene's state should be the minimal possible set that represents the scene, you shouldn't add redundant information. To determine if you should include a piece of information as part of the state, ask yourself:

- Does this information change over time? If it doesn't, it probably shouldn't be part of the state.
- Is this information passed in when instantiating the scene class, if so it probably should be part of `Props` rather than of the state.
- Can you compute this information based on other state variables or the props? If so, don't include it.

## Set the state

You can set the value of a state variable from any method in the scene object. To do so, use `this.setState` as shown below:

```tsx
async buttonPressed(){
  this.setState({buttonState : 1 })
}
```

Each time the scene's state is updated, the `render()` function is called to render the scene using the new state.

> Note: To prevent the scene from being rendered every time, you can use the [`shouldSceneUpdate()` function]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}) so that it only runs the `Render()` function conditionally based on some rule.

If the state holds multiple variables and your `setState()` statement only affects one of them, it will leave all other variables untouched.

It's important that each time you change the state you do it through the `setState` function, NEVER do it by directly setting a value. Otherwise this will cause problems with the lifecycle of the scene.

```tsx
// Wrong
this.state.buttonState = 1

// Correct
this.setState({ buttonState: 1 })
```

When dealing with arrays in the scene state, you can't update a single element in the array at a time. You must set a new value for the variable consiting of an entire new array, including any elements that haven't changed.

## Force update

If you always change the scene state through `setState()`, the rendering of your scene should always be in sync with the scene state. However, for exceptional cases you might need to refresh the rendering of the scene manually. To do this, call the `forceUdate()` method.

```
this.forceUpdate()
```

## Reference the state


You can reference the value a state variable from anywhere in the scene object by writing `this.state.<variable name>`.

```tsx
async checkDoor(){
  return this.state.isDoorClosed
}
```

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

To debug a scene, you can use `console.log(this.state)` to log the entire scene state at key moments in the scene's execution. You can also use `console.log` to log a specific variable from the state.

{% raw %}

```tsx
async sceneDidMount() {  
  this.subscribeTo("pointerDown", e => {
    console.log(this.state)
  })
  // (...)
}
```

{% endraw %}

## Reference the state from a child component

Unlinke React, where all components can have their own state, only your custom scene class is allowed to have a state. In react terms, all child components of your scene are [controlled components](https://reactjs.org/docs/forms.html#controlled-components), this means that they can have properties but no state of their own, and they are controlled by their parent component.

For example, you could declare a type of entity called `elevator`, and embed a series of child entities in it and define its own functions to open and close the doors and handle the buttons. If you're planning to have many elevators in your scene, that would make the code for your scene a lot more efficient and cleaner. The downside is that any functions in this child entity would no longer have easy access to the scene's state. From the `elevator` entity, it would not be valid to use the expression `this.state`, as `this` no longer refers to your custom scene class, it refers to the current instance of the `elevator` entity. In order to access the information stored in the scene's state you can:

- Copy the values of the scene state in the properties of the child component. Functions in the elevator could then access this data via `props.<propertyName>`. If there are multiple levels of inheritance in your scene, for example if the elevator's buttons are custom entities with their own functions, the state data can be passed down from the properties of the parent to the properties of the children recurrently as many times as necessary, but by doing this the code can get difficult to read.

- Import a library like [Redux](https://redux.js.org/) to create a univesal store that can hold the state data and that can be consistently referenced from anywhere. If your scene has multiple levels of inheritance, this might be ideal.

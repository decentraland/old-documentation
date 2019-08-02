---
date: 2018-02-14
title: Click events
description: Learn how to handle user clicks in your scene.
categories:
  - development-guide
redirect_from:
  - /sdk-reference/event-handling/
  - /development-guide/event-handling/
type: Document
set: development-guide
set_order: 14
---

Clicks can be done either with a mouse, a touch screen, a VR controller or some other device, these all generate the same type of event.

> Note: Clicks can be made from a maximum distance of 10 meters away from the entity.

<!--
## OnPointerDown

The easiest way to handle click events is to add an `OnPointerDown` component to the entity you want to click.

You declare what to do in the event of a mouse down event by writing a lambda function in the `OnPointerDown` component.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown(e => {
    log("myEntity clicked")
  })
)
```

> Tip: To keep your code easier to read, the lambda function in the `OnPointerDown` can consist of just a call to a separate function that contains all of the logic.

The _pointer down event_ object is always implicitly passed as a parameter of the function in the `OnPointerDown`. This event object contains various properties that might be useful for the function. See [Properties of button events](#properties-of-button-events) for more details.


```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown(e => {
    log("Click distance: " + e.length)
  })
)
```

> Note: Entities that don't have a shape component, or that have their shape's `visible` field set to _false_ can't be clicked.


## Generic button down and button up event

The _button down_ and _button up_ events are fired whenever the user presses or releases an input controller.

These events are triggered every time that the buttons are pressed or released, regardless of where the pointer is pointing at. It doesn't make a difference if the click is also being handled by an entity's `OnClick` component.

Use the `subscribe()` method of the Input object to initiate a listener that's subscribed to one of the click events. Whenever the event it caught, it executes a lambda function.

```ts
// Instance the input object
const input = Input.instance

// button down event
input.subscribe("BUTTON_DOWN", e => {
  log("button A Down", e)
})

// button up event
input.subscribe("BUTTON_UP", e => {
  log("button A Up", e)
})
```

Both the`BUTTON_DOWN` and the `BUTTON_UP` events contain various properties that might be useful for the function. See [Properties of button events](#properties-of-button-events) for more details.

> Note: This code only needs to be executed once for the `subscribe()` method to keep polling for the event. Don't add this into a system's `update()` function, as that would register a new listener on every frame.

## Properties of button events

All _button down_ and _button up_ event objects contain the following parameters:

- `origin`: Origin point of the ray, as a _Vector3_
- `direction`: Direction vector of the ray, as a normalized _Vector3_
- `length`: The length of the ray, as a _number_
- `pointerId`: ID of the pointer that triggered the event (_PRIMARY_ or _SECONDARY_)
- `hit`: _(Optional)_ Object describing the entity that was clicked on. If the click didn't hit any specific entity, this field isn't present. The `hit` object contains the following parameters:
 
    - `length`: Length of the ray in meters, as a _number_
    - `hitPoint`: The intersection point between the ray and the entity's mesh, as a _Vector3_
    - `meshName`: The name of the mesh, if applicable, as a _string_
    - `normal`: The normal of the hit, as a _Vector3_
    - `worldNormal`: The normal of the hit, in world space, as a _Vector3_
    - `entityId`: The ID of the entity, if applicable, as a _string_

## Pointer state

Instead of creating a listener to catch events from the buttons changing state, you can check for the button's current state using the _Input_ object.

```ts
let buttonState = input.state[Pointer.PRIMARY].BUTTON_DOWN
```

If the _A_ button is down, `BUTTON_DOWN` has the value _true_, if the _A_ button is up, it has the value _false_.

You can implement this in a system's `update()` function to check the button state regularly.

```ts
// Instance the input object
const input = Input.instance

class ButtonChecker {
  update() {
    if (input.state[Pointer.PRIMARY].BUTTON_DOWN) {
      log("button A down")
    } else {
      log("button A up")
    }
  }
}

engine.addSystem(new ButtonChecker())
```


## Differentiate meshes inside a model

Often, _.glTF_ 3D models are made up of multiple meshes, that each have an individual internal name. _button down_ and _button up_ events include the information of what specific mesh was clicked, so you can use this information to trigger different click behaviors in each case.

To see how the meshes inside the model are named, you must open the 3D model with an editing tool, like [Blender](https://www.blender.org/) for example.

<img src="/images/media/mesh-names.png" alt="Mesh internal names in an editor" width="250"/>

> Tip: You can also learn the name of the clicked mesh by logging it and reading it off console.


You access the `meshName` property as part of the `hit` object, that's returned by the click event.

```ts
const input = Input.instance

input.subscribe("BUTTON_DOWN", e => {
  log("button A Down", e.hit.meshName)

  if (e.hit.meshName === "firePlace"){
    // light fire
  }
})
```
-->

## OnClick

Track full click events by using the `OnClick` component. A click consists of a _mouse down_ event followed by a _mouse up_ event, both performed while pointing at the same entity. 

> Note: Clicks are mostly used on UI elements. For most in-world use cases, it's preferable to use an `OnPointerDown` component instead.

You declare what to do in the event of a click by writing a lambda function in the `OnClick` component.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnClick(e => {
    log("myEntity clicked")
  })
)
```

> Tip: To keep your code easier to read, the lambda function in the `OnCLick` can consist of just a call to a separate function that contains all of the logic.

The `OnClick` component passes less event information than the `OnPointerDown` component. It only contains the following parameter, which can be accessed by your function:

- `pointerId`: ID of the pointer that triggered the event (_PRIMARY_ or _SECONDARY_)

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnClick(e => {
    log("pointer Id" + e.pointerId)
  })
)
```

> Note: Entities that don't have a shape component, or that have their shape's `visible` field set to _false_ can't be clicked.





<!--

## Custom events

Define an event manager

```ts
export namespace EventManager {

  const subscriptions: Record<string, Array<(params?: any) => void> > = {}

  export function on(evt: string, callback: (params?: any) => void) {
    if (!subscriptions[evt]){
      subscriptions[evt] = []
    }
    subscriptions[evt].push(callback)
  }

  export function emit(evt: string, params?: any) {
    if (subscriptions[evt]){
      subscriptions[evt].forEach(callback => callback(params))
    }
  }
}
```

Import the event manager

```ts
import { EventManager } from 'ts/EventManager'
```

Use it:

```ts
EventManager.emit("test", {test: 5})

EventManager.on("test", function(e) {
  log("test " + e.test)
 })

 ```

-->

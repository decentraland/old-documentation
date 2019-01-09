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

## OnClick

The easiest way to handle click events is to add an `OnClick` component to the entity you want to click.

You declare what to do in the event of a click by writing a lambda function in the `OnClick` component.

```tsx
const myEntity = new Entity()
myEntity.add(new BoxShape())

myEntity.add(
  new OnClick(e => {
    log("myEntity clicked")
  })
)
```

> Tip: To keep your code easier to read, the lambda function in the `OnCLick` can consist of just a call to a separate function that contains all of the logic.

The _click event_ object is always implicitly passed as a parameter of the function in the `OnClick`. This event object contains the following parameter that can be accessed by your function:

- `pointerId`: ID of the pointer that triggered the event (_PRIMARY_ or _SECONDARY_)

```tsx
const myEntity = new Entity()
myEntity.add(new BoxShape())

myEntity.add(
  new OnClick(e => {
    log("pointer Id" + e.pointerId)
  })
)
```

## Button down and button up event

The _button down_ and _button up_ events are fired whenever the user presses or releases an input controller.

These events are triggered every time that the buttons are pressed or released, regardless of where the pointer is pointing at. It doesn't make a difference if the click is also being handled by an entity's `OnClick` component.

Use the `subscribe()` method of the Input object to initiate a listener that's subscribed to one of the click events. Whenever the event it caught, it executes a lambda function.

```tsx
// Instance the input object
const input = Input.instance

// button down event
input.subscribe("BUTTON_A_DOWN", e => {
  log("button A Down", e)
})

// button up event
input.subscribe("BUTTON_A_UP", e => {
  log("button A Up", e)
})
```

> Note: This code only needs to be executed once for the `subscribe()` method to keep polling for the event. Don't add this into a system's `update()` function, as that would register a new listener on every frame.

All click event objects contain the following parameters:

- `from`: Origin point of the ray, as a _Vector3_
- `direction`: Direction vector of the ray, as a normalized _Vector3_
- `length`: The length of the ray, as a _number_
- `pointerId`: ID of the pointer that triggered the event (_PRIMARY_ or _SECONDARY_)

## Pointer state

Instead of creating a listener to catch events from the buttons changing state, you can check for the button's current state using the _Input_ object.

```tsx
let buttonState = input.state[Pointer.PRIMARY].BUTTON_A_DOWN
```

If the _A_ button is down, `BUTTON_A_DOWN` has the value _true_, if the _A_ button is up, it has the value _false_.

You can implement this in a system's `update()` function to check the button state regularly.

```tsx
// Instance the input object
const input = Input.instance

class ButtonChecker {
  update() {
    if (input.state[Pointer.PRIMARY].BUTTON_A_DOWN) {
      log("button A down")
    } else {
      log("button A up")
    }
  }
}

engine.addSystem(new ButtonChecker())
```

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

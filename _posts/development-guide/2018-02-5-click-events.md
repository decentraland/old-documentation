---
date: 2018-02-5
title: Click events
description: Learn how to handle user clicks in your scene.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 5
---

Clicks can be done either with a mouse, a touch screen, a VR controller or some other device, these all generate the same type of event.

> Note: Clicks can be made from a maximum distance of 10 meters away from the entity.

#### onClick

The easiest way to handle click events is to add an `onClick` component to the entity you want to click.

You can declare what to do in the event of a click by writing a lambda in the `onClick` itself, or you can call a separate function to keep your code easier to read.

```tsx
const myEntity = new Entity()
myEntity.set(new BoxShape())

myEntity.set(
  new OnClick(_ => {
    log("myEntity clicked")
  })
)
```

The click event object is passed as a parameter of the function you call in the `onClick`. This event object contains the following parameter that can be accessed by your function:

- `pointerId`: ID of the pointer that triggered the event (_PRIMARY_ or _SECONDARY_)

```tsx
const myEntity = new Entity()
myEntity.set(new BoxShape())

myEntity.set(
  new OnClick(e => {
    log("pointer Id" + e.pointerId)
  })
)
```

## Pointer down and pointer up event

The pointer down and pointer up events are fired whenever the user presses or releases an input controller. It doesn't matter if the pointer was pointing at an entity or not.

The PointerEvent object contains the following parameters:

- `from`: Origin point of the ray, as a _Vector3_
- `direction`: Direction vector of the ray, as a normalized _Vector3_
- `length`: The length of the ray, as a _number_
- `pointerId`: ID of the pointer that triggered the event (_PRIMARY_ or _SECONDARY_)

```tsx
// Instance the input object
const input = Input.instance

// button down event
input.subscribe("BUTTON_A_DOWN", e => {
  log("pointerUp works", e)
})

// button up event
input.subscribe("BUTTON_A_UP", e => {
  log("pointerDown works", e)
})
```

The example above uses the `subscribe` to initiate a listener that checks for all click events. When the user clicks anywhere in the scene, it logs the event to console.

## Pointer state

Instead of listening for events, you can check for the pointer's current state. This can be implemented in an `update()` function to check this state regularly.

```tsx
// Instance the input object
const input = Input.instance

class ButtonChecker {
  update() {
    if (input.state[Pointer.PRIMARY].BUTTON_A_DOWN) {
      log("button down")
    }
  }
}
```

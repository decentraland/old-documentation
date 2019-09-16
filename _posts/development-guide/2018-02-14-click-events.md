---
date: 2018-02-14
title: Button events
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


## OnPointerDown

The easiest way to handle click events is to add an `OnPointerDown` component to the entity you want to click.

You declare what to do in the event of a mouse down event by writing a lambda function in the `OnPointerDown` component.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown(e => {
    log("myEntity clicked", e)
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

## OnPointerUp

Similarly, the `OnPointerUp` component can be added to an entity to track when a player releases the mouse button while pointing at the entity.

You declare what to do in the event of a mouse up event by writing a lambda function in the `OnPointerUp` component.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerUp(e => {
    log("pointer up", e)
  })
)
```


## Button down and button up event

The _button down_ and _button up_ events are fired whenever the user presses or releases an input controller button.

> Tip: On a computer, that refers to the _left mouse button_ (or trackpad), the _E_, and the _F_ keys.

These events are triggered every time that the buttons are pressed or released, regardless of where the player's pointer is pointing at, as long as the player is standing inside the scene's parcels.

<!--
 It doesn't make a difference if the click is also being handled by an entity's `OnClick` component.
 -->

Instance an `Input` object and use its `subscribe()` method to initiate a listener that's subscribed to one of the button events. Whenever the event is caught, it executes a provided function.

The `subscribe()` method takes four arguments:

- `eventName`: The type of action, this can be either `"BUTTON_DOWN"` or `"BUTTON_UP"`
- `buttonId`: Which button to listen for. This can either be `ActionButton.POINTER`, `ActionButton.PRIMARY`, or `ActionButton.SECONDARY` 
- `useRaycast`: Boolean to define if raycasting will be used. If `false`, the button event will not contain information about any `hit` objects that align with the pointer at the time of the event.
- `fn`: The function to execute when the event occurs. 

```ts
// Instance the input object
const input = Input.instance

// button down event
input.subscribe("BUTTON_DOWN", ActionButton.POINTER, false, e => {
  log("pointer Down", e)
})

// button up event
input.subscribe("BUTTON_UP", ActionButton.POINTER, false, e => {
  log("pointer Up", e)
})
```

The example above logs messages and the contents of the event object every time the pointer button is pushed down or released.

> Note: This code only needs to be executed once for the `subscribe()` method to keep polling for the event. Don't add this into a system's `update()` function, as that would register a new listener on every frame.

The event objects of both the `BUTTON_DOWN` and the `BUTTON_UP` contain various useful properties. See [Properties of button events](#properties-of-button-events) for more details.


#### Detect hit entities

If the `useRaycast` field (the third argument) in the `subscribe()` function is true, and the player's pointer is pointing at an entity, the event object includes a nested `hit` object. The `hit` object includes information about the collision and the entity that was hit. 

The ray of a global button event only detects entities that have a collider mesh. Primitive shapes have a collider mesh on by default, 3D models need to have one built into them.

> Tip: See [Colliders]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-12-colliders %}) for details on how to add collider meshes to a 3D model.

```ts
input.subscribe("BUTTON_DOWN", ActionButton.POINTER, true, e => {
  if ( e.hit){
	let hitEntity = engine.entities[e.hit.entityId]
	hitEntity.addComponent(greenMaterial)
  } 
})
```

The example above checks if any entities were hit, and if so it fetches the entity and applies a material component to it.

> Tip: The event data returns an `entityId`. If you want to reference the actual entity by that ID and affect it in some way, call if via `engine.entities[e.hit.entityId]`.


## Properties of button events

All _button down_ and _button up_ event objects, as well as events from `OnPointerDown` and `OnPointerUp` components, contain the following parameters:

- `origin`: Origin point of the ray, as a _Vector3_
- `direction`: Direction vector of the ray, as a normalized _Vector3_ that points in the same direction.
- `pointerId`: ID of the pointer that triggered the event (_POINTER_, _PRIMARY_ or _SECONDARY_)
- `hit`: _(Optional)_ Object describing the entity that was clicked on. If the click didn't hit any specific entity, this field isn't present. The `hit` object contains the following parameters:
 
    - `length`: Length of the ray in meters, as a _number_
    - `hitPoint`: The intersection point between the ray and the entity's mesh, as a _Vector3_
    - `meshName`: The name of the mesh, if applicable, as a _string_
    - `worldNormal`: The normal of the hit, in world space, as a _Vector3_
    - `entityId`: The ID of the entity, if applicable, as a _string_


## Button state

You can check for the button's current state (up or down) using the _Input_ object.

```ts
let buttonState = input.isButtonPressed(ActionButton.POINTER)
```

If the pointer button is currently being held down, the statement above returns the value _true_, otherwise it returns _false_.

You can check for the states of the `PRIMARY` and `SECONDARY` buttons in the same way, providing `ActionButton.PRIMARY` or `ActionButton.SECONDARY` as arguments for the `isButtonPressed()` function.

You can implement this in a system's `update()` function to check the button state regularly.

```ts
// Instance the input object
const input = Input.instance

class ButtonChecker {
  update() {
    if (input.isButtonPressed(ActionButton.POINTER)) {
      log("pointer button down")
    } else {
      log("pointer button up")
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

In the example below we have a house model that includes a mesh named `firePlace`. We want to turn on the fireplace only when that mesh is clicked.

```ts
houseEntity.addComponent(
  new OnPointerDown(e => {
    log("button A Down", e.hit.meshName)
	if (e.hit.meshName === "firePlace"){
		// light fire
	}
  })
)
```


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

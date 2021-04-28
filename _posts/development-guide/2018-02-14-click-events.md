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
---

Decentraland accepts events from pointer clicks, a primary button and a secondary button.

Clicks can be done either with a mouse, a touch screen, a VR controller or some other device, these all generate the same type of event.

The primary and secondary buttons map respectively to the E and F key on a keyboard.

> Note: Entities that don't have a shape component, or that have their shape's `visible` field set to _false_ don't respond to pointer events.

## Pointer event components

#### OnPointerDown

The best way to handle pointer and button down events is to add an `OnPointerDown` component to an entity.

The component requires that you pass it a function as a main argument. This function declares what to do in the event of a button down event while the player points at the entity.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown((e) => {
    log("myEntity was clicked", e)
  })
)
```

> Tip: To keep your code easier to read, the function in the `OnPointerDown` can consist of just a call to a separate function that contains all of the logic.

The `OnPointerDown` component has a second optional parameter, this parameter is an object that can include multiple properties about the event. These properties are explained in greater detail in the next few sub-sections.

- `button`: Which key to listen for: the left mouse click, _E_, or _F_.
- `hoverText`: Hint text to display on the UI when pointing at the entity.
- `distance`: Maximum click distance.

#### OnPointerUp

Add an `OnPointerUp` component to track when a player releases the mouse button, the primary or the secondary button while pointing at the entity.

Like the `OnPointerDown`, the `OnPointerUp` component requires a _callback function_ that declares what to do in the event of a button up event while pointing at the entity.

This component also takes a second argument that supports the same additional fields as teh `OnPointerDown` component.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerUp((e) => {
    log("pointer up", e)
  })
)
```

#### Specific button events

The `OnPointerDown` and `OnPointerUp` components can respond to three different buttons: `POINTER`, `PRIMARY`, or `SECONDARY`. On a PC, these map to the left mouse click, _E_ and _F_.

You can configure the components by setting the `button` field in the second argument of the component initializer. The following values are supported:

- `ActionButton.POINTER`
- `ActionButton.PRIMARY`
- `ActionButton.SECONDARY`
- `ActionButton.ANY` _(default)_

`ActionButton.ANY` detects events from all three buttons. If none of them is specified, then `ANY` is used.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown(
    (e) => {
      log("myEntity was clicked", e)
    },
    { button: ActionButton.POINTER }
  )
)
```

#### Hint messages

When a player hovers the cursor over an item with an `OnPointerDown` or `OnPointerUp` component, the cursor changes shape to hint to the player that the entity is interactive.

You can also display a toast message in the UI that lets the player know what happens when interacting with the entity.

```ts
myEntity.addComponent(
  new OnPointerDown(
    (e) => {
      log("myEntity clicked", e)
    },
    {
      button: ActionButton.PRIMARY,
      showFeedback: true,
      hoverText: "open",
    }
  )
)
```

In the example above, the second argument of the `OnPointerDown` component has an object with the following arguments:

- `button`: What button to respond to
- `showFeedback`: Boolean to turn the feedback on or off. It's _true_ by default.
- `hoverText`: String to display in the UI while the player points at the entity. By default, this string spells _Interact_, unless `showFeedback` is _false_.

[IMAGE]

> TIP: The `hoverText` string should describe the action that happens when interacting. For example `Open`, `Activate`, `Grab`, `Select`. These strings should be as short as possible, to avoid stealing too much focus from the player.

The `hoverText` of an `OnPointerUp` component is only displayed while the player is already holding down the corresponding key and pointing at the entity.

If an entity has both an `OnPointerDown` and an `OnPointerUp` component, the hint for the `OnPointerDown` is shown while the button is not being pressed. The hint switches to the one from the `OnPointerUp` only when the button is pressed and remains pressed.

```ts
myEntity.addComponent(
  new OnPointerDown(
    (e) => {
      log("myEntity clicked", e)
    },
    { button: ActionButton.PRIMARY, showFeedback: true, hoverText: "Drag" }
  )
)

myEntity.addComponent(
  new OnPointerUp(
    (e) => {
      log("myEntity released", e)
    },
    { button: ActionButton.PRIMARY, showFeedback: true, hoverText: "Drop" }
  )
)
```

[IMAGE or GIF?]

#### Max click distance

By default, entities are only clickable when the player is within a close range of the entity, at a maximum distance of _10 meters_. You can optionally configure the maximum distance through the `distance` parameter of the `OnPointerDown` and `OnPointerUp` components.

```ts
myEntity.addComponent(
  new OnPointerDown(
    (e) => {
      log("myEntity clicked", e)
    },
    {
      button: ActionButton.PRIMARY,
      showFeedback: true,
      hoverText: "Activate",
      distance: 8,
    }
  )
)
```

The example above sets the maximum distance to _8 meters_.

#### Event arguments

The _pointer down event_ and the _pointer up event_ objects are implicitly passed as parameters of the functions in the `OnPointerDown` and `OnPointerUp` components, respectively. This event object contains various properties that might be useful for the function. See [Properties of button events](#properties-of-button-events) for more details.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown(
    (e) => {
      log("Click distance: " + e.length)
    },
    { button: ActionButton.PRIMARY }
  )
)
```

<!--
#### Multiple buttons on an entity

You may want to make an entity respond to different buttons in different ways. Each entity can only have _one_ `OnPointerDown` component, and _one_ `OnPointerUp` component, but these components can be configured to support multiple button events.

To do so, simply pass an array of actionbuttons and a hint string for each.

To differentiate between buttons in the function, you can then detect which button was pressed, by checking the `buttonId` field from the event data. The value of this field will either return a _0_, _1_ or _2_, which map to the `POINTER`, `PRIMARY`, and `SECONDARY` buttons respectively.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnPointerDown(
    [
      { button: ActionButton.POINTER, actionName: "Do A" },
      { button: ActionButton.PRIMARY, actionName: "Do B" },
      { button: ActionButton.SECONDARY, actionName: "Do C" }
    ],
    e => {
      if (e.pointerId == 0) {
        log("Clicked pointer")
      } else if (e.pointerId == 1) {
        log("Pressed primary button")
      } else if (e.pointerId == 2) {
        log("Pressed secondary button")
      }
    }
  )
)
```

Players will see the multiple different actions that are available stacked up over each other. If an entity has also an `OnPointerUp` component,

-->

## Properties of button events

The events from `OnPointerDown` and `OnPointerUp` components, as well as all the global button event objects, contain the following parameters:

- `origin`: Origin point of the ray, as a _Vector3_
- `direction`: Direction vector of the ray, as a normalized _Vector3_ that points in the same direction.
- `pointerId`: ID of the pointer that triggered the event (_POINTER_, _PRIMARY_ or _SECONDARY_)
- `hit`: _(Optional)_ Object describing the entity that was clicked on. If the click didn't hit any specific entity, this field isn't present. The `hit` object contains the following parameters:

  - `length`: Length of the ray in meters, as a _number_
  - `hitPoint`: The intersection point between the ray and the entity's mesh, as a _Vector3_
  - `meshName`: The name of the mesh, if applicable, as a _string_
  - `worldNormal`: The normal of the hit, in world space, as a _Vector3_
  - `entityId`: The ID of the entity, if applicable, as a _string_

#### Differentiate meshes inside a model

Often, _.glTF_ 3D models are made up of multiple meshes, that each have an individual internal name. All button events events include the information of what specific mesh was clicked, so you can use this information to trigger different click behaviors in each case.

To see how the meshes inside the model are named, you must open the 3D model with an editing tool, like [Blender](https://www.blender.org/) for example.

<img src="{{ site.baseurl }}/images/media/mesh-names.png" alt="Mesh internal names in an editor" width="250"/>

> Tip: You can also learn the name of the clicked mesh by logging it and reading it off console.

You access the `meshName` property as part of the `hit` object, that's returned by the click event.

In the example below we have a house model that includes a mesh named `firePlace`. We want to turn on the fireplace only when its corresponding mesh is clicked.

```ts
houseEntity.addComponent(
  new OnPointerDown(
    (e) => {
      log("button A Down", e.hit.meshName)
      if (e.hit.meshName === "firePlace") {
        // light fire
        fireAnimation.play()
      }
    },
    { button: ActionButton.POINTER, showFeeback: false }
  )
)
```

> Note: Since the `OnPointerDown` component belongs to the whole entity, the on-hover feedback would be seen when hovering over any part of the entity. In this case, any part of the house, not just the fireplace. For that reason, we set the `showFeedback` argument of the `OnPointerDown` component to _false_, so that no on-hover feedback is shown. For a better player experience, it's recommended to instead have the fireplace as a separate entity and maintain the on-hover feedback.

## Global button events

The _BUTTON_DOWN_ and _BUTTON_UP_ events are fired whenever the player presses or releases an input controller button.

> Tip: On a computer, that refers to the _left mouse button_ (or trackpad), the _E_, and the _F_ keys.

These events are triggered every time that the buttons are pressed or released, regardless of where the player's pointer is pointing at, as long as the player is standing inside the scene's boundaries.

Instance an `Input` object and use its `subscribe()` method to initiate a listener that's subscribed to one of the button events. Whenever the event is caught, it executes a provided function.

The `subscribe()` method takes four arguments:

- `eventName`: The type of action, this can be either `"BUTTON_DOWN"` or `"BUTTON_UP"`
- `buttonId`: Which button to listen for. This can either be `ActionButton.POINTER`, `ActionButton.PRIMARY`, or `ActionButton.SECONDARY`. It can also take numbers 0, 1 or 2 that map to these values.
- `useRaycast`: Boolean to define if raycasting will be used. If `false`, the button event will not contain information about any `hit` objects that align with the pointer at the time of the event.
- `fn`: The function to execute when the event occurs.

```ts
// Instance the input object
const input = Input.instance

// button down event
input.subscribe("BUTTON_DOWN", ActionButton.POINTER, false, (e) => {
  log("pointer Down", e)
})

// button up event
input.subscribe("BUTTON_UP", ActionButton.POINTER, false, (e) => {
  log("pointer Up", e)
})
```

The example above logs messages and the contents of the event object every time the pointer button is pushed down or released.

The event objects of both the `BUTTON_DOWN` and the `BUTTON_UP` contain various useful properties. See [Properties of button events](#properties-of-button-events) for more details.

> Note: This code only needs to be executed once, the `subscribe()` method keeps polling for the event. Don't add this into a system's `update()` function, as that would register a new listener on every frame.

#### Detect hit entities

If the third argument of the `subscribe()` function (`useRaycast`)is true, and the player is pointing at an entity that has a collider, the event object includes a nested `hit` object. The `hit` object includes information about the collision and the entity that was hit.

The ray of a global button event only detects entities that have a collider mesh. Primitive shapes have a collider mesh on by default, 3D models need to have one built into them.

> Tip: See [Colliders]({{ site.baseurl }}{% post_url /3d-modeling/2018-01-12-colliders %}) for details on how to add collider meshes to a 3D model.

```ts
input.subscribe("BUTTON_DOWN", ActionButton.POINTER, true, (e) => {
  if (e.hit) {
    let hitEntity = engine.entities[e.hit.entityId]
    hitEntity.addComponent(greenMaterial)
  }
})
```

The example above checks if any entities were hit, and if so it fetches the entity and applies a material component to it.

The event data returns a string for the `entityId`. If you want to reference the actual entity by that ID to affect it in some way, use `engine.entities[e.hit.entityId]`.

> Note: We recommend that when possible you use the approach of adding an `OnPointerDown` component to each entity you want to make interactive, instead of using a global button event. The scene's code isn't able to hint to a player that an entity is interactive when hovering on it unless the entity has an `OnPointerDown`, `OnPointerUp`, or `OnClick` component.

## Ray Obstacles

Button events cast rays that only interact with the first entity on their path, as long as the entity is closer than its distance limit.

For an entity to be intercepted by the ray of a button event, the entity's shape must either have a collider mesh, or the entity must have a component related to button events (`OnPointerDown`, `OnPointerUp` or `OnClick`).

If another entity's collider is standing on the way of the entity that the player wants to click, the player won't be able to click the entity that's behind, unless the entity that's in-front has a shape with its `isPointerBlocker` property set to false.

```ts
let myEntity = new Entity()
let box = new BoxShape()
box.isPointerBlocker = false
box.visible = false
myEntity.addComponent(box)
engine.addEntity(myEntity)
```

## OnClick Component - DEPRECATED

As an alternative to `OnPointerDown`, you can use the `OnClick` component. This component only tracks button events from the `POINTER`, not from the primary or secondary buttons.

You declare what to do in the event of a click by writing a function in the `OnClick` component.

```ts
const myEntity = new Entity()
myEntity.addComponent(new BoxShape())

myEntity.addComponent(
  new OnClick((e) => {
    log("myEntity clicked")
  })
)
```

The `OnClick` component passes less event information than the `OnPointerDown` component, it lacks the click distance or the mesh name, for example.

<!--

It only contains the following parameter, which can be accessed by your function:

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

-->

> Note: Entities that don't have a shape component, or that have their shape's `visible` field set to _false_ can't be clicked.

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

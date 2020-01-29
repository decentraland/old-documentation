---
date: 2018-02-16
title: Custom events
description: Emit custom events and add listeners for them
categories:
  - development-guide
type: Document
set: development-guide
set_order: 16
---

Sometimes it's useful to decouple the different parts of your scene's code and make them interact with each other via sending events.

Decentraland scenes handle [button events](({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %})), but you can create your own to handle things that are specific to your scene.

For example, you could have a `pickedCoin` event that's emitted every time the user picks up a coin in your scene. You could then have a score board that listens for these events and updates the score accordingly. Thanks to this, the part of your code that handles the picking of coins doesn't need to have any reference to the part of the code that updates the scoreboard.

## Initiate the event manager

Before you can emit or listen for events, you need to initiate the event manager in your scene.

```ts
const events = new EventManager()
```

> Note: A single scene can handle multiple `EventManager` instances.

## Define event types

If you want events in your scene to contain custom data fields, you need to define a specific type for your events. You do this by defining a class that has an `@EventConstructor()` decorator.

```ts
@EventConstructor()
class MyEvent {
  constructor(public field1: string, public field2: number) {}
}
```

## Emit events

To emit an event, you call the `fireEvent()` function of the event manager.

```ts
events.fireEvent(new MyEvent(field1, field2))
```

Note that in this example, the event being sent contains an object of a custom event type.

## Listen for events

To listen for an event, you can add call the `addListener()` function of the event manager. This function takes in the following arguments:

- The `type` of the event object to listen for.
- The listener name.

  > Note: If you'll have multiple listeners listening to the same event, each listener must have its own unique name.

- The function to execute every time the event is caught.

```ts
events.addListener(MyEvent, `listener1`, ({ field1, field2 }) => {
  // function
})
```

## Full example

The following example scene emits and listens for events.

```ts
// Initiate event manager
const events = new EventManager()

// Define an event type
@EventConstructor()
class UpdateEvent {
  constructor(public entity: Entity, public dt: number) {}
}

// Define a system
export class EventFiringSystem implements ISystem {
  group = engine.getComponentGroup(Transform)

  update(dt: number) {
    for (let entity of this.group.entities) {
      // Emit custom event
      events.fireEvent(new UpdateEvent(entity, dt))
    }
  }
}

engine.addSystem(new EventFiringSystem())

// Add a listener
events.addListener(UpdateEvent, `listener1`, ({ entity, dt }) => {
  const transform = entity.getComponent(Transform)
  const euler = transform.rotation.eulerAngles
  euler.y += dt * 10
  transform.rotation.eulerAngles = euler
})

// Add an entity to work with
const cube = new Entity()
const transform = new Transform()

cube.addComponentOrReplace(transform)
transform.position.set(5, 0, 5)

const boxShape = new BoxShape()
cube.addComponentOrReplace(boxShape)

engine.addEntity(cube)
```

---
date: 2018-02-16
title: Custom events
description: Emit custom events and add listeners for them
categories:
  - development-guide
type: Document
---

Sometimes it's useful to decouple the different parts of your scene's code and make them interact with each other via sending events.

Decentraland scenes handle some [default events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}) like `click` events and `buttonDown` or `buttonUp` events, but you can create your own to handle things that are specific to your scene.

For example, you could have a `pickedCoin` event that's emitted every time the player picks up a coin in your scene. You could then have a score board that listens for these events and updates the score accordingly. Thanks to this, the part of your code that handles the picking of coins doesn't need to have any reference to the part of the code that updates the scoreboard.

## Initiate the event manager

Before you can emit or listen for events, you need to initiate the event manager in your scene.

```ts
const events = new EventManager()
```

## Define event types

If you want events in your scene to contain custom data fields, you need to define a specific type for your events. You do this by defining a class that has an `@EventConstructor()` decorator.

```ts
@EventConstructor()
class MyEvent {
  field1: string
  field2: number
  constructor(public field1: string, public field2: number) {
    this.field1 = field1
    this.field2 = field2
  }
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
- The listener to use. This will almost always be `null`.
- The function to execute every time the event is caught.

```ts
events.addListener(MyEvent, null, ({ field1, field2 }) => {
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
  entity: Entity
  dt: number
  constructor(public entity: Entity, public dt: number) {
    this.entity = entity
    this.dt = dt
  }
}

// Define a system
export class RotatorSystem implements ISystem {
  group = engine.getComponentGroup(Transform)

  update(dt: number) {
    for (let entity of this.group.entities) {
      // Emit custom event
      events.fireEvent(new UpdateEvent(entity, dt))
    }
  }
}

engine.addSystem(new RotatorSystem())

// Add a listener
events.addListener(UpdateEvent, null, ({ entity, dt }) => {
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

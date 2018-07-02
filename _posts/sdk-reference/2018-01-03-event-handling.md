---
date: 2018-01-05
title: Event Handling
description: Learn the different events that can occur in a scene and how to catch them.
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 3
---

The user generates different types of events when interacting with a scene. By using typescript code, you can listen to those events and make the scene interactive.

Generally, a good way of listening for these events is to set up a `subscribeTo` function in the `sceneDidMount()` method.

```tsx
   async sceneDidMount() {
        this.eventSubscriber.on(`pointerDown`, () => console.log("pointer down"));
    }
```

> Note: `this` here refers to the scene object, which is a child of [scriptable scene]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}) object. 



## Clicking

When a user clicks a mouse or another controller, and the ray that's being casted points to a specific entity, this creates a click event. 


> Note: Only entities with an ID are listening for click events. Clicks can be made from a maximum distance of 10 meters of the entity.

### Click events for specific entities

Click events are named as: the id of the entity, an underscore and then *click*. For example, the event of clicking an entity called `redButton` is named `redButton_click`.

```tsx
import { createElement, ScriptableScene } from 'metaverse-api'

export default class RedButton extends ScriptableScene {
  state = { 
      buttonState: false
   }

  async sceneDidMount() {   
    this.eventSubscriber.on('redButton_click', ()) => {
      this.setState({ buttonState: !this.state.buttonState })
    })
  }

  async render() {
    return (
      <scene>
        <box id="redButton" color="ff0000" />
      </scene>
    )
  }
}
```

The scene above uses an `eventSubscriber` to listen for click events done on the `redButton` entity. Whenever this occurs, the state of `buttonState` is toggled.


### The generic click event

The generic `click` event represents all clicks done on valid entities. The event has two parameters:

* `elementId`: the Id of the entity that was clicked.
* `pointerId`: the number id for the user who performed the click.

```tsx
import { createElement, ScriptableScene } from 'metaverse-api'

export default class LastClicked extends ScriptableScene {
  state = { 
      lastClicked: null
   }

  async sceneDidMount() {   
      this.subscribeTo("click", e => {
            console.log(e.pointerId);
            this.setState({ lastClicked: e.elementId });
        });
  }

  async render() {
    return (
      <scene>
        <box id="box1" position={{ x: 2, y: 1, z: 0 }} color="ff0000" />
        <box id="box2" position={{ x: 4, y: 1, z: 0 }} color="00ff00" />
      </scene>
    )
  }
}
```

The example above uses the `subscribeTo` function to check for all valid click events. When one occurs, it states the `lastClicked` state to the id of the entity that was clicked.

## Position change

The `positionChanged` event sends the position of the user in the scene each time this changes.

The `positionChanged` event has the following properties:

* `position`: a Vector3Component with the user's position relative to the base parcel of the scene.
* `cameraPosition`: a Vector3Component with the user's absolute position relative to the world.
* `playerHeight`: a number for the eye height of the user, in meters.


```tsx
import { createElement, ScriptableScene } from 'metaverse-api'

export default class BoxFollower extends ScriptableScene {
  state = { position: { x: 0, y: 0, z: 0 } }

  async sceneDidMount() {
      this.subscribeTo('positionChanged', e => {
          this.setState({ position: e.position });         
      });
  }

  async render() {
    return (
      <scene>
        <box position={this.state.position} ignoreCollisions />
      </scene>
    )
  }
}
```

The scene above uses a `subscribeTo` function to track when the position of the user changes. When it does, it stores this position in the state variable `position`, which is used to set the position of a box that follows the user around.

## Rotation change



The `rotationChanged` event sends the angle in which the user is looking each time this angle changes.

The `rotationChanged` event has the following properties:

* `rotation`: a Vector3Component with the user's rotation.

* `quaternion`: the rotation quaternion of the user.


```tsx
import { createElement, ScriptableScene } from 'metaverse-api'

export default class ConeHead extends ScriptableScene {
  state = { rotation: { x: 0, y: 0, z: 0 } }

  async sceneDidMount() {
      this.subscribeTo('positionChanged', e => {
          this.setState({ rotation: e.rotation });  
          this.state.rotation.x +=  90 ;       
      });
  }

  async render() {
    return (
      <scene>
      <cone position={{ x: 0, y: 1, z: 2 }} rotation={this.state.rotation}/>
      </scene>
    )
  }
}
```

The scene above uses a `subscribeTo` function to track when the user's rotation changes. When the user looks at a different angle, the scene stores this angle in the state variable `rotation` and adds another 90 degrees to the X axis, just so that the output is more fun to play with. This angle is used by a cone that faces the user and mimics its movements.


## Pointer down and pointer up

The pointer down and pointer up events are fired whenever the user presses or releases an input controler. This could be a mouse, a touch screen, a VR controller or another kind of controller. It doesn't matter where the user is pointing at, the event is triggered every time.

```tsx
import { createElement, ScriptableScene } from 'metaverse-api'

export default class bigButton extends ScriptableScene {
  state = { 
      buttonState: false
   }

  async sceneDidMount() {  
    this.subscribeTo("pointerDown", e => {
        this.setState({ buttonState: 0});
    }); 
    this.subscribeTo("pointerUp", e => {
        this.setState({ buttonState: 1});
    });
  }

  async render() {
    return (
      <scene>
          <box id="button" 
              position={{ x: 3, y: this.state.buttonState, z: 3 }} 
              transition={ { position: { duration: 200, timing: "linear" } } } 
          />
      </scene>
    )
  }
}
```
The scene above uses two `subscribeTo` functions to track both when the user clicks or releases a pointer button. Both functions alter the `buttonState` variable in the scene, this variable is then used to set the height of a box that mimics the pressing of the user's button.

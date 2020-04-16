---
date: 2018-02-28
title: Game objects
description: Use the game object pattern to make your code more readable and easier to scale.
categories:
  - development-guide
type: Document
---

As your scene becomes more complicated, it's useful to put some of the logic into separate game object files. By doing this, you can keep the main code for the scene clean and simple to read, while encapsulating reusable parts that control several entities in the scene.

A Game Object holds all the properties and methods for a type of entity you might find in your scene, for example a door or a button or a monster. Thanks to this abstraction, the files with your scene's main logic can instance full game objects through just one line of code. You can also call the methods on these objects with the same ease.

We recommend keeping game object definitions each in a separate file.

Below is an example of a `Door` game object. This object has a constructor that requires that you pass it a shape, a sound and a position. It also exposes an `openDoor`, `closeDoor` and `toggleDoor` method, that can be called from other files.

```ts
export class Door extends Entity {
  public isOpen: boolean

  // Allow each room to specify a unique look and feel
  constructor(
    model: GLTFShape,
    transform: TranformConstructorArgs,
    sound: AudioClip
  ) {
    super()
    engine.addEntity(this)

    this.addComponent(model)
    this.addComponent(new Transform(transform))

    this.addComponent(new Animator())
    this.getComponent(Animator).addClip(
      new AnimationState("Door_Open", { looping: false })
    )
    this.getComponent(Animator).addClip(
      new AnimationState("Door_Close", { looping: false })
    )

    this.addComponent(new AudioSource(sound))
  }

  /**
   * Exposing `openDoor` as an action this object is capable of doing
   * This contains the open door experience (animation and sound) while allowing
   * the scene to decide when the action occurs
   */

  public openDoor(playAudio = true): void {
    if (!this.isOpen) {
      this.isOpen = true

      this.getComponent(Animator).getClip("Door_Close").stop() // bug workaround
      this.getComponent(Animator).getClip("Door_Open").play()

      if (playAudio) {
        this.getComponent(AudioSource).playOnce()
      }
    }
  }

  // Similiarly we can close the door.
  public closeDoor(playAudio = true): void {
    if (this.isOpen) {
      this.isOpen = false

      this.getComponent(Animator).getClip("Door_Open").stop() // bug workaround
      this.getComponent(Animator).getClip("Door_Close").play()

      if (playAudio) {
        this.getComponent(AudioSource).playOnce()
      }
    }
  }

  // Or toggle the state between open and closed
  public toggleDoor(playAudio = true): void {
    if (this.isOpen) {
      this.closeDoor(playAudio)
    } else {
      this.openDoor(playAudio)
    }
  }
}
```

A few things to note from the code above:

- `export` makes the class available to other files in your scene
- `extends Entity` makes this definition inherit everything from the base `Entity` class
- `this` refers to the current instance of the game object

None of the code above produces any changes in the scene on its own. It just exposes constructors and methods that can be called from other files, keeping what's possible separate from what is to be done.

Once the `Door` class is defined in your scene, you can use it in your `game.ts` or any other file:

```ts
import { Door } from "./door"

const door = new Door(
  new GLTFShape("models/Door.glb"),
  { position: new Vector3(24, 0, 24) },
  new AudioClip("sounds/door_squeak.mp3")
)
door.addComponent(
  new OnClick((): void => {
    door.toggleDoor()
  })
)
```

The code above imports the `Door` class, then instances a door, and adds an OnClick behavior to it that simply calls the `toggleDoor` method in the `Door` class.

> Tip: To learn more about using game objects in Decentraland scenes, see this [Tutorial video](https://www.youtube.com/watch?v=_kksSC91DKE)

## The Type Object Pattern

If your scene uses various types of game objects that have much in common, you might want to take this refactor even further, and define a _base_ game object type with all the things that these have in common. You can then create sub classes that inherit from this base class.

You can read more about this pattern in [Game Programming Patterns](http://www.gameprogrammingpatterns.com/type-object.html).

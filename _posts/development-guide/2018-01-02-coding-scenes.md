---
date: 2018-01-01
title: Coding scenes
description: This set will help you understand how things work in the client and SDK of decentraland.
redirect_from:
  - /documentation/introduction/
  - /docs/sdk-overview/
  - /docs/command-line-interface/
  - /docs/sdk-quick-start-guide/
  - /sdk-reference/introduction/
  - /sdk-reference/scriptable-scene/
  - /development-guide/scriptable-scene/
  - /documentation/tsx-coding-guide/
  - /development-guide/typescript-tips/
  - /decentraland/SDK-Overview/
  - /sdk-reference/SDK-Overview/
  - /getting-started/coding-scenes/
categories:
  - development-guide
type: Document
---

## The development tools

At a very high level, the **Decentraland Software Development Kit** (SDK) allows you to do the following:

- Generate a default _project_ containing a Decentraland scene, including all the assets needed to render and run your content.
- Build, test, and preview the content of your scene locally in your web browser - completely offline, and without having to make any Ethereum transactions or own LAND.
- Write TypeScript code using the Decentraland API to add interactive and dynamic behavior to the scene.
- Upload the content of your scene to the content server.
- Link your LAND tokens to the URL of the content you have uploaded.

Our SDK includes the following components:

<!--
- **The Decentraland Editor**: Use it to create and preview Decentraland scenes. You don't need to download any software to your machine, the editor runs entirely on your browser.
-->

- **The Decentraland CLI** (Command Line Interface): Use it to [generate]({{ site.baseurl }}{% post_url /development-guide/2018-01-02-coding-scenes %}) new Decentraland scenes locally on your own machine, preview them and upload them to the content server.
- **The Decentraland ECS**: A TypeScript package containing the library of helper methods that allows you to create interactive experiences. Use it to create and manipulate objects in the scene and also to facilitate in-world transactions between players or other applications. ( [latest ECS reference](https://github.com/decentraland/ecs-reference/blob/master/docs-latest/decentraland-ecs.md))

- **Scene examples**: Take inspiration and coding best practices from the [scene examples](https://github.com/decentraland-scenes/Awesome-Repository#examples).

## Requirements

To develop a scene locally, you don't need to own LAND tokens. Developing and testing a scene can be done completely offline, without the need to deploy a scene to the Ethereum network (the system Decentraland uses to establish ownership of LAND), or the content server.

You must have the following:

- **npm** (Node package manager): Used in the terminal to handle scene dependencies, required to install the Decentraland CLI. [Download link](nodejs.org)

- **The Decentraland CLI**: Used to build, preview and upload scenes. See [Installation guide]({{ site.baseurl }}{% post_url /development-guide/2018-01-01-installation-guide %})

- **A source code editor**: Helps you create scenes a lot faster and with less errors. A source code editor marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. You can also click on an object in the code to see the full definition of its class and what attributes it supports. We recommend [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/).

## Supported languages and syntax

#### TypeScript (recommended)

We use [TypeScript (.ts)](https://www.typescriptlang.org/docs/handbook/jsx.html)
to create our scenes.

TypeScript is a superset of JavaScript, so if you're familiar with JavaScript you'll find it's almost the same, but TypeScript allows you to employ object-oriented programming and type declarations. Features like autocomplete and type-checking speed up development times and allow for the creation of a more solid codebase. These features are all key components to a positive developer experience.

#### Other languages

You can use another tool or language instead of TypeScript and compile it into JavaScript, as long as your compiled scripts are contained within a single JavaScript file named _game.js_. All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Scenes

The content you deploy to your LAND is called a **scene**. A scene is an interactive program that renders content, this could be a game, an interactive experience, an art gallery, whatever you want!

Scenes are deployed to virtual LAND in Decentraland. LAND is a scarce and non-fungible asset maintained in an Ethereum smart contract. Deploy to a single **parcel**, a 16 meter by 16 meter piece of LAND, or to an **estate**, comprised of multiple adjacent parcels.

We are developing the web client that will allow players to explore Decentraland. All of the content you upload to your LAND will be rendered and viewable through this client. We have included a preview tool in the SDK so that you can preview, test, and interact with your content in the meantime.

## Entities and Components

Three dimensional scenes in Decentraland are based on an [Entity-Component-System](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) architecture, where everything in a scene is an _entity_, and each entity can include _components_ that determine its characteristics.

<img src="{{ site.baseurl }}/images/media/ecs-components.png" alt="nested entities" width="400"/>

Entities are nested inside other entities to form a tree structure. If you're familiar with web development, you might find it useful to think of entities as elements in a DOM tree and of components as the attributes of each of these elements.

<img src="{{ site.baseurl }}/images/media/ecs-nested-entities.png" alt="nested entities" width="400"/>

See [Entities and components]({{ site.baseurl }}{% post_url /development-guide/2018-02-1-entities-components %}) for an in-depth look of both these concepts and how they're used by Decentraland scenes.

## The game loop

The [game loop](http://gameprogrammingpatterns.com/game-loop.html) is the backbone of a Decentraland scene's code. It cycles through part of the code at a regular interval and does the following:

- Listen for player input
- Update the scene
- Re-render the scene

In most traditional software programs, all events are triggered directly by player actions. Nothing in the program's state will change until the player clicks on a button, opens a menu, etc.

But interactive environments and games are different from that. Not all changes to the scene are necessarily caused by a player's actions. Your scene could have animated objects that move on their own or even non-player characters that have their own AI. Some player actions might also take multiple frames to be completed, for example if the opening of a door needs to take a whole second, the door's rotation must be incrementally updated about 30 times as it moves.

We call each iteration over the loop a _frame_. Decentraland scenes are rendered at 30 frames per second whenever possible. If a frame takes more time than that to be rendered, then less frames will be processed.

In each frame, the scene is updated; then the scene is re-rendered, based on the updated values.

In Decentraland scenes, there is no explicitly declared game loop, but rather the `update()` functions on the [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) of the scene make up the game loop.

The compiling and rendering of the scene is carried out in the backend, you don't need to handle that while developing your scene.

## Systems

Entities and components are places to store information about the objects in a scene. _Systems_ hold functions that change the information that's stored in components.

_Systems_ are what make a static scene dynamic, allowing things to change over time or in response to player interaction.

Each System has an `update()` method that's executed on every frame of the game loop, following the [_update pattern_](http://gameprogrammingpatterns.com/update-method.html).

See [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}) for more details about how systems are used in a scene.

## Component groups

[Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}) keep track of all entities in the scene that have certain components in them. Once a component group is created, it automatically keeps its list up to date with each new entity or component that is added or removed.

If you attempt to update all the entities in the scene on every frame, that could have a significant cost in performance. By referring only to the entities in a component group, you ensure you're only dealing with those that are relevant.

Component groups can be referenced by the functions in a [system]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}). Typically an `update()` function will loop over the entities in the component group, performing the same actions on each.

## Putting it all together

The _engine_ is what sits in between _entities_, _components_ and _component groups_ on one hand and _systems_ on the other. It calls system's functions, updates groups when entities are added, etc.

![]({{ site.baseurl }}/images/media/ecs-big-picture.png)

All of the values stored in the components in the scene represent the scene's state at that point in time. With every frame of the game loop, the engine runs the `update()` function of each of the systems to update the values stored in the components.

After all the systems run, the components on each entity will have new values. When the engine renders the scene, it will use these new updated values and players will see the entities change to match their new states.

```ts
// Create a group to track all entities with a Transform component
const myGroup = engine.getComponentGroup(Transform)

// Define a System
export class RotatorSystem implements ISystem {
  // The update function runs on every frame of the game loop
  update() {
    // The function iterates over all the entities in myGroup
    for (let entity of myGroup.entities) {
      const transform = entity.getComponent(Transform)
      transform.rotate(Vector3.Left(), 0.1)
    }
  }
}

// Add the system to the engine
engine.addSystem(new RotatorSystem())

// Create an entity
const cube = new Entity()

// Give the entity a transform component
cube.addComponent(
  new Transform({
    position: new Vector3(5, 1, 5),
  })
)

// Give the entity a box shape
cube.addComponent(new BoxShape())

// Add the entity to the engine
engine.addEntity(cube)
```

In the example above, a `cube` entity and a `RotatorSystem` system are added to the engine. The `cube` entity has a `Transform`, and a `BoxShape` component. In every frame of the game loop, the `update()` function of `RotationSystem` is called, and it changes the rotation values in the `Transform` component of the `cube` entity.

Note that most of the code above is executed just once, when loading the scene. The exception is the `update()` method of the system, which is called on every frame of the game loop.

## Scene Decoupling

Your scenes don't run in the same context as the engine
(a.k.a. the main thread). We created the SDK in a way that is
entirely decoupled from the rendering engine. We designed it to be like this for both safety and performance reasons.

Because of this decoupling, your scene's code doesn't have access to the DOM or the `window` object, so you can't access data like the player's browser or geographical location.

The decoupling works by using RPC protocol, this protocol assigns a small part of the client to only render the scene and control events.

We have also abstracted the communication protocol. This allows us to run the scenes locally in a WebWorker.

We don't want developers to intervene with the internals of the engine or even need to know what lies inside the engine. We need to ensure a consistent experience for players throughout the Decentraland map, and mistakes are more likely to happen at that "low" level.

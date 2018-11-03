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
categories:
  - getting-started
type: Document
set: getting-started
set_order: 4
---

## The development tools

At a very high level, the **Decentraland Software Development Kit** (SDK) allows you to do the following:

- Generate a default _project_ containing a Decentraland scene, including all the assets needed to render and run your content.
- Build, test, and preview the content of your scene locally in your web browser - completely offline, and without having to make any Ethereum transactions or own LAND.
- Write TypeScript code using the Decentraland API to add interactive and dynamic behavior to the scene.
- Upload the content of your scene to the content server.
- Link your LAND tokens to the URL of the content you have uploaded.

It includes the following components:

- **The Decentraland Editor**: Use it to create and preview Decentraland scenes. You don't need to download any software to your machine, the editor runs entirely on your browser.
- **The Decentraland CLI** (Command Line Interface): Use it to generate new Decentraland scenes locally on your own machine, preview them and upload them to the content server.
- **The Decentraland API** (formerly known as _Metaverse API_ and still commonly referred to as _the API_): A TypeScript package containing the library of helper methods that allows you to create interactive experiences. Use it to create and manipulate objects in the scene and also to facilitate in-world transactions between users or other applications.

- **Scene examples**: Take inspiration and coding best practices from the [sample scenes]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}).

## CLI Requirements

To develop a scene locally, you don't need to own LAND tokens. Developing and testing a scene can be done completely offline, without the need to deploy a scene to the Ethereum network (the system Decentraland uses to establish ownership of LAND), or the content server.

This SDK is intended to be used by users that are comfortable working with code and a terminal. You must have the following:

- **npm** (Node package manager): Used in the terminal to handle scene dependencies. [Download link](https://www.npmjs.com/)

- **A source code editor**: Helps you create scenes a lot faster and with less errors, as it marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. Click on an object in the code to see the full definition of its class and what attributes it supports. We recommend [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/).

- **The Decentraland CLI**: Used to build, preview and upload scenes. See [Installation guide]({{ site.baseurl }}{% post_url /getting-started/2018-01-01-installation-guide %})

## Supported languages and syntax

#### TypeScript (recommended)

We use [TypeScript (.tsx)](https://www.typescriptlang.org/docs/handbook/jsx.html)
to create our scenes.

TypeScript is a superset of JavaScript, so if you're familiar with JavaScript you'll find it's almost the same, but TypeScript allows you to employ object-oriented programming and type declarations. Features like autocomplete and type-checking speed up development times and allow for the creation of a solid codebase. These features are all key components to a positive developer experience.

<!--
See [TypeScript tips]({{ site.baseurl }}{% post_url /development-guide/2018-01-08-typescript-tips %}) for best practices and recommendations for writing Decentraland scenes using TypeScript.
-->

#### XML

For scenes that only render motionless content and that won't be interactive, you can use [XML](https://en.wikipedia.org/wiki/XML).

When building your scene with the CLI, select the option _Static_.

We encourage developers to instead build their scenes using TypeScript. TypeScript scenes include embedded XML tags to handle the rendered entities. If you ignore all of the Typescript code in a _Basic_ scene and only edit what's inside the `render()` function, you're dealing with what's essentially XML but with slightly different syntax.

#### Other languages

You can use another tool or language instead of TypeScript and compile it into JavaScript, as long as your compiled scripts are contained within a single JavaScript file named _scene.js_. All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Scenes

The content you deploy to your LAND is called a **scene**. A scene is an interactive program that renders content, this could be a game, an interactive experience, an art gallery, whatever you want!

Scenes are deployed to **parcels**, the 10 meter by 10 meter pieces of virtual LAND, the scarce and non-fungible asset maintained in an Ethereum smart contract. These parcels of virtual space are where you will upload and interact with the content you create using the SDK.

We are developing the web client that will allow users to explore Decentraland. All of the content you upload to your LAND will be rendered and viewable through this client. We have included a preview tool in the SDK so that you can preview, test, and interact with your content in the meantime.

<!--
## Scene paradigms

////// ONLY IF WE TAKE THE HORRIBLE DECISION TO DO BOTH

Decentraland scenes can be coded in two very different ways.

- ECS (.ts) uses an Entity component system and is close to how most game engines develop
- Scriptable scene (.tsx) is close to how the React framework works, which is popular in web development.

-->

## Entities and Components

Three dimensional scenes in Decentraland are based on an [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) system, where everything in a scene is an _entity_, and each entity can include _components_ that determine its characteristics.

[DIAGRAM : ENTITY W COMPONENTS]

Entities are nested inside other entities to form a tree structure. If you're familiar with web development, you might find it useful to think of entities as elements in a DOM tree and of components as the attributes of each of these elements.

See [Entities and components]({{ site.baseurl }}{% post_url /development-guide/2018-02-15-entities-components %}) for an in-depth look of both these concepts and how they're used by Decentraland scenes.

## The game loop

The [game loop](http://gameprogrammingpatterns.com/game-loop.html) is the backbone of a Decentraland scene's code. It cycles through the main code at a regular interval and does the following:

- Listen for user input
- Update the scene
- Re-render the scene

In most traditional software programs, all events are triggered directly by user actions. Nothing it the program's state will change until the user clicks on a button, opens a menu, etc.

Interactive environments and games are different from that. Not all changes to the scene are necessarily caused by a user's actions. Your scene could have animated objects that move on their own or even non-player characters that have their own AI. Some user actions might also take multiple frames to be completed, for example if the opening of a door needs to take a whole second, the door position must be incrementally updated about 30 times as it moves.

We call each iteration over the loop a _frame_. Decentraland scenes are rendered at 30 frames per second whenever possible. If a frame takes more time than that to be rendered, then there will be fewer frames.

In each frame, the scene is updated; then the scene is re-rendered, based on the updated values.

In Decentraland scenes, there is no explicitly declared game loop, but rather the `update()` functions on the _Systems_ of the scene make up the game loop.

The rendering of the scene is carried out in the backend, you don't need to handle that while developing your scene.

## Systems

Entities and components are places to store information about 3D the objects in a scene. _Systems_ change the information that's stored in components.

_Systems_ are what make a static scene dynamic, allowing things to change over time or in response to user interaction.

Each System has an `update()` method that's executed on every frame of the game loop, following the [_update pattern_](http://gameprogrammingpatterns.com/update-method.html).

See [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-02-16-systems %}) for more details about how systems are used in a scene.

## Entity groups

Groups keep track of all entities in the scene that have certain components in them. Once a group is created, it automatically keeps its list up to date with each new entity or component that is added or removed.

Entity groups can be referenced by systems as they update the scene. If you attempt to update all the entities in the scene on every frame, that can sometimes have a significant cost in performance. By referring only to the entities in a group, you ensure you're only dealing with those that are relevant.

## Putting it all together

The _engine_ is what sits in between _entities_ and _components_ on one hand and _systems_ and _entity groups_ on the other. It calls system's functions, updates groups when entities are added, etc.

All of the values stored in the components in the scene represent the scene's state at that point in time. With every frame of the game loop, the engine runs each of the systems to update their values.

After all the systems run, the components on each entity will have new values. When the engine renders the scene, it will use these new updated values and users will see the entities change to match their new states.

```ts
// Create a group to track all entities with a Transform component
const myGroup = engine.getComponentGroup(Transform)

// Define a System
export class RotatorSystem {
  // The update function runs on every frame of the game loop
  update() {
    // The function iterates over all the entities in myGroup
    for (let entity of this.myGroup.entities) {
      const rotation = entity.get(Transform).Rotation
      rotation.x += 5
    }
  }
}

// Add the system to the engine
engine.addSystem(new RotatorSystem())

// Create an entity
const cube = new Entity()

// Create a transform component
const cubeTransform = new Transform()

// Set the fields in the transform component
cubeTransform.Position.set(5, 1, 5)
cubeTransform.Rotation.set(0, 0, 0)

// Set the transform onto the entity
cube.set(cubeTransform)

// Give the entity a box shape
cube.set(new BoxShape())

// Add the entity to the engine
engine.addEntity(cube)
```

In the example above, a `cube` entity and a `RotatorSystem` system are added to the engine. The `cube` entity has a `Transform`, and a `BoxShape` component. In every frame of the game loop, the `update()` function of `RotationSystem` is called, and it changes the values in the `Transform` component of the `cube` entity.

[DIAGRAM]

Note that most of the code above is executed just once, when loading the scene. The exception is the `update()` method of the system, which is called on every frame of the game loop.

## Scene Decoupling

Your scenes don't run in the same context as the engine
(a.k.a. the main thread), they might even not run in the same computer as the engine. We created the SDK in a way that is
entirely decoupled from the rendering engine. We designed it to be like this for both safety and performance reasons.

The decoupling works by using RPC protocol, this protocol assigns a small part of the client to only render the scene and control events.

We have also abstracted the communication protocol. This allows us to run the scenes locally in a WebWorker.

We don't want developers to intervene with the internals of the engine or even need to know what lies inside the engine. We need to ensure a consistent experience for users throughout the Decentraland map, and mistakes are more likely to happen at that "low" level.

Because of this decoupling, your scene's code doesn't have access to the DOM or the `window` object, so you can't access data like the user's browser or geographical location.

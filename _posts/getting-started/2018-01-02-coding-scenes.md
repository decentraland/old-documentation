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
- Upload the content of your scene to [IPFS](https://ipfs.io).
- Link your LAND tokens to the IPFS URL of the content you have uploaded.

It includes the following components:

- **The Decentraland CLI** (Command Line Interface): Use it to generate new Decentraland scenes locally on your own machine, preview them and upload them to IPFS.
- **The Decentraland API** (formerly known as _Metaverse API_ and still commonly referred to as _the API_): A TypeScript package containing the library of helper methods that allows you to create interactive experiences. Use it to create and manipulate objects in the scene and also to facilitate in-world transactions between users or other applications.

- **Scene exapmples**: Take inspiration and coding best practices from the [sample scenes]({{ site.baseurl }}{% post_url /examples/2018-01-08-sample-scenes %}).

## Requirements

To develop a scene locally, you don't need to own LAND tokens. Developing and testing a scene can be done completely offline, without the need to deploy a scene to the Ethereum network (the system Decentraland uses to establish ownership of LAND), or IPFS (the P2P network we use for distribution and delivery of content).

This SDK is intended to be used by users that are comfortable working with code and a terminal. You must have the following:

- **npm** (Node package manager): Used in the terminal to handle scene dependencies. [Download link](https://www.npmjs.com/)

- **A source code editor**: Helps you create scenes a lot faster and with less errors, as it marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. Click on an object in the code to see the full definition of its class and what attributes it supports. We recommend [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/).

- **The Decentraland CLI**: Used to build, preview and upload scenes. See [Installation guide]({{ site.baseurl }}{% post_url /getting-started/2018-01-01-installation-guide %})

## Supported languages and syntax

#### TypeScript (recommended)

We use [TypeScript (.tsx)](https://www.typescriptlang.org/docs/handbook/jsx.html)
to create our scenes.

TypeScript is a superset of JavaScript, so if you're familiar with JavaScript you'll find it's almost the same, but TypeScript allows you to employ object-oriented programming and type declarations. Features like autocomplete and type-checking speed up development times and allow for the creation of a solid codebase. These features are all key components to a positive developer experience.

In a Typescript scene, you handle the entities that are rendered in the scene as embedded XML assets. This works a lot like the [React](https://reactjs.org/docs/hello-world.html) framework. This is why the scene's main file, _scene.tsx_ is a _.tsx_ rather than a _.ts_.

> **Note:** Even though scenes are written in a way that intentionally looks a lot like React, **our SDK does not use React**.

See [TypeScript tips]({{ site.baseurl }}{% post_url /development-guide/2018-01-08-typescript-tips %}) for best practices and recommendations for writing Decentraland scenes using TypeScript.

#### XML

For scenes that only render montionless content and that won't be interactive, you can use [XML](https://en.wikipedia.org/wiki/XML).

When building your scene with the CLI, select the option _Static_.

We encourage developers to instead build their scenes using TypeScript. TypeScipt scenes include embedded XML tags to handle the rendered entities. If you ignore all of the Typescript code in a _Basic_ scene and only edit what's inside the `render()` function, you're dealing with what's essentially XML but with slightly different syntax.

#### Other languages

You can use another tool or language instead of TypeScript and compile it into JavaScript, as long as your compiled scripts are contained within a single JavaScript file named _scene.js_. All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Scenes

The content you deploy to your LAND is called a **scene**. A scene is an interactive program that renders content, this could be a game, an interactive experience, an art gallery, whatever you want!

Scenes are deployed to **parcels**, the 10 meter by 10 meter pieces of virtual LAND, the scarce and non-fungible asset maintained in an Ethereum smart contract. These parcels of virtual space are where you will upload and interact with the content you create using the SDK.

We are developing the web client that will allow users to explore Decentraland. All of the content you upload to your LAND will be rendered and viewable through this client. We have included a preview tool in the SDK so that you can preview, test, and interact with your content in the meantime.

## Scene paradigms

////// ONLY IF WE TAKE THE HORRIBLE DECISION TO DO BOTH

Decentraland scenes can be coded in two very different ways.

- ECS (.ts) uses an Entity component system and is close to how most game engines develop
- Scriptable scene (.tsx) is close to how the React framework works, which is popular in web development.

## The game loop

The [game loop](http://gameprogrammingpatterns.com/game-loop.html) is the backbone of a Decentraland scene's code. It cycles through the main code at a regular interval and does the following:

- Listen for user input
- Update the scene
- Re-render the scene

We call each iteration over the loop a _frame_. Decentraland scenes are rendered at 30 frames per second ... 30??

The engine tries to render the scene 30 times per second, but depending on scene performance, it could skip some frames to keep up. ?????

In each frame, the scene's state is updated. Then the scene is re-rendered, using the new values from the scene state.

Not all changes to the scene are necessarily caused by a user's actions. Your scene could have animated objects that move on their own or even non-player characters that have their own AI. Some user actions might also take multiple frames to be completed, for example if the opening of a door needs to take a whole second, the door position must be incrementally updated 30 times as it moves.

## Entities and Components

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an _entity_, and each entity can include _components_ that determine its characteristics.

[DIAGRAM : ENTITIY W COMPONENTS]

Entities are nested inside other entities to form a tree structure. If you're familiar with web development, you might find it useful to think of entities as elements in a DOM tree and of components as the attributes of each of these elements.

See [Entities and components]({{ site.baseurl }}{% post_url /development-guide/2018-01-15-entities-components %}) for an in-depth look of both these concepts and how they're used by Decentraland scenes.

<!--
For additional terms, definitions, and explanations, please refer to our [complete Glossary]({{ site.baseurl }}{% post_url /general/2018-01-03-glossary %}).
-->

## Systems and componentSystems

Entities and components are just used to store information about 3D objects, but don't have any methods to change those values when they need to be updated. That's where _systems_ come in.

_Systems_ and _systemComponents_ execute functions over the components of an entity to change their values. Systems and systemComponents each have an `update()` method that's executed on every frame of the game loop, this follows the [update game pattern](http://gameprogrammingpatterns.com/update-method.html).

See [Systems]({{ site.baseurl }}{% post_url /development-guide/2018-01-16-systems %}) for more details about how systems are used in a scene.

## Putting it all together

The _engine_ is what sits in between _entities_ and _components_ on one hand and _systems_ on the other. It coordinates the systems so that they know what entities to act upon and when.

All of the values stored in the components in the scene represent the scene's state at that point in time. With every frame of the game loop, the engine runs each of the systems over the corresponding components to update their values.

After all the systems run, the components on each entity will have new values. When the engine renders the scene, it will use these new updated values and users will see the entities change to match their new states.

<!--
All [scene objects]({{ site.baseurl }}{% post_url /development-guide/2018-01-05-scriptable-scene %}) have a 'render()` method that outputs what users of your scene will see on their browser. This function must always output a hierarchical tree of entities that starts at the root level with a _scene_ entity.

{% raw %}

```tsx
 async render() {
    return (
      <scene position={{ x: 5, y: 0, z: 5 }}>
        <box
          position={{ x: 2, y: 1, z: 0 }}
          scale={{ x: 2, y: 2, z: 0.05 }}
          color="#0000FF"
        />
        <entity
          rotation={this.state.doorRotation}
          transition={{ rotation: { duration: 1000, timing: 'ease-in' } }}
        >
          <box
            id="door"
            scale={{ x: 1, y: 2, z: 0.05 }}
            position={{ x: 0.5, y: 1, z: 0 }}
            color="#00FF00"
          />
        </entity>
      </scene>
    )
  }
```

{% endraw %}

If you have game development experience with other tools, you might expect scenes to have some kind of render loop that periodically renders elements in the screen. Decentraland doesn't work like that. We built the API based on _events_, so the `render()` function is designed to update the scene in reaction to events rather than by querying the world repeatedly.

Scenes have a [state]({{ site.baseurl }}{% post_url /development-guide/2018-01-04-scene-state %}), which is a collection of variables that change over time and represent the current disposition of the scene. The state changes by the occurrence of [events]({{ site.baseurl }}{% post_url /development-guide/2018-01-03-event-handling %}) in the scene. When the state changes, this retriggers the rendering of the scene, using the new values of the state.

This is inspired by the [React](https://reactjs.org/) framework, most of what you can read about React applies to decentraland scenes as well.

-->

## Scene Decoupling

Your scenes don't run in the same context as the engine
(a.k.a. the main thread), they might even not run in the same computer as the engine. We created the SDK in a way that is
entirely decoupled from the rendering engine. We designed it to be like this for both safety and performance reasons.

The decoupling works by using RPC protocol, this protocol assigns a small part of the client to only render the scene and control events.

We have also abstracted the communication protocol. This allows us to run the scenes locally in a WebWorker.

We don't want developers to intervene with the internals of the engine or even need to know what lies inside the engine. We need to ensure a consistent experience for users throughout the Decentraland map, and mistakes are more likely to happen at that "low" level.

Because of this decoupling, your scene's code doesn't have access to the DOM or the `window` object, so you can't access data like the user's browser or geographical location.

<!--

## Taking Inspiration from React

One of the goals we had when designing our SDK was to reduce the learning curve as much as possible. We also wanted to incentive good practices and the writing of maintainable code, respecting the remote async-rpc constraints in every case.

To make a long story short, we were considering two approaches for doing this:

- **the jQuery way**: tell the system how to handle entities, create, mutate and try to reach a desired state.
- **the React way**: tell the system the desired state and let it figure out how to get there.

#### The _jQuery_ way

If we had chosen the jQuery way (which we didn't), the code needed to create our example scene would look like this:

{% raw %}

```ts
// WARNING: This code sample is only hypothetical,
// This is not valid syntax
// and is not supported by our tools

let scene = metaverse.createScene()
let objModel = metaverse.createObjModel()
let sphere = metaverse.createSphere()

objModel.setAttribute("src", "models/a.gltf")
objModel.appendTo(scene)

sphere.setAttribute("position", { x: 10, y: 10, z: 10 })
sphere.appendTo(scene)

EntityController.render(scene)
```

{% endraw %}

In this example, we're telling the system how to reach a desired state, the example (ab)uses mutations and
side effects of how the code works to reach the desired state.

#### The _React_ way

We chose to do things the [React](https://reactjs.org/) way, so our code for creating the same scene as above looks like this:

{% raw %}

```tsx
// IMPORTANT: This code is only an example, it does not exist nor work
 async render() {
   return (
    <scene>
      <obj-model src="models/a.gltf" />
      <sphere position={{ x: 10, y: 10, z: 10 }} />
    </scene>
  )
}
```

{% endraw %}

In this example, we're just telling the system the desired state, instead of describing all of the logic to get to that state.

We made our SDK following the React approach, for several reasons:

- It takes advantage of the evolution of web technologies that occurred in the past 10 years.
- It's simpler to understand, it removes tons of boilerplate code that's not related to the business logic of the scene.
- It's declarative. You describe **what** you want, not **how** you want that to happen.
- It helps onboard developers that are already familiar with React.
- The pattern is well known and well documented, getting help should be easy.
- It has a low memory footprint and it makes it easy to do garbage collection.

-->

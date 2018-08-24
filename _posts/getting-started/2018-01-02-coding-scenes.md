---
date: 2018-01-01
title: Coding scenes
description: This set will help you understand how things work in the client and SDK of decentraland.
redirect_from:
  - /documentation/introduction/
categories:
  - getting-started
type: Document
set: getting-started
set_order: 4
---

The content you deploy to your LAND is called a **scene**. A scene is an interactive program that renders content, this could be a game, an interactive experience, an art gallery, whatever you want!

## Supported languages and syntax

#### TypeScript (recommended)

We use [TypeScript (.tsx)](https://www.typescriptlang.org/docs/handbook/jsx.html)
to create our scenes.

TypeScript is a superset of JavaScript, so if you're familiar with JavaScript you'll find it's almost the same, but TypeScript allows you to employ object-oriented programming and type declarations. Features like autocomplete and type-checking speed up development times and allow for the creation of a solid codebase. These features are all key components to a positive developer experience.

In a Typescript scene, you handle the entities that are rendered in the scene as embedded XML assets. This works a lot like the [React](https://reactjs.org/docs/hello-world.html) framework.

> **Note:** Even though dynamic scenes are written in a way that intentionally looks a lot like React, **our SDK does not use React**.

See [TypeScript tips]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-08-tsx-coding-guide %}) for best practices and recommendations for writing Decentraland scenes using TypeScript.

#### XML

For scenes that only render montionless content and that won't be interactive, you can use [XML](https://en.wikipedia.org/wiki/XML).

When building your scene with the CLI, select the option _Static_.

We encourage developers to instead build their scenes using TypeScript. TypeScitp scenes use embedded XML tags to handle the rendered entities.

#### Other languages

You can use another tool or language instead of TypeScript and compile it to JavaScript, as long as your compiled scripts are contained within a single JavaScript file named _scene.js_. All provided type declarations are made in TypeScript, and other languages and transpilers are not officially supported.

## Code editors

To edit scenes, we recommend using a source code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Atom](https://atom.io/). An editor like this helps you create scenes a lot faster and with less errors, as it marks syntax errors, autocompletes while you write and even shows you smart suggestions that depend on the context that you're in. With Visual Studio Code you can even click on an object to see the full definition of its class.

## Entities and Components

Entities are the basic unit for building everything in Decentraland scenes, think of them as the equivalent of Elements in a DOM tree in web development.

Three dimensional scenes in Decentraland are based on the [Entity-Component](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) model, where everything in a scene is an _entity_, and each entity can include _components_ that shape its characteristics and functionality.

For example, you can include the `color` component on an entity to set its color, or include the `ignoreCollision` component to change how it responds to collisions with other entities.

An entity can have other entities as children, these inherit the components from the parent. If a parent entity is positioned, scaled or rotated, its children are also affected. Thanks to this, we can arrange entities into trees.

See [Entity interfaces]({{ site.baseurl }}{% post_url /sdk-reference/2018-06-21-entity-interfaces %}) for a reference of all the available constructors for predefined entities.

## The Render function

All [scene objects]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}) have a 'render()` method that outputs what users of your scene will see on their browser. This function must always output a hierarchical tree of entities that starts at the root level with a _scene_ entity.

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

If you have game development experience with other tools, you might expect to find some kind of render loop that periodically renders elements in the screen. Decentraland doesn't work like that. We built the API based on _events_, so the `render()` function is designed to update the scene in reaction to events rather than by querying the world repeatedly.

Scenes have a [state]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-04-scene-state %}), which is a collection of variables that change over time and represent the current disposition of the scene. The state changes by the occurance of [events]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-03-event-handling %}) in the scene. When the state changes, this retriggers the rendering of the scene, using the new values of the state.

## Scene Decoupling

Your scenes don't run in the same context as the engine
(a.k.a. the main thread), they might even not run in the same computer as the engine. We created the SDK in a way that is
entirely decoupled from the rendering engine. We designed it to be like this for both safety and performance reasons.

The decoupling works by using RPC protocol, this protocol assigns a small part of the client to only render the scene and control events.

We have also abstracted the communication protocol. This allows us to run the scenes both locally in a WebWorker and remotely in a Node.js server through WebSockets.

We don't want developers to intervene with the internals of the engine or even need to know what lies inside the engine. We need to ensure a consistent experience for users throughout the Decentraland map, and mistakes are more likely to happen at that "low" level.

#### Decoupling a scene from the engine

Let's take a look at an example. Suppose you want to render a scene with the following content:

{% raw %}

```tsx
<scene>
  <gltf-model src="models/a.gltf" />
  <sphere position={{ x: 10, y: 10, z: 10 }} />
</scene>
```

{% endraw %}

While writing your scene's code, you have no need to actually load the `a.gltf` model, and you don't need to know the geometry indexes used by the sphere entity. All you need to do is describe the scene at a higher level, like you do in XML.

Once the `render()` function sends this scene to the engine, the engine takes care of the positions, assets and geometries.

To optimize things, we only send the differences in the scene to the actual client. So if the scene has a shoal of
fish and only one of them moves, the SDK will send only that delta to the client, the fish that moved. This makes things faster for the client and is completely transparent to the developer of the scene.

## Taking Inspiration from React

One of the goals we had when designing our SDK was to reduce the learning curve as much as possible. We also wanted to incentive good practices and the writing of maintainable code, respecting the remote async-rpc constraints in every case.

To make a long story short, we were considering two approaches for doing this:

- **the jQuery way**: tell the system how to handle entities, create, mutate and try to reach a desired state.
- **the React way**: tell the system the desired state and let it figure out how to get there.

#### The _jQuery_ way

If we had chosen the jQuery way (which we didn't), the code we would have needed to create our example scene would look like this:

{% raw %}

```ts
// WARNING: This code sample is only a hypothetical example, it's not supported by our tools

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

We chose to do things the React way, so our code for creating the same scene as above looks like this:

{% raw %}

```tsx
// IMPORTANT: This code is only an example, it does not exist nor work

const scene = (
  <scene>
    <obj-model src="models/a.gltf" />
    <sphere position={{ x: 10, y: 10, z: 10 }} />
  </scene>
)

EntityController.render(scene)
```

{% endraw %}

In this example, we're just telling the system the desired state, instead of describing all of the logic to get to that state.

We made our SDK following the React approach, for several reasons:

- It takes advantage of the evolution of web technologies that occured in the past 10 years.
- It's simpler to understand, it removes tons of boilerplate code that's not related to the business logic of the scene.
- It's declarative. You describe **what** you want, not **how** you want that to happen.
- It helps onboard developers that are already familiar with React.
- The pattern is well known and well documented, getting help should be easy.
- It has a low memory footprint and it makes it easy to do garbage collection.

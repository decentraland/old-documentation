---
date: 2018-01-01
title: Introduction
description: This set will help you understand how things work in the client and SDK of decentraland.
categories:
  - documentation
type: Document
set: api-101
set_order: 1
---
Decoupling, it is all about decoupling. Your scenes doesn't run inside the main thread, or sometimes in the same
computer the client is running. We created the SDK in a way that is entirely decoupled from the rendering engine.
It works using a RPC protocol that controls a little part of the client only to render the scene and control the events.

## Decoupling the scene from the engine

Let's do it with an example, imagine you want to render a scene with the following shape

```xml
<scene>
  <obj-model src="a.obj" />
  <sphere position="10 10 10" />
</scene>
```

In your scene code, you have no need to actually load the `a.obj` model, you don't need to know the geometry indexes of
the sphere either. So, you describe the scene in a higher level, like it is an XML.

Then we need to send the scene to the engine and it will take care of the positions, assets and geometries.

To optimize things a little bit, we only send the differences in the to the actual client, so if you have a shoal of 
fishes and you move only one, the SDK will send only that delta, the moved fish. This makes things faster for the client
and it is completely transparent to the programmer of the scene.

## Removing code friction

One of the design goals of our SDK was to reduce the learning curve as much as possible, as well incentive good
practices and maintainable code, respecting the remote async-rpc constraints in any case. Roughly, we had two ways
to achieve this:

- **the jQuery way**: tell the computer how to handle entities, create, mutate and try to reach a desired state
- **the React way**: tell the computer the desired state

If we choose the jQuery way, our code to create the previous scene would look like this:

```ts
let scene = metaverse.createScene()
let objModel = metaverse.createObjModel()
let sphere = metaverse.createSphere()

objModel.setAttribute('src', 'a.obj')
objModel.appendTo(scene)

sphere.setAttribute('position', {x: 10, y: 10, z: 10})
sphere.appendTo(scene)

EntityController.render(scene)
```

In the previous example, we are telling the computer how to reach a desired state, we are (ab)using mutations and side
effects in code to reach that state.

```tsx
const scene =
  <scene>
    <obj-model src="a.obj" />
    <sphere position={ {x: 10, y: 10, z: 10} } />
  </scene>

EntityController.render(scene)
```

In the previous example, we are telling the computer the desired state, instead of all the logic to get that state.

We took advantage of the evolution of web technologies during the last 10 years and went for the React way, for several
reasons:

- It is simpler to understand, it removes tons of boilerplate code non related to the business logic of the scene
- It is descriptive, you describe **what** do you want, not **how**
- It will help onboard React developers
- The pattern is well known and well documented, getting help should be easy
- Low memory footprint and easy to do garbage collection

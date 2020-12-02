---
date: 2018-02-27
title: Raycasting
description: Use raycasting to trace a line in space and query for collisions with entities in the scene.
categories:
  - development-guide
type: Document
---

Raycasting is a fundamental tool in game development. With raycasting, you can trace an imaginary line in space, and query if any entities are intersected by the line. This is useful for calculating lines of sight, trajectories of bullets, pathfinding algorithms and many other applications.

When a player clicks or pushes the primary or secondary button, a ray is traced from the player's position in the direction they are looking, see [button events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}) for more details about this. This document covers how to trace an invisible ray from any arbitrary position and direction, independent of player actions, which you can use in many other scenarios.

## PhysicsCast

The `PhysicsCast` object is a static class that serves as the main raycasting interface. You can refer to it in your scene as `PhysicsCast.instance`. You'll see it has several methods that are all specific to raycasting.

```typescript
let physicsCast = PhysicsCast.instance
```

## Create a ray

A ray object describes the invisible ray that will be used to query for entities. Rays are defined using three bits of information:

- `origin`: _Vector3_ with the coordinates in scene space to start the ray from.
- `direction`: _Vector3_ describing the direction (as if the ray started from _0,0,0_).
- `distance`: _number_ to set the length with which this ray will be traced.

```typescript
let originPos = new Vector3(2, 1, 4)
let direction = new Vector3(0, 1, 1)

let ray: Ray = {
  origin: originPos,
  direction: direction,
  distance: 10,
}
```

As an alternative, you can also generate a ray from providing two points in space. Both the direction and distance will be implicit in this information. To do this, use the `getRayFromPositions()` method of the `PhysicsCast` object.

```typescript
let physicsCast = PhysicsCast.instance

let originPos = new Vector3(2, 1, 1)
let targetPos = new Vector3(2, 3, 3)

let rayFromPoints = physicsCast.getRayFromPositions(originPos, targetPos)
```

You can also get generate a ray from the player's current position and rotation. The only piece of information you need to pass in this case is the distance. To do this, use the `getRayFromCamera()` method of the `PhysicsCast` object.

```typescript
let physicsCast = PhysicsCast.instance

let rayFromCamera = physicsCast.getRayFromCamera(1000)
```

## Run a raycast query

Raycast queries are run by the `PhysicsCast` class. there are two methods available for doing this:

- `hitFirst()`: this method only returns the first hit entity, starting from the origin point.
- `hitAll()`: this method returns all hit entities, from the origin through to the length of the ray.

Both these methods need to be passed the following:

- a Ray object
- a callback function to execute after the query
- an optional raycast id, to handle separate lossy queues

<!--
![]({{ site.baseurl }}/images/media/raycast.png)
-->

Note that the callback function is always executed, even if no entities were hit by the ray.

This sample queries only for the first entity hit by the ray:

```typescript
let physicsCast = PhysicsCast.instance

let originPos = new Vector3(2, 1, 4)
let direction = new Vector3(0, 1, 1)

let ray: Ray = {
  origin: originPos,
  direction: direction,
  distance: 10,
}

physicsCast.hitFirst(
  ray,
  (e) => {
    log(e.entity.entityId)
  },
  0
)
```

This sample queries for all entities hit by the ray:

```typescript
let physicsCast = PhysicsCast.instance

let originPos = new Vector3(2, 1, 4)
let direction = new Vector3(0, 1, 1)

let ray: Ray = {
  origin: originPos,
  direction: direction,
  distance: 10,
}

physicsCast.hitAll(
  ray,
  (e) => {
    for (let entityHit of e.entities) {
      log(entityHit.entity.entityId)
    }
  },
  0
)
```

## Results from raycast query

After running a raycast query, the callback function will be able to use the following information from the event object:

- `didHit`: _boolean_ that is _true_ if at least one entity was hit, _false_ if there were none.
- `ray`: _Ray_ that has been used in the query
- `hitPoint`: _Vector3_ for the point in scene space where the hit occurred. If multiple entities were hit, it returns the first point of ray collision.
- `hitNormal`: _Vector3_ for the normal of the hit in world space. If multiple entities did hit, it returns the normal of the first point of ray collision.

- `entity`: _Object_ with info about the entity that was hit. This is returned when using `hitFirst()`, and it's only returned if there were any entities hit.
- `entities` : _Array of `entity` objects_, each with info about the entities that were hit. This is returned when using `hitAll()`, and it's only returned if there were any entities hit.

The `entity` object, and the objects in the `entities` array contain the following data:

- `entityId`: _String_ with the id for the hit entity
- `meshName`: _String_ with the internal name of the specific mesh in the 3D model that was hit. This is useful when a 3D model is composed of multiple meshes.

The example below shows how you can access these properties from the event object in the callback function:

```typescript
let physicsCast = PhysicsCast.instance

let originPos = new Vector3(2, 1, 4)
let direction = new Vector3(0, 1, 1)

let ray: Ray = {
  origin: originPos,
  direction: direction,
  distance: 10,
}

physicsCast.hitFirst(
  ray,
  (e) => {
    if (e.didHit) {
      engine.entities[e.entity.entityId].addComponentOrReplace(hitMaterial)
    }
  },
  0
)
```

> Tip: To reference an entity based on its ID, use the engine's `entities` array, like this: `engine.entities[e.entity.entityId]`.

The example below does the same, but dealing with an array of entities returned from the `hitAll()` function:

```typescript
let physicsCast = PhysicsCast.instance

let originPos = new Vector3(2, 1, 4)
let direction = new Vector3(0, 1, 1)

let ray: Ray = {
  origin: originPos,
  direction: direction,
  distance: 10,
}

physicsCast.hitAll(
  ray,
  (e) => {
    if (e.didHit) {
      for (let entityHit of e.entities) {
        engine.entities[entityHit.entity.entityId].addComponentOrReplace(
          hitMaterial
        )
      }
    }
  },
  0
)
```

## Recurrent raycasting

If your scene does raycasting on every frame via a [system]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}), then you should be careful about how it affects your scene's performance.

Both the `hitAll` and `hitFirst` methods have a third argument that takes a _raycast id_. All raycast queries that share a same id are handled in a lossy queue, so that if these requests pile up over time then only the latest one to arrive is processed. This can potentially save a lot of resources and makes your scene run a lot more smoothly.

In some cases you may want to have several separate raycast queries running at the same time, for example you might have a character that sends multiple rays in different directions to check for walls as it walks around. In these cases you should make sure that each raycast query has a separate id. Otherwise, if these different queries share a same id, the results of each might overwrite one another and valuable information will be lost on every frame.

```typescript
const Ray1 = { origin: Vector3.zero, direction: Vector3.Left() }
const Ray2 = { origin: Vector3.zero, direction: Vector3.Right() }
let id1: number = 0
let id2: number = 1

class RaycastSystem implements ISystem {
  update(dt: number) {
    PhysicsCast.instance().hitFirst(
      Ray1,
      (e) => {
        // Do stuff
      },
      id1
    )

    PhysicsCast.instance().hitFirst(
      Ray2,
      (e) => {
        // Do stuff
      },
      id2
    )
  }
}

engine.addSystem(RaycastSystem)
```

This example runs two raycast queries on every frame of the scene. Since they each have a different id, the requests from the first query and from the second query are handled on different queues that are independent from the other.

<!--

## Collide with the player

You can't directly hit the player with a ray, but what you can do as a workaround is position an entity occupying the same space as the player

would the entity's colliders bother?
-->

<!--

## Hit avatars


PhysicsCast.hitFirstAvatar( query:RaycastQuery,
			    hitCallback:(e:RaycastHitAvatar) => {} )

PhysicsCast.hitAllAvatars( query:RaycastQuery,
			  hitCallback:(e:RaycastHitAvatars) => {} )


## Cast a sphere


-->

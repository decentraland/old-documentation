---
date: 2018-02-27
title: Raycasting
description: Use raycasting to trace a line in space and query for collisions with entities in the scene.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 27
---

Raycasting is a fundamental tool in game development. With raycasting, you can trace an imaginary line in space, and query if any entities are intersected by the line.

This is useful for calculating lines of sight, trajectories of bullets, pathfinding algorithms and many other applications.

When a player clicks or pushes the primary or secondary button, a ray is traced from the player's position in the direction they are looking, see [button events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}) for more details about this. This document covers how to trace a ray from any arbitrary position and direction, which you can use in a wider set of scenarios.

## Create a raycast query

A raycast query is an object that stores the properties of the ray that will be traced.

There are two methods to set the ray of a raycast query 

- `setOriginTarget()`: takes two vectors, one for the origin point, the other for the target point. Origin and target are absolute coordinates in scene space.
- `setRay()`: takes an already constructed ray

```typescript
// Create a new raycast query
let query = new RaycastQuery()

// Set the ray with two vectors
query.setOriginTarget( new Vector3(0,0,0), new Vector3(1,1,1) )

// Set the ray by assigning a ray
let myRay = new ray(origin:Vector3.zero, direction:Vector3.one)
query.setRay(myRay)
```

You can also create and set a raycast query in a single line like this

```typescript
new RaycastQuery { ray:{origin:Vector3.zero, direction:Vector3.one} }
```

Ray.distance ????


## Run a raycast query

Raycast queries are run by the `PhysicsCast` class. This static class is home to the main raycasting interface. All physics casting methods receive queries in form of RaycastQuery objects. 

There are two methods available in the `PhysicsCast` class:

- `hitFirst()`: returns the first hit object
- `hitAll()`: returns all hit objects 


![](/images/media/raycast.png)



Only fist object

```typescript
let query = new RaycastQuery()

query.setOriginTarget( new Vector3(0,0,0), new Vector3(1,1,1) )

PhysicsCast.hitFirst( query, hitCallback:hitEntity )

function hitEntity( hit:RaycastHitEntity ) : void {
    //do X with entity
}
```

All objects

```typescript
let query2 = new RaycastQuery()


query2.setOriginTarget( new Vector3(0,0,0), new Vector3(1,1,1) )

PhysicsCast.hitAll( query2, hitCallback:hitEntities )

function hitEntities( hit:RaycastHitEntities ) : void {
    //do X with entities
}
```

This performs the cast defined in the provided query. hitCallback will come back with the first entity detected by the cast.

This performs the cast defined in the provided query. hitCallback will come back with all the entities detected by the cast.

One liner alternative:

```typescript
PhysicsCast.hitFirst( 
    new RaycastQuery { ray:{origin:Vector3.zero, direction:Vector3.one} }, 
    (entity)=> {
         // Do stuff
    } )

```


## Query results

After running a query, you'll get the following information


- `didHit`:boolean   Returns true if any entities were hit
- `ray`:Ray
- `hitPoint`:Vector3   Ray hit point in scene space—If multiple entities did hit, it returns the first point of ray collision.
- `hitNormal`:Vector3   Ray normal in world space using the hit geometry—If multiple entities did hit, it returns the normal of the first point of ray collision.

Optionally, if one or more entites were hit, you will also have an array?  made of this info

class HitEntityInfo
{
    entityId:string
    meshName:string
}

class RaycastHit
	This is the base class that serves as an argument for all PhysicsCast callbacks.




<!--

## Hit avatars


PhysicsCast.hitFirstAvatar( query:RaycastQuery, 
			    hitCallback:(e:RaycastHitAvatar) => {} )

PhysicsCast.hitAllAvatars( query:RaycastQuery, 
			  hitCallback:(e:RaycastHitAvatars) => {} )		


## Cast a sphere


-->
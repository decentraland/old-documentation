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

When a player clicks or pushes the primary or secondary button, a ray is traced from the player's position in the direction they are looking, see [button events]({{ site.baseurl }}{% post_url /development-guide/2018-02-3-click-events %}) for more details about this. This document covers how to trace a ray from any arbitrary position and direction, which you can use in a wider set of scenarios.

## The PhisicsCast object

PhysicsCast

This static class is home to the main raycasting interface. All physics casting methods receive queries in form of RaycastQuery objects. 




## Trace a ray


ray

setOriginTarget( origin:Vector3, target:Vector3 )
This sets the RaycastQuery ray to match the origin and target values. 
Origin and target are absolute coordinates in scene space.


setRay( ray:Ray )
This sets the ray as is.


class RaycastHit
	This is the base class that serves as an argument for all PhysicsCast callbacks.


	didHit:boolean
		Raycast did hit anything?


ray:Ray
	Ray used for casting


hitPoint:Vector3
Ray hit point in scene space—If multiple entities did hit, it returns the first point of ray collision.

hitNormal:Vector3
Ray normal in world space using the hit geometry—If multiple entities did hit, it returns the normal of the first point of ray collision.


## Query results

Hit multiple objects vs only the first:

```
PhysicsCast.hitFirst( query:RaycastQuery, 
			    hitCallback:(e:RaycastHitEntity) => {} )

PhysicsCast.hitAll( query:RaycastQuery, 
			  hitCallback:(e:RaycastHitEntities) => {} )
```

This performs the cast defined in the provided query. hitCallback will come back with the first entity detected by the cast.

This performs the cast defined in the provided query. hitCallback will come back with all the entities detected by the cast.

<!--

## Hit avatars


PhysicsCast.hitFirstAvatar( query:RaycastQuery, 
			    hitCallback:(e:RaycastHitAvatar) => {} )

PhysicsCast.hitAllAvatars( query:RaycastQuery, 
			  hitCallback:(e:RaycastHitAvatars) => {} )		


## Cast a sphere


-->
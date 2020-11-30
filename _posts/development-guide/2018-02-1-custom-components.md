---
date: 2018-01-15
title: Custom components
description: Create a custom component to handle specific data related to an entity
categories:
  - development-guide
type: Document
---

## Custom components

If you need to store information about an entity that isn't handled by the default components of the SDK (see [component reference](https://github.com/decentraland/ecs-reference) ), then you can create a custom type of component on your scene.

Tip: Custom components can be defined in your scene's `.ts` file, but for larger projects we recommend defining them in a separate `ts` file and importing them.

A component can store as many fields as you want.

```ts
@Component("wheelSpin")
export class WheelSpin {
  spinning: boolean
  speed: number
}
```

Note that we're defining two names for the component: `wheelSpin` and `WheelSpin` in this case. The _class name_, the one in upper case, is the one you use to add the component to entities. The _space name_, the one starting with a lower case letter, can mostly be ignored, except if you want to use it as an [Interchangeable component](#interchangeable-components).

Once defined, you can use the component in the entities of your scene:

```ts
// Create entities
const wheel = new Entity()
const wheel2 = new Entity()

// Create instances of the component
wheel.addComponent(new WheelSpin())
wheel2.addComponent(new WheelSpin())

// Set values on component
wheel.getComponent(WheelSpin).spinning = true
wheel.getComponent(WheelSpin).speed = 10
wheel2.getComponent(WheelSpin).spinning = false
```

Each entity that has the component added to it is instancing a new copy of it, holding specific data for that entity.

#### Constructors

Adding a constructor to a component allows you to configure its values in the same expression as you create an instance of it.

```ts
@Component("wheelSpin")
export class WheelSpin {
  spinning: boolean
  speed: number
  constructor(spinning: boolean, speed: number) {
    this.spinning = spinning
    this.speed = speed
  }
}
```

If the component includes a constructor, you can use the following syntax:

```ts
// Create entity
const wheel = new Entity()

// Create instance of component and set its values
wheel.addComponent(new WheelSpin(true, 10))
```

> Tip: If you use a source code editor, when instancing a component that has a constructor, you can see what the parameters are by mousing over the expression.

<!-- img -->

You can make the parameters optional by setting default values on each. If there are default values and you don't declare the parameters when instancing a component, it will use the default.

```ts
@Component("wheelSpin")
export class WheelSpin {
  spinning: boolean
  speed: number
  constructor(spinning?: boolean = false, speed?: number = 3) {
    this.spinning = spinning
    this.speed = speed
  }
}
```

```ts
// Create entity
const wheel = new Entity()

// Create instance of component with default values
wheel.addComponent(new WheelSpin())
```

#### Inheritance from other components

You can create a component that's based on an existing one and leverage all of its existing methods and fields.

The following example defines a _Velocity_ component, which inherits its fields and methods from the already existing _Vector3_ component.

```ts
@Component("velocity")
export class Velocity extends Vector3 {
  // x, y and z fields are inherited from Vector
  constructor(x: number, y: number, z: number) {
    super(x, y, z)
  }
}
```

#### Interchangeable components

Certain components intentionally can't coexist in a single entity. For example, an entity can't have both `BoxShape` and `PlaneShape`. If you assign one using `.addComponentOrReplace()`, you overwrite the other if present.

You can create custom components that follow this same behavior against each other, where it only makes sense for each entity to have only one of them assigned.

To define components that are interchangeable and that occupy a same _space_ in an entity, set the same name for both on the component's internal name:

```ts
@Component("animal")
export class Dog {
 (...)
}

@Component("animal")
export class Cat {
 (...)
}
```

In the example above, note that both components occupy the _animal_ space. Each entity in the scene can only have one _animal_ component assigned.

If you use `.addComponentOrReplace()` to assign a _Dog_ component to an entity that has a _Cat_ component, then the _Dog_ component will overwrite the _Cat_ component.

## Components as flags

You may want to add a component that simply flags an entity to differentiate it from others, without using it to store any data.

This is especially useful when using [Component groups]({{ site.baseurl }}{% post_url /development-guide/2018-02-2-component-groups %}). Since component groups list entities based on components they own, a simple flag component can tell entities apart from others.

```ts
@Component("myFlag")
export class MyFlag {}
```

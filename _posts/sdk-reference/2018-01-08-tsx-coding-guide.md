---
date: 2018-01-08
title: TypeScript coding guide
description: Tips and tricks for coding scenes
categories:
  - documentation
type: Document
set: sdk-reference
set_order: 8
---

The Decentraland SDK is meant to be used via TypeScript (.tsx) files. This section introduces a number of tips and tricks you can take advantage of when building your scene. What's discussed here isn't directly related to the features of the SDK, but rather about ways in which you can use the TypeScript language and context to make the most out of it.

## Log to Console

You can log messages to the JavaScript console of the browser while viewing a scene.

You don’t need to import any additional libraries to do this, simply write `console.log()` in any part of your scene.tsx file. You can use log messages, for example, to confirm the occurrence of events, or to verify that the value of a variable changes in the way you expected.

{% raw %}

```tsx
this.subscribeTo("pointerDown", e => {
  console.log("click")
})
```

{% endraw %}

To view logged messages while running a preview of your scene, look at the JavaScript console, which you can open in the developer settings of your browser.

![](/images/media/console_log.png)

## Create a global constant

You can define global constants at the root level of a _.tsx_ file. Once defined, they can be referenced throughout the entire file.

This is useful for values that are used multiple times in your scene and need to have consistency. This makes it easier to maintain your code, as you only need to change one line.

{% raw %}

```tsx
import { createElement, ScriptableScene } from "decentraland-api"

const updateRate = 300
const myColors = [
  "#3d9693",
  "#e8daa0",
  "#968fb7",
  "#966161",
  "#879e91",
  "#66656b",
  "#6699cc"
]

export default class myScene extends ScriptableScene {
  state = {
    interval: updateRate,
    boxColor: myColors[1],
    doorColor: myColors[4]
  }

  // (...)
}
```

{% endraw %}

## Define an enum

TypeScript allows you to define custom string enums. They are useful for assigning to variables that are only allowed to hold certain specific values in your scene.

Using string enums makes your code more readable. If you’re working with an advanced code editor like Visual Studio Code or Atom, it also makes writing your code easier, since the code editor provides autocomplete options and validation.

For example, the example below defines a custom enum with three possible values. It then uses the enum as a type for a variable when defining an interface for the scene state.

{% raw %}

```tsx
export enum Goal {
  Idle,
  Walk,
  Sit
}

export interface IState {
  dogGoal: Goal
  dogPosition: Vector3Component
  catGoal: Goal
  catPosition: Vector3Component
}
```

{% endraw %}

Each time you want to refer to a value in an enum, you must write it as `<enum name>.<value>`. For example, `Goal.Walk` refers to the `Walk` value, from the `Goal` enum.

{% raw %}

```tsx
  if (this.state.dogGoal == Goal.Walk){
   this.setState(catGoal: Goal.Sit)
  }
```

{% endraw %}

Your code editor suggests the possible values for the enum as soon as you refer to it, making your scene easier to write.

![](/images/media/autocomplete_enum.png)

## Define custom data types

Defining a custom type has similar advantages to defining an enum, but is a bit less verbose and you might find its syntax more familiar, depending on what coding languages you're more experienced in using.

{% raw %}

```tsx
export type characterState = "walking" | "won" | "falling"
```

{% endraw %}

The custom type defined above can only hold the three possible values listed above. You can then use it, for example, for a variable in the scene state.

{% raw %}

```tsx
state = {
  characterNow: (characterState = "walking")
}
```

{% endraw %}

## Scene state interfaces

The scene state object can be defined as a type of its own. This ensures that the state object always has the right variables and that they all have valid values for their corresponding types. If you’re working with an advanced code editor like Visual Studio Code or Atom, defining a state interface helps your editor provide type validation and smart auto-completes.

{% raw %}

```tsx
interface IState {
  doorState: boolean
  boxes: number
  userPos: Vector3Component
}
```

{% endraw %}

Once you defined an interface, you can pass it to the custom scene class as the second argument, which sets the type for the scene's state object.

{% raw %}

```tsx
export default class ArtPiece extends ScriptableScene<any, IState> {
  state = {
    pedestalColor: "#3d30ec",
    dogAngle: 0,
    donutAngle: 0
  }

  // (...)
}
```

{% endraw %}

## Import external libraries

You can import most any JavaScript library to your _scene.tsx_ file. Use external libraries to help you with advanced mathematical operations, call APIs, run predefined AI scripts or whatever your scene needs.

For example, this line imports quaternion and vector types from Babylonjs.

{% raw %}

```tsx
import { Vector3, Quaternion } from "babylonjs"
```

{% endraw %}

For most 3D math operations, we recommend importing [Babylonjs](https://www.babylonjs.com/), because much of Decentraland's SDK uses it, making compatibility safer. Other libraries with similar capabilities are available too and can also be imported.

Before a library can be used by your scene, it must be installed with _npm_ in the scene's folder. This is important because when the scene is deployed to Decentraland, all of its dependencies must be uploaded as well.

When importing from large libraries like Babylonjs, we recommend only ipmporting the elements that you need for your scene, instead of importing the entire library.

## Vector math operations

Vectors in decentraland are of type _Vector3Component_, this type is very lightweight and doesn't include any methods.

To avoid doing vector math manually, we recommend importing the _Vector3_ type from Babylonjs. This type comes with a lot of handy operations like scaling, substracting and more.

To use this, you must first install babylonjs in the project folder. Run the following command from a terminal in the scene's main folder.

```bash
npm install babylonjs
```

You can then import elements of the Babylon js library into your scene's _.tsx_ files.

{% raw %}

```tsx
import { Vector3 } from "babylonjs"
```

{% endraw %}

Once imported to your _.tsx_ file, you can assign the _Vector3_ type to any variable. Variables of this type will then have access to all of the type methods.

The example below deals with _Vector3_ variables and a few of the functions that come with this type.

{% raw %}

```tsx
moveToGoal(){
  const delta = this.state.goalPosition.subtract(this.state.dogPosition)
  delta = delta.normalize().scale(.015)
  this.setState(dogPosition: this.state.dogPosition.add(delta))
}
```

{% endraw %}

Entities in decentraland accept variables of type _Vector3_ for setting position, rotation and scale. There's no need to convert a variable to _Vector3Component_ type when applying it to an entity.

Keep in mind that some events in a Decentraland scene, like the `positionChanged` event, have attributes that are of type _Vector3Component_. If you wish to use methods from _Vector3_ on this information, you must first change its type.

## Access data accross objects

When your scene reaches a certain level of complexity, it's convenient to break the code out into several separate objects instead of having all of the logic inside the [`scriptableScene` class]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}).

The downside is that information becomes harder to pass on. If all of your logic occurs inside the `scriptableScene` class, you can keep track of all information using the [scene state]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-04-scene-state %}) and scene properties. But if that's not the case, then you must keep in mind that you can't reference the scene state or scene properties from outside the `scriptableScene` class.

You can eitehr:

- Pass information from the main `scriptableScene` class as properties of child objects.
- Use a library like [Redux](https://redux.js.org/) to create a univesal data store that can be referenced from anywhere.

See [scene state]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-04-scene-state %}) for more details.

## Execution timing

TypeScript provides various ways you can control when parts of your code are executed.

The scriptableScene object comes with a number of default functions that are executed at different times of the scene life cycle, for example `sceneDidMount()` is called once when the scene starts and `render()` is called each time the that the scene state changes. See [scriptable scene]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-05-scriptable-scene %}) for more information.

Entities can include a _transition_ component to make any changes occur gradually, this works very much like transitions in CSS. See [scene content guide]({{ site.baseurl }}{% post_url /sdk-reference/2018-01-21-scene-content-guide %}) for more information.

#### Start a time-based loop

The `setInterval()` function initiates a loop that executes a function repeatedly at a set interval

{% raw %}

```tsx
setInterval(() => {
  this.setState({ randomNumber: Math.random() })
}, 1000)
```

{% endraw %}

This sample initiates a loop that sets a `randomNumber` variable in the scene state to a new random number every 1000 milliseconds.

#### End a loop

The `setInterval()` function returns an id for the loop, you can terminate the execution of this loop by running the `clearInterval()` function, passing it the loop's id.

{% raw %}

```tsx
  let count = 0
  const loopId = setInterval(() => {
    count += 1
    console.log(count)
    if (count === 5) {
      clearInterval(loopId)
    }
  }
```

{% endraw %}

This example iterates over a loop until a condition is met, in which case `clearInterval()` is called to stop the loop.

#### Delay an execution

The `setTimeout()` function delays the execution of a statement or function.

{% raw %}

```tsx
setTimeout(f => {
  console.log("you'll have to wait for this message")
}, 3000)
```

{% endraw %}

The setTimeout function requires that you pass a function or statement to execute, followed by the ammount of milliseconds to delay that execution.

#### Freeze till complete

Adding `await` at the start of a statement stops all execution of the current thread until that statement returns a value.

{% raw %}

```tsx
await this.runImportantProcess()
```

{% endraw %}

In this example, execution of the thread is delayed until the function `runImportantProcess()` has returned a value.

When needing to store the value of the return statement, the `await` goes after the equals sign like this:

{% raw %}

```tsx
const importantValue = await this.runImportantProcess()
```

{% endraw %}

`await` can only be used within the context of an async function, as otherwise it would freeze the main thread of execution of the scene, which is never desirable.

If you're familiar with C# language, you'll see that asyncrhonous functions in TypeScript behave just the same. Functions run synchronously by default, but you can make them run asynchronously by adding `async` before the name when defining them.

> Tip: If you want to understand the reasoning behind JavaScript promises, async and await, we recommend reading [this article](https://zeit.co/blog/async-and-await).

## Handle arrays in the scene state

There are a number of things you need to take into account when working with arrays that belong to the scene state of a Decentraland scene.

Since you must always update the scene state through the method `.setState()`, you can't just use array methods like `.push()` or `pop()` that would change this variable directly. You must call `setState()` to pass it the full array you want to have after implementing the change.

If you're making a copy of an array that's meant to be modified, make sure you're cloning it entirely and not merely referencing its values. Otherwise changes to that array will also affect the original. To copy an array's values rather than the array itself, use the _spread operator_ (three dots).

{% raw %}

```tsx
const newArray = [...this.state.myArray]
```

{% endraw %}

#### Add to an array

This example adds a new element at the end of the array:

{% raw %}

```tsx
this.setState({ myArray: [...this.state.myArray, newValue] })
```

{% endraw %}

This example adds a new element at the at the start of the array:

{% raw %}

```tsx
this.setState({ myArray: [newValue, ...myArray.state.list] })
```

{% endraw %}

#### Update an element on an array

This example changes the value of the element that's at `valueIndex`:

{% raw %}

```tsx
this.setState({
  myArray: [
    ...this.state.myArray.slice(0, valueIndex),
    newValue,
    ...this.state.myArray.slice(valueIndex + 1)
  ]
})
```

{% endraw %}

#### Remove from an array

This example pops the first element of the array, all other elements are shifted to fill in the space.

{% raw %}

```tsx
const [_, ...rest] = this.state.list
this.setState({ list: [...rest] })
```

{% endraw %}

This example removes the last element of the array:

{% raw %}

```tsx
const [...rest, _] = this.state.list
this.setState({ list: [...rest] })
```

{% endraw %}

This example removing all elements that match a certain condition. In this case, that their `id` matches the value of the variable `toRemove`.

{% raw %}

```tsx
this.setState({ myArray: ...myArray.state.list.filter(x => x.id === toRemove) })
```

{% endraw %}

#### The map operation

There are two array methods you can use to run a same function on each element of an array separately: `map()` and `forEach()`. The main difference between them is that `map()` returns a new array without affecting the original array, but `forEach()` can overwrite the values in the original array.

The `map()` operation runs a function on each element of the array, it returns a new array with the results.

{% raw %}

```tsx
renderLeaves(){
  return this.state.fallingLeaves.map((leaf, leafIndex) =>
    <plane
      position={{ x: leaf.x , y: leaf.y, z:leaf.z }}
      scale={0.2}
      key={"leaf" + leafIndex.toString()}
    />
  )
}
```

{% endraw %}

This example goes over the elements of the `fallingLeaves` array running the same function on each. The original array is of type _Vector3Component_ so each element in it has values for _x_, _y_ and _z_ coordinates. The function that runs for each element returns a plane entity that uses the position stored in the array and has a key based on the array index.

#### Combine with filter

You can combine a `map()` or a `forEach()` operation with a `filter()` operation to only handle the array elements that meet a certain criteria.

{% raw %}

```tsx
renderLeaves(){
  return this.state.fallingLeaves
    .filter(pos => pos.x > 0)
    .map( (leaf, leafIndex) =>
      <plane
        position={{ x: leaf.x , y: leaf.y, z: leaf.z }}
        scale={0.2}
        key={"leaf" + leafIndex.toString()}
      />
    )
}
```

{% endraw %}

This example is like the one above, but it first filters the `fallingLeaves` array to only handle leaves that have a _x_ position greater than 0. The `fallingLeaves` array is of type _Vector3Component_, so each element in the array has values for _x_, _y_ and _z_ coordinates.

#### The forEach operation

The `forEach()` operation runs a same function on every element of the array.

{% raw %}

```tsx
renderLeaves() {
  var leaves: ISimplifiedNode[] = []

  this.state.fallingLeaves.forEach( (leaf,leafIndex) => {
    leaves.push(
      <plane
        position={{ x: leaf.x, y: leaf.y, z: leaf.z }}
        scale={0.2}
        key={"leaf" + leafIndex.toString()}
      />
    )
  })

  return leaves
}
```

{% endraw %}

Like the example used to explain the map operator above, this example goes over the elements of the `fallingLeaves` array running the same function on each. The original array is of type _Vector3Component_ so each element in it has values for _x_, _y_ and _z_ coordinates. The function that runs for each element returns a plane entity that uses the position stored in the array.

The function performed by the `forEach()` function doesn't have a `return` statement. If it did, it would overwrite the content of the `this.state.fallingLeaves` array. Instead, we create a new array called `leaves` and push elements to it, then we return the full array that at the end.

As you can see from comparing this example to the prevous ones , it's a lot simpler to use `map()` to render entities from a list.

> Note: Keep in mind that when dealing with a variable from the scene state, you can't change its value by setting it directly. You must always change the value of a scene state variable through the `this.setState()` operation.

## Make the render function dynamic

The `render()` function draws what users see in your scene. In its simplest form, its `return` statement contains what resembles a literal XML definition for a set of entities with fixed values. An essential part of making a scene interactive is to have the render function change its output in response to changes in the scene state.

Although what's typically in the `return` statement of render() may resemble pure XML, everything that goes in between `{ }` is being processed as TypeScript. This means that you can interrupt the tag and attribute syntax of XML with curly brackets to add JSX logic anywhere you choose.

#### Reference variables from render

The simplest way to change how something is rendered is to reference the value of a variable from the value of one of the XML attributes.

{% raw %}

```tsx
async render() {
  return (
    <scene>
      <box
        color= {this.state.boxColor}
        scale={this.state.boxSize}
      />
    </scene>
  )
}
```

{% endraw %}

#### Add conditional logic to render

Another simple way to make render() respond to changes in variables is to add conditional logic.

{% raw %}

```tsx
async render() {
  return (
    <scene>
      {this.state.boxOrSphere == sphere
        ?<sphere />
        :<box />
      }
    </scene>
  )
}
```

{% endraw %}

In the example above, the render function either returns a box or a sphere depending on the value of a `boxOrSphere` variable. Note that we needed to wrap the entire conditional expression in `{ }` for it to be processed correctly as TypeScript.

{% raw %}

```tsx
async render() {
  return (
    <scene>
      <box
          position={{x: 2, y: this.state.liftBox ? 5:0 , z:1}}
          transition={{ position:
            { duration: 300, timing: this.state.bounce? "bounce-in" : "linear" }
          }}
      />  
    </scene>
  )
}
```

{% endraw %}

In this second example, the _y_ position of the box is determined based on the value of `liftBox` and the timing of its transition is based on the value of `bounce`. Note that both of these conditional expressions were added in parts of the code that were already being processed as TypeScript, so no aditional `{ }` were needed.

#### Define an undetermined number of entities

For scenes where the number of entities isn't fixed, use an array to represent these entities and their attributes and then use a `map()` operation within the `render()` function.

{% raw %}

```tsx
async render() {
  return (
    <scene>
      { this.state.secuence.map(num =>
        <box
          position={{ x: num * 2, y: 1, z: 1 }}
          key={"box" + num.toString()}
        />
      }
    </scene>
  )
}
```

{% endraw %}

This function uses a `map()` operation to create a box entity for each element in the `secuence` array, using the numbers stored in this array to set the x coordinate of each of these boxes. This enables you to dynamically change how many boxes appear and where by changing the `secuence` variable in the scene state.

A few best practices when rendering entities from a list:

- Use `array.map` to go over the list
- Don't use a `for` loop
- Give each entity a unique `key`
- Avoid using the array index as the entity key

#### Keep the render function readable

The output of the render() function can include calls to other functions. Since render() is called each time that the scene state is updated, so will all the functions that are called by render().

Doing this keeps the code in render() more readable. In simple scenarios it's mostly reocomendable to define all the entities of the scene within the `render()` function, but when dealing with a varying number of entities or a large number that can be treated as an array, it's often useful to handle this behavior in a function outside render().

{% raw %}

```tsx
async render() {
  return (
    <scene>
      {this.renderObstacles()}
      {this.renderFruit()}
      {this.status.difficulty === 'hard' ?
        this.renderHardEnemies()
        : this.renderEasyEnemies()
      }
    </scene>
  )
}
```

{% endraw %}

The functions that are called as part of the return satement must, of course, return values that combine well with the rest of what's being rendered to produce a valid XML output. In the example above, the `renderObstacles()` function can contain the following:

{% raw %}

```tsx
renderObstacles() {
  return this.state.secuence.map(num =>
    <box
      position={{ x: num * 2, y: 1, z: 1 }}
    />
  )
}
```

{% endraw %}

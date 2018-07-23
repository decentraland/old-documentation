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
        console.log(“click”);
   }); 
```
{% endraw %}

To view logged messages while running a preview of your scene, look at the JavaScript console, which you can open in the developer settings of your browser.

![](/images/media/console_log.png)


## Create a global constant

You can define global constants at the root level of a *.tsx* file. Once defined, they can be referenced throughout the entire file.

This is useful for values that are used multiple times in your scene and need to have consistency. This makes it easier to maintain your code, as you only need to change one line.


{% raw %}
```tsx
import { createElement, ScriptableScene  } from 'metaverse-api';

const updateRate = 300;
const myColors = ["#3d9693", "#e8daa0", "#968fb7", "#966161", "#879e91", "#66656b", "#6699cc"];

export default class myScene extends ScriptableScene{
    state: {
        interval: updateRate,
        boxColor: myColors[1],
        doorColor: myColors[4]
    }
```
{% endraw %}

## Define custom data types

You can define your own custom data type in a *.tsx* file, these are useful for using with variables that are only capable of holding certain values in your scene. Using custom types makes your code more readable. If you’re working with an advanced code editor like Visual Studio Code or Atom, it also makes writing your code easier since the code editor provides autocomplete options and validation.

{% raw %}
```tsx
export type characterState = 'walking' | 'won' | 'falling'
```
{% endraw %}

The custom type defined above can only hold the three possible values listed above. You can then use it, for example, for a variable in the scene state.

{% raw %}
```tsx
state = {
	characterNow : characterState = ‘walking’
}
```
{% endraw %}

When setting a value for this variable, your code editor will now suggest only the valid values for its type.

![](/images/media/autocomplete_types.png)


<!---

## Define a custom enum  ???

With TypeScript, you can create custom string enums. These can be thought of as dictionaries that can only contain specific string fields.

https://blog.decentraland.org/building-a-memory-game-using-decentralands-sdk-87ee35968f8d



{% raw %}
```tsx
export enum characterStates {
	
}
```
{% endraw %}

[definition]

You can then set this type as the type of a variable

[scene state definition that sets this as a type]

When using that variable, the code editor then 
[screenshot]
-->

## Scene state interfaces

The scene state object can be defined as a type of its own. This ensures that the state object always has the right variables and that they all have valid values for their corresponding types. If you’re working with an advanced code editor like Visual Studio Code or Atom, defining a state interface helps your editor provide type validation and smart auto-completes.

{% raw %}
```tsx
interface IState {
    doorState:true,
    boxes: number,
    userPos : vector3Component
}
```
{% endraw %}

Once you defined an interface, you can pass it to the custom scene class as the second argument, which sets the type for the scene's state object.

{% raw %}
```tsx
export default class ArtPiece extends ScriptableScene <any, IState>{

state = {
 pedestalColor : "#3d30ec",
 dogAngle:0,
 donutAngle:0
}

(...)
}
```
{% endraw %}

<!---

## Advanced 3D math operations

You can import javascript libraries to enable you to perform mathematical operations that the SDK doesn’t cover. For example, for vector operations, you can import

  babylon's library. only

## Accessing variables globally

When having the code for your scene distributed amongst multiple separate files with child objects, you need to take care of how to reference 

-->

## Handle all elements of an array

There are two array methods you can use to run a same function on each element of an array separately: `map` and `forEach`. The main difference between them is that `map` returns a new array without affecting the original array, but `forEach` can overwrite the values in the original array.


### The map operation

The`map` operation runs a function on each element of the array, it returns a new array with the results.

{% raw %}
```tsx
renderLeaves(){
  return renderedLeaves = this.state.fallingLeaves.map( leaf=>{
      return <plane 
              position={{x:leaf.x , y: leaf.y, z:leaf.z}}
              scale={0.2}  
              />
    }
    )
}
```
{% endraw %}

This example goes over the elements of the `fallingLeaves` array running the same function on each. The original array is of type `vector3Component` so each element in it has values for *x*, *y* and *z* coordinates. The function that runs for each element returns a plane entity that uses the position stored in the array.



### Combine with filter array

You can combine a `map` or a `forEach` operation with a `filter` operation to only handle the array elements that meet a certain criteria.

{% raw %}
```tsx
renderLeaves(){
 return renderedLeaves = this.state.fallingLeaves
  .filter(pos => pos.x >0 )
  .map( leaf=>{
      return <plane 
              position={{x:leaf.x , y: leaf.y, z:leaf.z}}
              scale={0.2}  
              />
    })
}
```
{% endraw %}

This example is like the one above, but it first filters the `fallingLeaves` array to only handle leaves that have a *x* position greater than 0. The `fallingLeaves` array is of type `vector3Component`, so each element in the array has values for *x*, *y* and *z* coordinates.


### The forEach operation

The `forEach` operation runs a same function on every element of the array.


{% raw %}
```tsx
renderLeaves()
{
  var leaves:ISimplifiedNode[] = [];
  this.state.fallingLeaves.forEach( leaf=>{
      leaves.push( <plane 
                    position={{x:leaf.x , y: leaf.y, z:leaf.z}}
                    scale={0.2}  
                    />
       );
    });
    return leaves;
}
```
{% endraw %}

Like the example used for the map operator, this example goes over the elements of the `fallingLeaves` array running the same function on each. The original array is of type `vector3Component` so each element in it has values for *x*, *y* and *z* coordinates. The function that runs for each element returns a plane entity that uses the position stored in the array.
 
The function performed by the `ForEach()` function doesnt' have a `return` statement. If it did, it would overwrite the content of the `this.state.fallingLeaves` array. Instead, we create a new array called `leaves` and push elements to it, then we return the full array that at the end.

> Note: Keep in mind that when dealing with a variable from the scene state, you can't change its value by setting it directly. You must always change the value of a scene state variable through the `this.setState()` operation.


## Keep the render function readable

The output of the render() function can include calls to other functions. Since render() is called each time that the scene state is updated, so will all the functions that are called by render().

Doing this keeps the code in render() more readable. In simple scenarios it's mostly reocomendable to define all the entities of the scene within the `render()` function, but when dealing with a varying number of entities or a large number that can be treated as an array, it's often useful to handle this behavior in a function outside render(). 

{% raw %}
```tsx

  async render() {
    return (
      <scene>
        {this.renderObstacles()}
        {this.renderFruit()}
        {this.renderEnemies()}
      </scene>
    )
  }
```
{% endraw %}

The functions that are called as part of the return satement must, of course, return values that combine well with the rest of what's being rendered to produce a valid XML output. In the example above, the `renderObstacles()` function can contain the following:

{% raw %}
```tsx
 renderObstacles() {
    return this.state.secuence.map( num=>
            {return <box 
                      position={{x:num, y:1, z:1}}
                      scale={0.5}
                      withCollisions={true} 
                      />
            })
    ))
  }
```
{% endraw %}

This function uses a `map` operation to create a box entity for each element in the `secuence` array, using the numbers stored in this array to set the x coordinate of each of these boxes. This doesn't only shorten the code, it enables you to dynamically change how many boxes appear and where by changing the `secuence` variable in the scene state.


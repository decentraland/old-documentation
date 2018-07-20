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

The Decentraland SDK is meant to be used with TypeScript. There are a number of tips and tricks you can take advantage of when building your scene, these don’t relate directly to the SDK, but they are part of the context and tools that are available to you.


## Log to Console

You can log messages to the JavaScript console of the browser while viewing a scene.

You don’t need to import any special libraries, simply write console.log() in any part of your scene.tsx file. You can use log messages, for example, to confirm the occurrence of events, or to verify that the value of a variable changes in the way you expected.

{% raw %}
```tsx
 this.subscribeTo("pointerDown", e => {
        console.log(“click”);
   }); 
```
{% endraw %}

To view the logged messages while running a preview of your scene, you need to look at your browser’s JavaScript console, which you can open in the developer settings of your browser.

[screenshot]

## Create a global constant

You can define global constants at the root level of a .tsx file. Once defined, they can be referenced throughout the entire file.

This is useful for values that are used multiple times in your scene and need to be used consistently. This makes it easier to maintain your code, as you only need to change one line and be sure that all the code will be adjusted consistently.


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

You can define your own custom data type, these are useful for using with variables that can only capable of having certain values in your scene. Using these makes your code more readable, and it’s better than setting the variable as a string because the code editor you use provides autocomplete options and validation.

{% raw %}
```tsx
export type characterState = 'walking' | 'won' | 'falling'
```
{% endraw %}

The custom type defined above can only have the three possible values listed above. You can then use it, for example, for a variable in the scene state.

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

## Define a custom enum type ???

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
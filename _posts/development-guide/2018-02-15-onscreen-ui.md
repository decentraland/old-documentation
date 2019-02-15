---
date: 2018-02-15
title: Onscreen UI
description: Learn how to create a UI for users in your scene. This is useful, for example, to display game-related information.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 15
---


There are several special component types that are meant for using in a 2D screen space as part of the UI, instead of in the 3D world space. These components are displayed fixed on the user's screen when the user clicks the _open UI_ button, on the top-right corner of the screen.

UI elements are only visible when the user is standing inside the scene's LAND parcels, as neighboring scenes might have their own UI to display.

UIs in Decentraland aren't designed to provide constant feedback while a game takes place, but rather to be used as a screen to access occasionally, to get information or take decisions. This is ideal for displaying an inventory or to prompt users to make decisions.

The UI can also be triggered to open when certain events occur in the world-space, for example if the user clicks on a specific place.


## Add a Screenspace UI

To add a screenspace UI to your scene, you must create an entity and add a `UIScreenSpaceShape` component to it. All the visible UI elements that you want the user to see must be added as children of this `UIScreenSpaceShape` component.

![](/images/media/UI-basic.png)


```ts
// Create entity
const ui = new Entity()

// Create screenspace component
const screenSpaceUI = new UIScreenSpaceShape()

// Add screenspace component to entity
ui.set(screenSpaceUI)

// Add entity to engine
engine.addEntity(ui)

// Create a textShape component, setting the screenspace component as parent
const textShape = new UITextShape(screenSpaceUI)
textShape.value = 'Hello world!'
```


When creating any UI component, the first argument on the constructor sets the component's parent. In this case, we assign the `UIScreenSpaceShape` component we created as the parent. 



## Types of UI content

There are several different types of UI elements you can add to the screenspace:


- Images: Add a `UIImageShape` component to display any image. Use the `source` field to point to the path of the image.

- Text: Add a `UITextShape`component to display text. The properties you can set are the same as in a `TextShape` component.  See link
(also add section to that doc)

- Buttons: Add a `UIButtonShape` to add a clickable button. The button offers some visual feedback when users mouse over it and when they click it.

- Text input box: Add a `UIInputTextShape` to have an input box where users can type in text with their keyboards.

- Slider: Add a `UISliderShape` to have a slider that users can drag to provide input.


## Positioning

All UI components have several fields you can set to determine the position of the component on the screenspace.

- `hAlign` horizontal alignment relative to the parent. Possible values: `Top`, `Botton`, `Center`.

- `vAlign` horizontal alignment relative to the parent. Possible values: `Left`, `Right`, `Center`.


- `paddingLeft`, `paddingRight`, `paddingTop`, `paddingBottom`: padding space to leave empty around. This can either be set in pixels or as a percentage of the parent's width. To set in pixels, use `100 px`. To set in percentage use `10 %`

- `zIndex`: The z value determines what is shown in front when two components overlap in the screenspace. 


- `with`, `height`: Set the size of the component in the screen. This can either be set in pixels or as a percentage of the parent's width. To set in pixels, use `100 px`. To set in percentage use `10 %`


- `adaptWidth`, `adaptHeight`: Set on parent components. If these are set to true, the width and height wrap the child comopnents (plus padding). If these are true, `width` and `height` values are ignored

```ts
const message = new UITextShape(container)
message.text = 'Close UI'
message.fontSize = 15
message.width = '120px'
message.height = '30px'
message.vAlign = 'bottom'
message.top = '-80px'
message.zIndex = 1
```

## Use parent elements for organizing

Certain UI components are there to help you organize how you place other components.

![](/images/media/UI-rectangle.png)

For this, you can use the `UIContainerStackShape` and the `UIContainerRectShape`.

Both these shapes have properties to set their color, line thickness, and rounded corners.

```ts
const inventoryContainer = new UIContainerStackShape(container)
inventoryContainer.adaptWidth = true
inventoryContainer.width = '40%'
inventoryContainer.top = '100px'
inventoryContainer.left = '10px'
inventoryContainer.color = 'white'
inventoryContainer.background = 'blue'
inventoryContainer.hAlign = 'left'
inventoryContainer.vAlign = 'top'
```


## Set alpha

You can make a UI element partly transparent by setting its `opacity` property.


```ts
const container = new UIContainerRectShape(screenSpaceUI)
container.width = '100%'
container.height = '100%'
container.color = 'blue'
container.opacity = 0.5
```


## Clicking UI elements


The UI elements on the screenspace can also be interactive, instead of just showing information.

As click events are handled per entity, you must create a separate entity for each UI component that you want to make clickable. If you add multiple UI components to a single clickable entity, you won't be able to distinguish which of the components was clicked. 

![](/images/media/UI-clicks.png)

All of the UI components must be children of a single `UIScreenSpaceShape` component. Even components that are added to different entities must be instantiated as children of a `UIScreenSpaceShape` component. 



```ts
const button = new UIButtonShape(container)
button.text = 'Close UI'

close.set(button)
engine.addEntity(close)
```

> Note: If PC users want to click on a UI component, they must first unlock themselves from the view control, in order to be able to move the cursor over the UI component.

To handle the clicks, add an `OnClick()` component to the entity, just as you do with world-space entities.

```ts
const button = new UIButtonShape(container)
button.text = 'Close UI'
button.fontSize = 15
button.color = 'black'
button.background = 'yellow'
button.cornerRadius = 10
button.thickness = 1
button.width = '120px'
button.height = '30px'
button.vAlign = 'bottom'
button.top = '-80px'

const close = new Entity()
close.set(
  new OnClick(() => {
    log('clicked on the close image')
    screenSpaceUI.visible = false
  })
)
close.set(button)
engine.addEntity(close)
```






## Sliders

Sliders can be added to the UI to provide more interaction. Users can click and drag sliders to set a value. 

You can configure various aspects of the slider, including its appearance, orientation, what the maximum and minimum values represent, its default value, etc.

```ts

const slider1 = new Entity()
const volumeSlider = new UISliderShape(container)
volumeSlider.minimum = 0
volumeSlider.maximum = 10
volumeSlider.color = '#fff'
volumeSlider.value = 0
slider1.set(sliderShape1)
engine.addEntity(slider1)

```

The slider's clickable space is very small by default, so it can be tricky to click with the cursor directly over it. To help make it easier, you can set the `thumbWidth`, `isThumbCircle` and `isThumbClamped` properties. The `thumbWidth` property is set in pixels.

```ts
volumeSlider.thumbWidth = '30px'
volumeSlider.isThumbClamped = false
```

To handle input provided via the slider, add an `OnChanged()` component to the same entity. This component will execute a function each time that the slider's value is changed.

```ts
slider1.set(
  new OnChanged((data: { value: number }) => {
    const value = Math.round(data.value)
    valueFromSlider1.value = value.toString()
  })
)
```

See a full implementation of a slider below:

```ts
const slider1 = new Entity()
const volumeSlider = new UISliderShape(container)
volumeSlider.minimum = 0
volumeSlider.maximum = 10
volumeSlider.color = '#fff'
volumeSlider.value = 0
volumeSlider.borderColor = '#fff'
volumeSlider.background = 'black'
volumeSlider.thumbWidth = '30px'
volumeSlider.isThumbClamped = false
volumeSlider.hAlign = 'right'
volumeSlider.vAlign = 'top'
volumeSlider.width = '20px'
volumeSlider.height = '100px'
slider1.set(
  new OnChanged((data: { value: number }) => {
    const value = Math.round(data.value)
    sceneVolume = value.toString()
  })
)
slider1.set(sliderShape1)
engine.addEntity(slider1)
```


<!--

## Input text

Input boxes can be added to the UI to provide a place to type in text. Users must first click on this box before they can write into it.


```ts

```

You can change the background color to indicate that the input box is currently selected. Use the `focusedBackground` field to set an alternative color.

```ts
```

To handle events as the user changes the value in the text, add an `OnChanged()` component to the same entity. This component will execute a function each time that the string is changed.

```ts
inputEntity.set(
  new OnChanged((data: { value: string }) => {
    inputTextState = data.value
  })
)
```

In some cases, it's best to add a _submit_ button next to the input box. In this case instead of reacting when the string is changed, you only react when the button is clicked.

```ts

```
-->




## Open the UI

Users can always open the UI by clicking the icon on the top-right corner.  As an alternative, you can have the code of your scene open the UI when specific events occurs, for example at the end of a game to display the final score.

To do this, simply set the `visible` property of the main `UIScreenSpaceShape` component that wraps the UI to _true_.

The following code adds a cube to the world-space of the scene that opens the UI when clicked.

```ts
const uiTrigger = new Entity()
const transform = new Transform({ position: new Vector3(5, 1, 5), scale: new Vector3(0.3, 0.3, 0.3) })
uiTrigger.set(transform)

uiTrigger.set(
  new OnClick(() => {
    ui.visible = true
  })
)

uiTrigger.set(new BoxShape())
engine.addEntity(uiTrigger)
```

## Close the UI

Users can close the UI by clicking on the margins outside the UI. It's also a good practice to add a button on your UI to close it, in case the user doesn't realize how to close it.

You might also want to set the UI to invisible when a specific event occurs, for example when a new match of a game starts.

To do this, simply set the `visible` property of the main `UIScreenSpaceShape` component that wraps the UI to _false_.


```ts
const button = new UIButtonShape(container)
button.text = 'Close UI'
button.fontSize = 15
button.color = 'black'
button.background = 'yellow'
button.cornerRadius = 10
button.thickness = 1
button.width = '120px'
button.height = '30px'
button.vAlign = 'bottom'
button.top = '-80px'

const close = new Entity()
close.set(
  new OnClick(() => {
    log('clicked on the close image')
    screenSpaceUI.visible = false
  })
)
close.set(button)
engine.addEntity(close)
```



<!--

## Worldspace UI

Instead of adding UI elements to a the user's screenspace, you can add the same UI elements to a fixed location of the world space. These would be seen as an in-world screen.

UIWorldSpaceShape

-->
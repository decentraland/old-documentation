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

To add a screenspace UI to your scene, you must create an entity and add a `UIScreenSpaceShape` component to it. All the visible UI elements that you want the user to see are added as additional objects that are children of this parent object with a `UIScreenSpaceShape` component.

<!--
![](/images/media/UI-basic.png)
-->

```ts
// Create entity
const ui = new Entity()

// Create screenspace component
const screenSpaceUI = new UIScreenSpaceShape()

// Add screenspace component to entity
ui.addComponent(screenSpaceUI)

// Add entity to engine
engine.addEntity(ui)

// Create a textShape component, setting the screenspace component as parent
const text = new Entity()
text.addComponent(new UITextShape('Hello world!'))
text.setParent(ui)
engine.addEntity(text)
```



## Types of UI content

There are several different types of UI elements you can add to the screenspace:


- Images: Add a ``UIImageShape`` component to display any image. Use the `source` field to point to the path of the image.

- Text: Add a `UITextShape`component to display text. The properties you can set are the same as in a `TextShape` component.  See link
(also add section to that doc)

- Buttons: Add a `UIButtonShape` to add a clickable button. The button offers some visual feedback when users mouse over it and when they click it.

- Text input box: Add a `UIInputTextShape` to have an input box where users can type in text with their keyboards.

- Slider: Add a `UISliderShape` to have a slider that users can drag to provide input.


## Positioning

All UI components have several fields you can set to determine the position of the component on the screenspace.

- `hAlign` horizontal alignment relative to the parent. Possible values: `Top`, `Botton`, `Center`.

- `vAlign` horizontal alignment relative to the parent. Possible values: `Left`, `Right`, `Center`.


- `paddingLeft`, `paddingRight`, `paddingTop`, `paddingBottom`: padding space to leave empty around. To set these fields in pixels, write the value as a number. To set these fields as a percentage of the parent's measurements, write the value as a string that ends in "%", for example `10 %`

- `with`, `height`: Set the size of the component in the screen. To set these fields in pixels, write the value as a number. To set these fields as a percentage of the parent's measurements, write the value as a string that ends in "%", for example `10 


- `adaptWidth`, `adaptHeight`: Set on parent components. If these are set to true, the width and height wrap the child components (plus padding). If these are true, `width` and `height` values are ignored

```ts
let messageEntity = new Entity()
const message = new UITextShape('Close UI')
messageEntity.addComponent(message)
message.fontSize = 15
message.width = 120
message.height = 30
message.vAlign = 'bottom'
message.top = -80
engine.addEntity(messageEntity)
```

UIs are intentionally limited to only occupy a fraction of the full screen. This is to prevent UIs from covering other UI elements like the chat widget. Because of this, a "centered" UI is centered in relation to the available space, not to the entire screen space. 

Below is a screenshot of what a UI looks like in relation to the full screen when centered and at maximum size.

<img src="/images/media/UI-full-size.png" alt="Full size UI" width="300"/>


To determine the z position of UI elements, the UI uses the parenting hierarchy of the entities. So, if an entity is a child of another, it will appear in front of another.



## Use parent elements for organizing

Certain UI elements are there to help you organize how you place other elements.

<!--
![](/images/media/UI-rectangle.png)
-->

For this, you can use the `UIContainerStackShape` and the `UIContainerRectShape`.

Both these shapes have properties to set their color, line thickness, and rounded corners.

```ts
let container = new Entity()
const inventoryContainer = new UIContainerStackShape()
inventoryContainer.adaptWidth = true
inventoryContainer.width = '40%'
inventoryContainer.top = 100
inventoryContainer.left = 10
inventoryContainer.color = Color3.White()
inventoryContainer.hAlign = 'left'
inventoryContainer.vAlign = 'top'
container.addComponent(inventoryContainer)
engine.addEntity(container)
```


## Set alpha

You can make a UI element partly transparent by setting its `opacity` property.


```ts
let container = new Entity()
const rect = new UIContainerRectShape()
rect.width = '100%'
rect.height = '100%'
rect.color =  Color3.Blue()
rect.opacity = 0.5
container.addComponent(rect)
engine.addEntity(container)
```


## Images from an image atlas

You can use an image atlas to store multiple images and icons in a single image file. You then display rectangular parts of this image file in your UI based on pixel positions, pixel width, and pixel height inside the source image.

Below is an example of an image atlas with multiple icons arranged into a single file.

![](/images/media/UI-atlas.png)

The `UIImageShape` component has the following fields to crop a sub-section of the original image:

- `sourceTop`: the _y_ coordinate, in pixels, of the top of the selection
- `sourceLeft`: the _x_ coordinate, in pixels, of the left side of the selection.
- `sourceWidth`: the width, in pixels, of the selected area
- `sourceHeight`: the height, in pixels, of the selected area


```ts
let imageAtlas = "images/image-atlas.jpg"

let play = new Entity()
const playButton = new UIImageShape(container)
playButton.source = imageAtlas
playButton.sourceLeft = 26
playButton.sourceTop = 128
playButton.sourceWidth = 128
playButton.sourceHeight = 128
play.addComponent(playButton)
engine.addEntity(play)

let start = new Entity()
const startButton = new UIImageShape(container)
startButton.source = imageAtlas
startButton.sourceLeft = 183
startButton.sourceTop = 128
startButton.sourceWidth = 128
startButton.sourceHeight = 128
start.addComponent(startButton)
engine.addEntity(start)

let exit = new Entity()
const exitButton = new UIImageShape(container)
exitButton.source = imageAtlas
exitButton.sourceLeft = 346
exitButton.sourceTop = 128
exitButton.sourceWidth = 128
exitButton.sourceHeight = 128
exit.addComponent(exitButton)
engine.addEntity(exit)

let expand = new Entity()
const expandButton = new UIImageShape(container)
expandButton.source = imageAtlas
expandButton.sourceLeft = 496
expandButton.sourceTop = 128
expandButton.sourceWidth = 128
expandButton.sourceHeight = 128
expand.addComponent(expandButton)
engine.addEntity(expand)
```


## Clicking UI elements

The UI elements on the screenspace can also be interactive, instead of just showing information.

<!--
![](/images/media/UI-clicks.png)
-->


> Note: If desktop users want to click on a UI component, they must first unlock themselves from the view control, in order to be able to move the cursor over the UI component.

To handle the clicks, add an `OnClick()` component to the entity, just as you do with world-space entities.

```ts
let close = new Entity()
const button = new UIButtonShape("Close UI")
button.fontSize = 15
button.color = Color3.Yellow()
button.thickness = 1
button.width = 120
button.height = 30
button.vAlign = 'bottom'
button.top = -80
close.addComponent(button)

close.addComponent(
  new OnClick(() => {
    log('clicked on the close image')
    screenSpaceUI.visible = false
  })
)
engine.addEntity(close)
```


## Sliders

Sliders can be added to the UI to provide more interaction. Users can click and drag sliders to set a value. 

You can configure various aspects of the slider, including its appearance, orientation, what the maximum and minimum values represent, its default value, etc.

```ts

const slider1 = new Entity()
const volumeSlider = new UISliderShape()
volumeSlider.minimum = 0
volumeSlider.maximum = 10
volumeSlider.color = '#fff'
volumeSlider.value = 0
slider1.addComponent(volumeSlider)
engine.addEntity(slider1)

```

The slider's clickable space is very small by default, so it can be tricky to click with the cursor directly over it. To help make it easier, you can set the `thumbWidth`, `isThumbCircle` and `isThumbClamped` properties. The `thumbWidth` property is set in pixels.

```ts
volumeSlider.thumbWidth = 30
volumeSlider.isThumbClamped = false
```

To handle input provided via the slider, add an `OnChanged()` component to the same entity. This component will execute a function each time that the slider's value is changed.

```ts
slider1.addComponent(
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
volumeSlider.color = Color3.Black()
volumeSlider.value = 0
volumeSlider.borderColor = Color3.Blue()
volumeSlider.thumbWidth = 30
volumeSlider.isThumbClamped = false
volumeSlider.hAlign = 'right'
volumeSlider.vAlign = 'top'
volumeSlider.width = 20
volumeSlider.height = 100
slider1.addComponent(
  new OnChanged((data: { value: number }) => {
    const value = Math.round(data.value)
    sceneVolume = value.toString()
  })
)
slider1.addComponent(sliderShape1)
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
inputEntity.addComponent(
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

Users can always open the UI by clicking the icon on the top-right corner.  

![](/images/media/UI-open-icon.png)

As an alternative, you can have the code of your scene open the UI when specific events occurs, for example at the end of a game to display the final score.

To do this, simply set the `visible` property of the main `UIScreenSpaceShape` component that wraps the UI to _true_.

The following code adds a cube to the world-space of the scene that opens the UI when clicked.

```ts
const uiTrigger = new Entity()
const transform = new Transform({ position: new Vector3(5, 1, 5), scale: new Vector3(0.3, 0.3, 0.3) })
uiTrigger.addComponent(transform)

uiTrigger.addComponent(
  new OnPointerDown(() => {
    ui.visible = true
  })
)

uiTrigger.addComponent(new BoxShape())
engine.addEntity(uiTrigger)
```

## Close the UI

Users can close the UI by clicking anywhere on the margins outside the UI. 

It's a good practice to also add a button on your UI for closing it, to provide a more obvious way to do it.

You might also want to close the UI automatically when a specific event occurs, for example when a new match of a game starts.

To do this, simply set the `visible` property of the main `UIScreenSpaceShape` component that wraps the UI to _false_.


```ts
const close = new Entity()
const button = new UIButtonShape(container)
button.text = 'Close UI'
button.fontSize = 15
button.color = Color3.Black()
button.background = Color3.Yellow()
button.thickness = 1
button.width = 120
button.height = 30
button.vAlign = 'bottom'
button.top = -80
close.addComponent(button)

close.addComponent(
  new OnClick(() => {
    log('clicked on the close image')
    screenSpaceUI.visible = false
  })
)
engine.addEntity(close)
```



<!--

## Worldspace UI

Instead of adding UI elements to a the user's screenspace, you can add the same UI elements to a fixed location of the world space. These would be seen as an in-world screen.

UIWorldSpaceShape

-->
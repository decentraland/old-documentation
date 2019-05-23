---
date: 2018-02-15
title: Onscreen UI
description: Learn how to create a UI for players in your scene. This is useful, for example, to display game-related information.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 15
---


There are several special component types that are meant for using in a 2D screen space as part of the UI, instead of in the 3D world space. These components are displayed fixed on the player's screen.

UI elements are only visible when the player is standing inside the scene's LAND parcels, as neighboring scenes might have their own UI to display.  When the player clicks the _close UI_ button, on the top-right corner of the screen, all UI elements go away.

The UI can also be triggered to open when certain events occur in the world-space, for example if the player clicks on a specific place.


## Add a Screenspace UI

To add a screenspace UI to your scene, you must create an entity and add a `UICanvas` component to it. All the visible UI elements that you want the player to see are added as additional objects that are children of this parent object with a `UICanvas` component.

<!--
![](/images/media/UI-basic.png)
-->

```ts
// Create entity
const ui = new Entity()

// Create screenspace component
const canvas = new UICanvas()

// Add screenspace component to entity
ui.addComponent(canvas)

// Add entity to engine
engine.addEntity(ui)

// Create a textShape component, setting the object with the canvas as parent
const text = new Entity()
text.addComponent(new UIText())
text.value = 'Hello world!'
text.setParent(ui)
engine.addEntity(text)
```



## Types of UI content

There are several different types of UI elements you can add to the screenspace:


- Images: Add a `UIImage` component to display any image. Use the `source` field to point to the path of the image.

- Text: Add a `UIText`component to display text. The properties you can set are the same as in a `TextShape` component.  See [text]({{ site.baseurl }}{% post_url /development-guide/2018-02-11-text %}).

- Buttons: Add a `UIButton` to add a clickable button. The button offers some visual feedback when players mouse over it and when they click it.

- Text input box: Add a `UIInputText` to have an input box where players can type in text with their keyboards or their mobile devices.

- Scrollable rectangle: Add a `UIScrollRect` to have an area that can be filled with content. The rectangle can optionally have a slider if the content exceeds the rectangle area. Players can drag this slider to explore the contents of the rectangle.


## Positioning

All UI components have several fields you can set to determine the position of the component on the screenspace.


- `positionX`, `positionY`: the position of the top-left corner of the component, in reference to the top-left corner of its parent.

> Tip: Since we're measuring from the top, the numbers for `positionY` should be negative, unless you want the component to be positioned outside the parent. Example: to position a component leaving a margin of 20 pixels with respect to the parent on the top and left sides, set `positionX` to 20 and `positionY` to -20.

- `hAlign` horizontal alignment relative to the parent. Possible values: `Top`, `Botton`, `Center`.

- `vAlign` horizontal alignment relative to the parent. Possible values: `Left`, `Right`, `Center`.


- `paddingLeft`, `paddingRight`, `paddingTop`, `paddingBottom`: padding space to leave empty around. To set these fields in pixels, write the value as a number. To set these fields as a percentage of the parent's measurements, write the value as a string that ends in "%", for example `10 %`

- `with`, `height`: Set the size of the component in the screen. To set these fields in pixels, write the value as a number. To set these fields as a percentage of the parent's measurements, write the value as a string that ends in "%", for example `10 


```ts
let messageEntity = new Entity()
const message = new UIText()
messageEntity.addComponent(message)
message.text = 'Close UI'
message.fontSize = 15
message.width = 120
message.height = 30
message.vAlign = 'bottom'
message.top = -80
engine.addEntity(messageEntity)
```

UIs are intentionally limited so that they can't cover the top 10% of the screen. This is to prevent UIs from exposing fake menus that may pose as menus by the Decentraland explorer. Because of this, a "centered" UI is centered vertically in relation to the available space, not to the entire screen space. 

To determine the z position of UI elements, the UI uses the parenting hierarchy of the entities. So, if an entity is a child of another, it will appear in front of another.



## Use parent elements for organizing

Certain UI elements are there to help you organize how you place other elements.

<!--
![](/images/media/UI-rectangle.png)
-->

For this, you can use the `UIContainerStack` and the `UIContainerRect`.

Both these shapes have properties to set their color, line thickness, and rounded corners.

```ts
let container = new Entity()
const inventoryContainer = new UIContainerStack()
inventoryContainer.adaptWidth = true
inventoryContainer.width = '40%'
inventoryContainer.positionY = 100
inventoryContainer.positionX = 10
inventoryContainer.color = Color4.White()
inventoryContainer.hAlign = 'left'
inventoryContainer.vAlign = 'top'
inventoryContainer.stackOrientation = 0
container.addComponent(inventoryContainer)
engine.addEntity(container)
```


Container components also have following properties: 

- `adaptWidth` `adaptHeight`: Set on parent components. If these are set to true, the width and height wrap the child components (plus padding). If these are true, `width` and `height` values are ignored


#### Scrollable rectangles

You can also add UI elements into a `UIScrollRect`. If these rectangles have more content in them that what fits in their width or height, they will display a slider, that players can interact with to explore this content.

Scrollable rectangles can be horizontal or vertical, or both.

<!--
```ts

```

onChanged


To handle input provided via the slider, add an `OnChanged()` component to the same entity. This component will execute a function each time that the slider's value is changed.

```ts
sliderRect.addComponent(
  new OnChanged((data: { value: number }) => {
    const value = Math.round(data.value)
    valueFromSlider1.value = value.toString()
  })
)
```
-->






## Set alpha

You can make a UI element partly transparent by setting its `opacity` property.


```ts
let container = new Entity()
const rect = new UIContainerRect()
rect.width = '100%'
rect.height = '100%'
rect.color =  Color4.Blue()
rect.opacity = 0.5
container.addComponent(rect)
engine.addEntity(container)
```


## Images from an image atlas

You can use an image atlas to store multiple images and icons in a single image file. You then display rectangular parts of this image file in your UI based on pixel positions, pixel width, and pixel height inside the source image.

Below is an example of an image atlas with multiple icons arranged into a single file.

![](/images/media/UI-atlas.png)

The `UIImage` component has the following fields to crop a sub-section of the original image:

- `sourceTop`: the _y_ coordinate, in pixels, of the top of the selection
- `sourceLeft`: the _x_ coordinate, in pixels, of the left side of the selection.
- `sourceWidth`: the width, in pixels, of the selected area
- `sourceHeight`: the height, in pixels, of the selected area


When constructing a `UIImage` component, you must pass a `Texture` component as an argument. Read more about `Texture` components in [materials]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %})

```ts
let imageAtlas = "images/image-atlas.jpg"
let imageTexture = new Texture(imageAtlas)

let play = new Entity()
const playButton = new UIImage(imageTexture)
playButton.sourceLeft = 26
playButton.sourceTop = 128
playButton.sourceWidth = 128
playButton.sourceHeight = 128
play.addComponent(playButton)
engine.addEntity(play)

let start = new Entity()
const startButton = new UIImage(imageTexture)
startButton.sourceLeft = 183
startButton.sourceTop = 128
startButton.sourceWidth = 128
startButton.sourceHeight = 128
start.addComponent(startButton)
engine.addEntity(start)

let exit = new Entity()
const exitButton = new UIImage(imageTexture)
exitButton.sourceLeft = 346
exitButton.sourceTop = 128
exitButton.sourceWidth = 128
exitButton.sourceHeight = 128
exit.addComponent(exitButton)
engine.addEntity(exit)

let expand = new Entity()
const expandButton = new UIImage(imageTexture)
expandButton.sourceLeft = 496
expandButton.sourceTop = 128
expandButton.sourceWidth = 128
expandButton.sourceHeight = 128
expand.addComponent(expandButton)
engine.addEntity(expand)
```


## Clicking UI elements

The UI elements on the screenspace can be interactive, instead of just displaying information.

<!--
![](/images/media/UI-clicks.png)
-->


> Note: If desktop users want to click on a UI component, they must first unlock the cursor from the view control, to move the cursor over the UI component. They do this by clicking `Esc`.

To handle clicks, add an `OnClick()` or `OnPointerDown()` component to the entity, just as you do with world-space entities. See [click-events]({{ site.baseurl }}{% post_url /development-guide/2018-02-14-click-events %}) for more details.

```ts
let close = new Entity()
const button = new UIButton("Close UI")
button.fontSize = 15
button.color = Color4.Yellow()
button.thickness = 1
button.width = 120
button.height = 30
button.vAlign = 'bottom'
button.positionY = -80
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
UIScrollRect



Sliders can be added to the UI to provide more interaction. players can click and drag sliders to set a value. 

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
volumeSlider.color = Color4.Black()
volumeSlider.value = 0
volumeSlider.borderColor = Color4.Blue()
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
-->



## Input text

Input boxes can be added to the UI to provide a place to type in text. You add a text box with an `UIInputText` component. Players must first click on this box before they can write into it.

<!--
```ts

```
-->


Here are some of the main properties you can set:

- `focusedBackground`: You can change the background color to indicate that the input box is currently selected. Use this field to set an alternative color.

- `placeholder`: Set placeholder text to display on the box by default.

- `placeholderColor`: Make the placeholder a different color, to tell it apart. You'll usually want to make it a paler shade of the color of text that the player writes.

When the user interacts with the component, you can use the following events to trigger the execution of code:

- `OnFocus()`: The player clicked on the UI component and has a cursor on it.
- `OnBlur()`: The player clicked away and the cursor is gone.
- `OnChanged()`: The user typed or deleted something to change the string on the component.
- `OnTextSubmit()`: The user typed the `Enter` key to submit this string.



```ts
inputEntity.addComponent(
  new OnChanged((data: { value: string }) => {
    inputTextState = data.value
  })
)
```

In some cases, it's best to add a _submit_ button next to the input box. In this case instead of reacting when the string is changed, or to the `OnTextSubmit` event, you only react when the button is clicked.

<!--
```ts

```
-->

## Open the UI


You can have the code of your scene make the the UI visible when specific events occurs, for example at the end of a game to display the final score.

To do this, simply set the `visible` property of the main `UICanvas` component that wraps the UI to _true_ or _false_.

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

Players can close the UI by clicking the icon on the top-right corner. Note that when closing the UI in this way, they won't see any more UI components appear in your scene, even if the code sets them to visible. 

It's a good practice to add a button on your UI elements for closing them in a way that doesn't prevent other UI components from being visible in the future.

You might also want to close the UI automatically when a specific event occurs, for example when a new match of a game starts.

To do this, simply set the `visible` property of the main `UIScreenSpace` component that wraps the UI to _false_.


```ts
const close = new Entity()
const button = new UIButton(container)
button.text = 'Close UI'
button.fontSize = 15
button.color = Color4.Yellow()
button.thickness = 1
button.width = 120
button.height = 30
button.vAlign = 'bottom'
button.positionY = -80
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

Instead of adding UI elements to a the player's screenspace, you can add the same UI elements to a fixed location of the world space. These would be seen as an in-world screen.

UIWorldSpace

-->
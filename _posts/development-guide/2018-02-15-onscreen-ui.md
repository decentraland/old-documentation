---
date: 2018-02-15
title: 2D UI
description: Learn how to create a UI for players in your scene. This is useful, for example, to display game-related information.
categories:
  - development-guide
type: Document
---

There are several special component types that are meant for using in a 2D screen space as part of the UI, instead of in the 3D world space. These components are displayed fixed on the player's screen.

UI elements are only visible when the player is standing inside the scene's LAND parcels, as neighboring scenes might have their own UI to display. When the player clicks the _close UI_ button, on the bottom-right corner of the screen, all UI elements go away.

The UI can also be triggered to open when certain events occur in the world-space, for example if the player clicks on a specific place.

The default Decentraland explorer UI includes a chat widget, a map, and other elements. These UI elements are always displayed on the top layer, above any scene-specific UI. So if your scene has UI elements that occupy the same screen space as these, they will be occluded.

## Add a Screenspace UI

To add a screenspace UI to your scene, you must create a `UICanvas` component, this component doesn't need to belong to any Entities to work. All the visible UI elements that you want the player to see are added as additional objects that are children of this parent component.

<!--
![]({{ site.baseurl }}/images/media/UI-basic.png)
-->

```ts
// Create screenspace component
const canvas = new UICanvas()

// Create a textShape component, setting the canvas as parent
const text = new UIText(canvas)
text.value = "Hello world!"
```

> Note: Create only one `UICanvas` per scene. To have different menus that appear at different times, make them all children of the same `UICanvas`, and set their visibility at that level.

## Types of UI content

There are several different types of UI elements you can add to the screenspace:

- Images: Add a `UIImage` component to display any image. Use the `source` field to point to the path of the image.

- Text: Add a `UIText`component to display text. The properties you can set are the same as in a `TextShape` component. See [text]({{ site.baseurl }}{% post_url /development-guide/2018-02-11-text %}).

<!--
- Buttons: Add a `UIButton` to add a clickable button. The button offers some visual feedback when players mouse over it and when they click it.
-->

- Text input box: Add a `UIInputText` to have an input box where players can type in text with their keyboards or their mobile devices.

- Scrollable rectangle: Add a `UIScrollRect` to have an area that can be filled with content. The rectangle can optionally have a slider if the content exceeds the rectangle area. Players can drag this slider to explore the contents of the rectangle.

## Positioning

All UI components have several fields you can set to determine the position of the component on the screenspace.

- `hAlign` horizontal alignment relative to the parent. Possible values: `left`, `right`, `center`.

- `vAlign` horizontal alignment relative to the parent. Possible values: `top`, `bottom`, `center`.

- `positionX`, `positionY`: the position of the top-left corner of the component, relative to the parent. By default, to the top-left corner of its parent. If the `hAlign` or `vAlign` properties are set, then `positionX` and `positionY` offset the UI component relative to the position of these alignment properties.

> Tip: When measuring from the top, the numbers for `positionY` should be negative. Example: to position a component leaving a margin of 20 pixels with respect to the parent on the top and left sides, set `positionX` to 20 and `positionY` to -20.

- `paddingLeft`, `paddingRight`, `paddingTop`, `paddingBottom`: padding space to leave empty around. To set these fields in pixels, write the value as a number. To set these fields as a percentage of the parent's measurements, write the value as a string that ends in "%", for example `10 %`

- `with`, `height`: Set the size of the component in the screen. To set these fields in pixels, write the value as a number. To set these fields as a percentage of the parent's measurements, write the value as a string that ends in "%", for example `10 %`

```ts
const canvas = new UICanvas()

const message = new UIText(canvas)
message.value = "Close UI"
message.fontSize = 15
message.width = 120
message.height = 30
message.vAlign = "bottom"
message.positionX = -80
```

To determine the z position of UI elements, the UI uses the parenting hierarchy of the components. So, if a component is a child of another, it will appear in front of the other.

## Use parent elements for organizing

Certain UI elements are there to help you organize how you place other elements.

<!--
![]({{ site.baseurl }}/images/media/UI-rectangle.png)
-->

For this, you can use the `UIContainerStack` and the `UIContainerRect`.

Both these shapes have properties to set their color, and line thickness.

```ts
const canvas = new UICanvas()

const inventoryContainer = new UIContainerStack(canvas)
inventoryContainer.adaptWidth = true
inventoryContainer.width = "40%"
inventoryContainer.positionY = 100
inventoryContainer.positionX = 10
inventoryContainer.color = Color4.White()
inventoryContainer.hAlign = "left"
inventoryContainer.vAlign = "top"
inventoryContainer.stackOrientation = UIStackOrientation.VERTICAL
```

Container components also have following properties:

- `adaptWidth` `adaptHeight`: Set on parent components. If these are set to true, the width and height wrap the child components (plus padding). If these are true, `width` and `height` values are ignored

- `stackOrientation`: The `UIContainerStack` component has this property to set if the stack will expand vertically or horizontally.

#### Scrollable rectangles

You can also add UI elements into a `UIScrollRect`. If these rectangles have more content in them that what fits in their width or height, a slider will appear on the margins, that players can interact with to explore this content.

Scrollable rectangles can be horizontal or vertical, or both.

```ts
const canvas = new UICanvas()

const scrollableContainer = new UIScrollRect(canvas)
scrollableContainer.width = "50%"
scrollableContainer.height = "50%"
scrollableContainer.backgroundColor = Color4.Gray()
scrollableContainer.isVertical = true
scrollableContainer.onChanged = new OnChanged(() => {
  log("scrolled to ", scrollableContainer.positionY)
})
```

Scrolling values are always normalized from 0 to 1. You can set the scrolling value manually via the `valueX` and `valueY` properties.

The `onChanged` property lets you run a function whenever the value of the scrollbar changes.

## Set transparency

You can make a UI element partly transparent by setting its `opacity` property to a value that's less than 1.

```ts
const canvas = new UICanvas()

const rect = new UIContainerRect(canvas)
rect.width = "100%"
rect.height = "100%"
rect.color = Color4.Blue()
rect.opacity = 0.5
```

Setting an element's opacity also affects all of its children. If you don't want its children to be transparent, for example you want the background to be transparent but not the text on it, you can set the color with a hex string that has four values, one of them being the alpha channel.

## Text

The `UIText` component lets you add text. It has properties that are similar to the `TextShape` component. See [text]({{ site.baseurl }}{% post_url /development-guide/2018-02-11-text %}).

- `value`: the string to display
- `color`: `Color4` for the text color
- `fontSize`: font size
- `font`: font to use
- `lineSpacing` : space between lines of text
- `lineCount`: how many max lines of text
- `textWrapping`: if text automatically occupies more lines
- `outlineWidth`, `outlineColor`: add an outline to the text
- `shadowBlur`, `shadowOffsetX`, `shadowOffsetY`, `shadowColor`: Add a shadow to the text

Fonts are set as a _Font object_. Font objects are initiated with a value from the _Fonts_ enum, which contains all supported fonts. By default, all text components use _LiberationSans_ font.

```ts
const canvas = new UICanvas()

const myText = new UIText(canvas)
myText.value = "Hello"
myText.font = new Font(Fonts.SanFrancisco)
myText.fontSize = 20
myText.positionX = "15px"
myText.color = Color4.Blue()
```

> TIP: If using VS studio or some other IDE, type `Font.` and you should see a list of suggestions with all of the available fonts.

You can share a same instanced `Font` object accross multiple `UIText` components.

```ts
const sfFont = new Font(Fonts.SanFrancisco)

const myText = new UIText(canvas)
myText.value = "Hello"
myText.font = sfFont

const myText2 = new UIText(canvas)
myText2.value = "World"
myText2.font = sfFont
```


#### Multiline text

`UIText` components by default adapt their width to the length of the provided string. To make a text span multiple lines, set the `textWrapping` property to _true_ and `adaptWidth` to _false_, and also specify the desired width.

```ts
const canvas = new UICanvas()

const myText = new UIText(canvas)
myText.value =
  "Hello World, this message is quite long and won't fit in a single line. I hope that's not a problem."
myText.fontSize = 20
myText.adaptWidth = false
myText.textWrapping = true
myText.width = 100
```

Alternatively, you can add line breaks into the string, using `\n`.

```ts
const canvas = new UICanvas()

const myText = new UIText(canvas)
myText.value =
  "Hello World,\nthis message is quite long and won't fit in a single line.\nI hope that's not a problem."
myText.fontSize = 20
```

## Images from an image atlas

You can use an image atlas to store multiple images and icons in a single image file. You then display rectangular parts of this image file in your UI based on pixel positions, pixel width, and pixel height inside the source image.

Below is an example of an image atlas with multiple icons arranged into a single file.

![]({{ site.baseurl }}/images/media/UI-atlas.png)

The `UIImage` component has the following fields to crop a sub-section of the original image:

- `sourceTop`: the _y_ coordinate, in pixels, of the top of the selection
- `sourceLeft`: the _x_ coordinate, in pixels, of the left side of the selection.
- `sourceWidth`: the width, in pixels, of the selected area
- `sourceHeight`: the height, in pixels, of the selected area

When constructing a `UIImage` component, you must pass a `Texture` component as an argument. Read more about `Texture` components in [materials]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}).

```ts
let imageAtlas = "images/image-atlas.jpg"
let imageTexture = new Texture(imageAtlas)

const canvas = new UICanvas()

const playButton = new UIImage(canvas, imageTexture)
playButton.sourceLeft = 26
playButton.sourceTop = 128
playButton.sourceWidth = 128
playButton.sourceHeight = 128

const startButton = new UIImage(canvas, imageTexture)
startButton.sourceLeft = 183
startButton.sourceTop = 128
startButton.sourceWidth = 128
startButton.sourceHeight = 128

const exitButton = new UIImage(canvas, imageTexture)
exitButton.sourceLeft = 346
exitButton.sourceTop = 128
exitButton.sourceWidth = 128
exitButton.sourceHeight = 128

const expandButton = new UIImage(canvas, imageTexture)
expandButton.sourceLeft = 496
expandButton.sourceTop = 128
expandButton.sourceWidth = 128
expandButton.sourceHeight = 128
```

You can change the texture being used by an existing `UIImage` component, set the `data` field.

```ts
playButton.data = imageTexture2
```

## Clicking UI elements

All UI elements have an `isPointerBlocker` property, that determines if they can be clicked. If this value is false, the pointer should ignore them and respond to whatever is behind the element.

Clickable UI elements also have an `OnClick` property, that lets you add a function to execute every time it's clicked.

```ts
const canvas = new UICanvas()

const clickableImage = new UIImage(canvas, new Texture("icon.png"))
clickableImage.name = "clickable-image"
clickableImage.width = "92px"
clickableImage.height = "91px"
clickableImage.sourceWidth = 92
clickableImage.sourceHeight = 91
clickableImage.isPointerBlocker = true
clickableImage.onClick = new OnClick(() => {
  // DO SOMETHING
})
```

<!--
![]({{ site.baseurl }}/images/media/UI-clicks.png)
-->

> Note: To click on a UI component, players must first unlock the cursor from the view control. They do this by clicking the _right mouse button_ or hitting `Esc`.

> Tip: If you want to add text over a button, keep in mind that the text needs to have the `isPointerBlocker` property set to `false`, otherwise players might be clicking the text instead of the button.

## Input text

Input boxes can be added to the UI to provide a place to type in text. You add a text box with an `UIInputText` component. Players must first click on this box before they can write into it.

```ts
const canvas = new UICanvas()

const textInput = new UIInputText(canvas)
textInput.width = "80%"
textInput.height = "25px"
textInput.vAlign = "bottom"
textInput.hAlign = "center"
textInput.fontSize = 10
textInput.placeholder = "Write message here"
textInput.placeholderColor = Color4.Gray()
textInput.positionY = "200px"
textInput.isPointerBlocker = true

textInput.onTextSubmit = new OnTextSubmit((x) => {
  const text = new UIText(textInput)
  text.value = "<USER-ID> " + x.text
  text.width = "100%"
  text.height = "20px"
  text.vAlign = "top"
  text.hAlign = "left"
})
```

Here are some of the main properties you can set:

- `focusedBackground`: You can change the background color to indicate that the input box is currently selected. Use this field to set an alternative color.

- `placeholder`: Set placeholder text to display on the box by default.

- `placeholderColor`: Make the placeholder a different color, to tell it apart. You'll usually want to make it a paler shade of the color of text that the player writes.

When the player interacts with the component, you can use the following events to trigger the execution of code:

- `OnFocus()`: The player clicked on the UI component and has a cursor on it.
- `OnBlur()`: The player clicked away and the cursor is gone.
- `OnChanged()`: The player typed or deleted something to change the string on the component.
- `OnTextSubmit()`: The player hit the `Enter` key to submit this string.

```ts
textInput.onChanged = new OnChanged((data: { value: string }) => {
  inputTextState = data.value
})
```


## Open the UI

You can have the code of your scene make the the UI visible when specific events occurs, for example at the end of a game to display the final score.

To do this, simply set the `visible` property of the main `UICanvas` component that wraps the UI to _true_ or _false_.

If the UI is clickable, or has clickable parts, you should also set the `isPointerBlocker` property to _true_ or _false_, so that the player can freely click in the world space when the UI is not on the way.

The following code adds a cube to the world-space of the scene that opens the UI when clicked.

```ts
const uiTrigger = new Entity()
const transform = new Transform({
  position: new Vector3(5, 1, 5),
  scale: new Vector3(0.3, 0.3, 0.3),
})
uiTrigger.addComponent(transform)

uiTrigger.addComponent(
  new OnPointerDown(() => {
    canvas.visible = true
    canvas.isPointerBlocker = true
  })
)

uiTrigger.addComponent(new BoxShape())
engine.addEntity(uiTrigger)
```

Players can close the UI by clicking the icon on the top-right corner. Note that when closing the UI in this way, they won't see any more UI components appear in your scene, even if the code sets them to visible.

It's a good practice to add a button on your UI elements for closing them in a way that doesn't prevent other UI components from being visible in the future.

You might also want to close the UI automatically when a specific event occurs, for example when a new match of a game starts.

To do this, simply set the `visible` property of the main `UIScreenSpace` component that wraps the UI to _false_.

If the UI is clickable, or has clickable parts, you should also set the `isPointerBlocker` property to _false_, so that the player can freely click in the world space.

```ts
const canvas = new UICanvas()

const close = new UIImage(canvas, new Texture("icon.png"))
close.name = "clickable-image"
close.width = "120px"
close.height = "30px"
close.sourceWidth = 92
close.sourceHeight = 91
close.vAlign = "bottom"
close.isPointerBlocker = true
close.onClick = new OnClick(() => {
  log("clicked on the close image")
  canvas.visible = false
  canvas.isPointerBlocker = false
})
```
````

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


There are a number of special components that are meant for using in a 2D screen space, rather than in the 3D world space. These components are displayed fixed on the user's screen as long as the user is standing inside the area of the scene.

Onscreen UI 


## Add a UI

const ui = new Entity()
const screenSpaceUI = new UIScreenSpaceShape()
ui.set(screenSpaceUI)
engine.addEntity(ui)

The visible UI elements on the screen aren't entities nor components, they are objects that belong to the `UIScreenSpaceShape()` component.

When adding any UI elements, you assign the `UIScreenSpaceShape()` component as a parent. The first argument on the constructor of all UI elements is the parent, so you do:

const textShape = new UITextShape(screenSpaceUI)
textShape.value = 'Click on the box to open this'
textShape.fontSize = 30
textShape.height = '25px'


## Types of UI components

UIContainerRectShape

UIContainerStackShape

UIFullScreenShape

UIImageShape

UIScreenSpaceShape

UIShape

UISliderShape

UITextShape

UIWorldSpaceShape


## Positioning



hAlign =  'Top'  'Botton'

vAlign = 'Left' 'Right'

maxWidth

autoStretchWidth

 adaptWidth: boolean
  adaptHeight: boolean


## Use parent elements to oganize

UIContainerRectShape

  color:
  thickness: number
  cornerRadius: number
 


UIContainerStackShape

UIFullScreenShape

UIShape

## Set visible properties

opacity


## Text

`UITextShape` has the same properties as a `TextShape` component.  See link

(also add section to that doc)




## Clicking UI elements

Users will be able to click UI elements. For example on a PC, they should first click Escape to stop controlling the view with the mouse

Is pointer blocker


If you want a UI element to be clickable, must belong to a separate entity to have an OnClick()


thumbWidth
isThumbCircle
isThumbClamped



## Worldspace UI

UIWorldSpaceShape
---
date: 2018-02-25
title: Asynchronous code
description: Learn when and how to run asynchronous functions in your scene's code.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 30
---

// LINK TO THIS PAGE FROM ALL THAT USE executeTask()

## Overview

Most of the code in your scene runs synchronously using a single thread. That means that commands are executed sequentially line by line. Each command must first wait for the previous command to finish executing before it can start.

Even the `update()` functions in your scene's systems are executed one by one, following the priority numbers set when adding the systems to the engine.

Running code synchronously ensures consistency, as you can always be sure you'll know the order in which the commands in your code run.

In some special cases though, you want some commands to run asynchronously. This means that you can start off a task and the execution of the next line of code can start without waiting for that task to return a result.

This is useful for tasks that rely on external services that could take time to respond.

For example:

- When playing a sound file
- When retrieving data from a REST API
- When performing a transaction on the blockchain

<!--
- When parsing a JSON file (??)
-->

Since your scene needs to be updated many times per second, you can't afford to have the scene's main thread stuck waiting for an answer from an external service. The rest of your code needs to keep running, building the next frame, while the task is idle waiting for a response.

[ ASYNC DIAGRAMS]

## The executeTask function

The `executeTask` function executes a lambda function asynchronously, in a separate thread from the scene's main thread.

```ts
// Start an asynchronous task
executeTask(async () => {
  try {
    let response = await fetch(callUrl)
    let json = await response.json()
    log(json)
  } catch {
    log("failed to reach the URL")
  }
})

// Rest of the code keeps being executed
```

The example above executes a function that includes a `fetch()` operation to retrieve data from an external API. The rest of the code in the scene will keep being executed while this asynchronous process takes place.

<!--
Note that there are two `await` statements here, one to get data from
-->

> Note: Keep in mind that several frames of your scene might be rendered before the task finishes executing. Make sure your scene's code is flexible enough to handle the in-between scenarios while the asynchronous task is being completed.

## OnClick functions

You can add an `OnCLick` component to any entity to trigger an asynchronous lambda function every time that entity is clicked.

```ts
myEntity.add(
  new OnClick(e => {
    log("clicked on the entity", e)
  })
)
```

## Subscribe a listener

Another way to run asynchronous code is to instance an event listener. Event listeners trigger the running of an asynchronous lambda function every time that a given event occurs.

```ts
//Instance the Input object
const input = Input.instance

// Subscribe to an event
input.subscribe("BUTTON_A_DOWN", e => {
  log("pointerUp works", e)
})
```

The example above runs a function every time that the button _A_ is pressed down.

<!-- If multiple events in rapid succession, do we get multiple independent threads? -->

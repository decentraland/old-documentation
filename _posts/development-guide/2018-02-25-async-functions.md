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

## Overview

Most of the code in your scene runs synchronously using a single thread. That means that commands are executed sequentially line by line. Each command must first wait for the previous command to finish executing before it can start.

Even the `update()` functions in your scene's systems are executed one by one, following a [priority order](({{ site.baseurl }}{% post_url /development-guide/2018-02-3-systems %}#system-execution-order)).

Running code synchronously ensures consistency, as you can always be sure you'll know the order in which the commands in your code run.

On the other hand, your scene needs to be updated many times per second, building the next frame. If a part of your code takes too long to respond, then the whole main thread is stuck and this results in lagging frame rates.

That's why, in some cases you want some commands to run asynchronously. This means that you can start off a task in a new thread, and meanwhile the main thread can keep running over the the next lines of code.

This is especially useful for tasks that rely on external services that could take time to respond, as you don't want that idle time waiting for that response to block other tasks.

For example:

- When playing a sound file
- When retrieving data from a REST API
- When performing a transaction on the blockchain

<!--
- When parsing a JSON file (??)
-->

<!--
[ ASYNC DIAGRAMS]
-->

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

> Note: Keep in mind that several frames of your scene might be rendered before the task finishes executing. Make sure your scene's code is flexible enough to handle the in-between scenarios while the asynchronous task is being completed.

## OnClick functions

You can add an `OnCLick` component to any entity to trigger an asynchronous lambda function every time that entity is clicked.

```ts
myEntity.addComponent(
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
input.subscribe("BUTTON_DOWN", e => {
  log("pointerUp works", e)
})
```

The example above runs a function every time that the button _A_ is pressed down.

<!-- If multiple events in rapid succession, do we get multiple independent threads? -->

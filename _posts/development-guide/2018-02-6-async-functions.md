---
date: 2018-02-5
title: Async functions
description: Learn when and how to run asynchronous functions in your scene's code.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 5
---

// LINK TO THIS PAGE FROM ALL THAT USE executeTask()

## Overview

Most of the code in your scene runs synchronously using a single thread. That means that commands are executed sequentially line by line. Each command must first wait for the previous command to finish executing before it can start.

For each frame of the scene, the `update` functions of the systems in your scene are executed one by one, following the priorities set when adding the systems to the engine.

Running code synchronously ensures consistency, as you can always be sure you'll know the order in which the commands in your code run.

In some special cases though, you want some commands to run asynchronously. This means that you can start off a process and the execution of the next line of code won't wait for that process to return a result before it starts.

This is useful for cases where you need to wait for a response from an external service that could take time.

For example:

- When playing a sound file
- When retrieving data from a REST API
- When performing a transaction on the blockchain
- When parsing a JSON file (??)

Since your scene needs to be updated many times per second, you can't afford to have the scene's main thread stuck waiting for an answer from an external service. The rest of your code needs to keep running, building the next frame, while the process is idle waiting for a response.

[ ASYNC DIAGRAMS]

## The executeTask function

The `executeTask` function takes a lambda and executes it asynchronously, in a separate thread from the scene's main thread.

```ts
executeTask(async () => {
  try {
    let response = await fetch(callUrl)
    let json = await response.json()
    log(json)
  } catch {
    log("failed to reach URL")
  }
})
// (...)
```

The example above executes a `fetch()` function to retrieve data from a REST API. The rest of the code in the scene will keep being executed while this asynchronous process takes place.

<!--
Note that there are two `await` statements here, one to get data from
-->

> Note: Keep in mind that several frames of your scene might be rendered before the task finishes executing. Make sure your scene's code is flexible enough to handle the in-between scenarios while the asynchronous task is being completed.

## Subscribe a listener

Another way to run asynchronous code is to instance an event listener. Event listeners trigger the running of an asynchronous task every time that a given event occurs.

```ts
const input = Input.instance

input.subscribe("BUTTON_A_UP", e => {
  console["log"]("pointerUp works", e)
})
```

<!-- If multiple events in rapid succession, do we get multiple independent threads? -->

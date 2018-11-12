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

Doing things like this ensures the consistency of your code,

In each frame of the scene, the `update` functions of the systems in your scenes are executed one by one, following the priorities determined when adding the systems to the engine. They all run in a single thread.

In some special cases, you want commands to run asynchronously. This means that the execution of the next line won't wait for the command to return a result.

This is useful for cases where you need to wait for a response from an external service that could take time.

For example:

- Playing a sound file
- Retrieving data from a REST API
- Performing a transaction on the blockchain
- Parse a JSON file (??)

Since your scene needs to be updated many times per second, you can't afford to have the scene's main thread stuck waiting from an answer from an external service. The rest of your code needs to keep running while you're idle waiting for a response.

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
```

The example above executes a `fetch()` function to retrieve data from a REST API.

Note that there are two `await` statements here, one to get data from

Note that, as your scene waits for a response, several frames might be rendered before you get a response. So make sure your scene's content remains coherent

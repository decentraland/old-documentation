---
date: 2018-02-24
title: Network connections
description: How to communicate your scene with external servers and APIs.
categories:
  - development-guide
type: Document
set: development-guide
set_order: 29
---

Your scene can leverage external services that expose APIs, you can use this to obtain updated price data, weather data or any other kind of information exposed by an API.

You can also set up your own external server to aid your scene and serve to synchronize data between your users. This can either be done with a server that exposes a REST API, or with a server that uses WebSockets.

## Call a REST API

Your scene's code can send calls to a REST API to fetch data.

Since the server might take time to send its response, you must execute this command as an _async_ task, using `executeTask()`.

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

The fetch command can also include a second optional argument that bundles headers, HTTP method and HTTP body into a single object.

```ts
executeTask(async () => {
  try {
    let response = await fetch(callUrl, {
      headers: { "Content-Type": "application/json" },
      method: "POST",
      body: JSON.stringify(myBody)
    })
    let json = await response.json()
    log(json)
  } catch {
    log("failed to reach URL")
  }
})
```

> Note: The body must be sent as a stringified JSON object.

The fetch command returns a `response` object with the following data:

- `headers`: A `ReadOnlyHeaders` object. Call the `get()` method to obtain a specific header, or the `has()` method to check if a header is present.
- `ok`: Boolean
- `redirected`: Boolean
- `status`: Status code number
- `statusText`: Text for the status code
- `type`: Will have one of the following values: _basic_, _cors_, _default_, _error_, _opaque_, _opaqueredirect_
- `url`: URL that was sent

- `json()`: Obtain the body in JSON format.
- `text()`: Obtain the body as text.

> Note: `json()` and `text()` are mutually exclusive. If you obtain the body of the response in one of the two formats, you can no longer obtain the other from the `response` object.

## Use WebSockets

You can also send and obtain data from a WebSocket server.

```ts
var socket = new WebSocket("url")

socket.onmessage = function(event) {
  log("WebSocket message received:", event)
}
```

The syntax to use WebSockets is no different from that implemented natively by JavaScript. See the documentation from [Mozilla Web API](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket) for details on how to catch and send messages over WebSockets.

> Note: The Decentraland SDK doesn't support importing external libraries, so you can't use WebSocket libraries.

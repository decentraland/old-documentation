---
date: 2020-05-04
title: Video Streaming
description: Stream video into a scene
categories:
  - development-guide
type: Document
---

You can display a video streaming source as a [material]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}) placed on a primitive shape.

The source of the streaming must be an _https_ URL (_http_ URLs aren't supported), and the source should have [CORS policies (Cross Origin Resource Sharing)](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) that permit externally accessing it. If this is not the case, you might need to set up a server to act as a proxy and expose the stream in a valid way.

To stream a video:

1. Create a `VideoClip` object, referencing the streaming URL.

2. Create a `VideoTexture` object, and assign the `VideoClip` to it.

3. Create a `Material` or `BasicMaterial`, and set its `albedoTexture` or `texture` to the `VideoTexture` you created.

4. Then add that `Material` to an entity that has a primitive shape, like a `PlaneShape` or a `BoxShape`.

```ts
// #1
const myVideoClip = new VideoClip("http://134.122.31.53/hls/test.m3u8")

// #2
const myVideoTexture = new VideoTexture(myVideoClip)

// #3
const myMaterial = new BasicMaterial()
myMaterial.texture = myVideoTexture

// #4
const screen = new Entity()
screen.addComponent(new PlaneShape())
screen.addComponent(
  new Transform({
    position: new Vector3(8, 1, 8),
  })
)
screen.addComponent(myMaterial)
screen.addComponent(
  new OnPointerDown(() => {
    v.playing = !v.playing
  })
)
engine.addEntity(screen)
```

Keep in mind that streaming video demands a significant effort from the player's machine. We recommend not having more than one video stream displayed at a time per scene. Also avoid streaming videos that are in very high resolution, don't use anything above _HD_. We also recommend activating the stream only once the player performs an action or approaches the screen, to avoid affecting neighbouring scenes.

Since the streamed video is a texture that's added to a material, you can also experiment with [other properties of materials]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}), like tinting it with a color, of adding other texture layers. for example to produce a dirty screen effect.

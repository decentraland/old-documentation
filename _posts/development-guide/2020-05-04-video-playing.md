---
date: 2020-05-04
title: Play Videos
description: Stream video into a scene
categories:
  - development-guide
type: Document
redirect_from:
  - /development-guide/video-streaming
---

There are two different ways you can show a video in a scene. One is to stream the video from an external source, the other is to pack the video file with the scene and play it from there.

In both cases, you assign the video to a `VideoTexture`, which can be used on a [material]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}) and then applied to any [primitive shape]({{ site.baseurl }}{% post_url /development-guide/2018-02-6-shape-components %}) like a plane, cube, or even a cone.

> TIP: Since the video is a texture that's added to a material, you can also experiment with other properties of materials, like tinting it with a color, of adding other texture layers. for example to produce a dirty screen effect.

## Show a video

The following instructions apply both to streaming and to showing a video from a file:

1. Create a `VideoClip` object, either referencing a streaming URL or a path to a video file.

2. Create a `VideoTexture` object, and assign the `VideoClip` to it.

3. Create a `Material` or `BasicMaterial`, and set its `albedoTexture` or `texture` to the `VideoTexture` you created.

4. Then add that `Material` to an entity that has a primitive shape, like a `PlaneShape` or a `BoxShape`.

5. Play the video texture

This example uses a video stream:

```ts
// #1
const myVideoClip = new VideoClip(
  "https://theuniverse.club/live/consensys/index.m3u8"
)

// #2
const myVideoTexture = new VideoTexture(myVideoClip)

// #3
const myMaterial = new Material()
myMaterial.albedoTexture = myVideoTexture
myMaterial.roughness = 1
myMaterial.specularIntensity = 0
myMaterial.metallic = 0


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
    myVideoTexture.playing = !myVideoTexture.playing
  })
)
engine.addEntity(screen)

// #5
myVideoTexture.play()
```

To use a video file, just change the first step to reference the path to the file:

```ts
const myVideoClip = new VideoClip("videos/myVideo.mp3")
```

## Video Materials

To many, the default properties of a material make the video look quite opaque for a screen, but you can enhance that by altering other properties of the material.


```ts
const myMaterial = new Material()
myMaterial.albedoTexture = videoTexture
myMaterial.roughness = 1
myMaterial.specularIntensity = 0
myMaterial.metallic = 0
```

If you want the screen to glow a little, you can even set the `emissiveTexture` of the material to the same `VideoTexture` as the `albedoTexture`.


```ts
const myMaterial = new Material()
myMaterial.albedoTexture = videoTexture
myMaterial.roughness = 1.0
myMaterial.specularIntensity = 0
myMaterial.metallic = 0
myMaterial.emissiveTexture = videoTexture
myMaterial.emissiveColor = Color3.White()
myMaterial.emissiveIntensity = 0.6
```

See [materials]({{ site.baseurl }}{% post_url /development-guide/2018-02-7-materials %}) for more details.

## About Streaming

The source of the streaming must be an _https_ URL (_http_ URLs aren't supported), and the source should have [CORS policies (Cross Origin Resource Sharing)](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) that permit externally accessing it. If this is not the case, you might need to set up a server to act as a proxy and expose the stream in a valid way.

To launch your own video streaming server, we recommend using a [Node Media Server](https://github.com/illuspas/Node-Media-Server), which provides most of what you need out of the box.

Keep in mind that streaming video demands a significant effort from the player's machine. We recommend not having more than one video stream displayed at a time per scene. Also avoid streaming videos that are in very high resolution, don't use anything above _HD_. We also recommend activating the stream only once the player performs an action or approaches the screen, to avoid affecting neighbouring scenes.

## About Video Files

The following file formats are supported:

- _.mp4_
- _.ogg_
- _.webm_

Keep in mind that a video file adds to the total size of the scene, which makes the scene take longer to download for players walking into your scene. The video size might also make you go over the [scene limitations]({{ site.baseurl }}{% post_url /development-guide/2018-01-06-scene-limitations %}), as you have a maximum of 15 MB per parcel to use. We recommend compressing the video as much as possible, so that it's less of a problem.

We also recommend starting to play the video when the player is near or performs an action to do that. Starting to play a video when your scene is loaded far in the horizon will unnecessarily affect performance while players visit neighboring scenes.

## Handle a video file

When playing a video from a file, you can perform the following actions:

- `play()`: Plays the video. It will start from where the `seek` property indicates.

- `pause()`: Stops the video playing, but leaves its `seek` property where the video last was. The last played frame remains visible.

- `reset()`: Stops the video playing and sends its `seek` property back to the begining of the video. The first frame of the video is displayed.

- `seekTime()`: Sets the `seek` property to a specific value, so that the video plays from that point on. It's expressed in seconds after the video's original beginning.

You can also change the following properties:

- `loop`: Boolean that determines if the video is played continuously in a loop, or if it stops after playing once. _false_ by default.

- `playbackRate`: Changes the speed at which the video is played. _1_ by default.

- `volume`: Lets you change the volume of the audio. _1_ by default.

- `seek`: Allows you to set a different starting position on the video. It's expressed in seconds after the video's original beginning. _-1_ by default, which makes it start at the actual start of the video.

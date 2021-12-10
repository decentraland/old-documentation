---
date: 2020-11-24
title: Hardware acceleration
redirect_from:
description: Troubleshoot problems related to graphics processing performance
categories:
  - Decentraland
type: Document
---

Since Decentraland runs in a web browser, you might need to configure your browser and/or operating system to have access to all of your machine's potential to run Decentraland as smoothly as possible.

![]({{ site.baseurl }}/images/media/gpu.png)

If you see this warning, it means that you are using a sub-optimal set up for rendering 3d graphics. Your experience when playing Decentraland might be laggy and unresponsive because of this. You might notice missing frames as you move around in a jumpy way.

> Note: Some lower end machines, or machines that are not designed for gaming, may not have a _dedicated_ graphics card at all. If that's your case, then ignore this warning. You might still be able to improve how you experience Decentraland by opening the Settings panel and lowering the graphics quality.

## Context

Many machines have a _dedicated graphics card_, a piece of hardware that is specifically optimized for graphics processing (also called a GPU). This graphics card is not always in use, this may be done to save battery or because certain programs (like the web browser) are not expected to require heavy use of 3d graphics processing. If the _dedicated graphics card_ is off, the _integrated graphics card_ takes its place. This other graphics card is a lot less powerful. Unlike the _dedicated_ graphics card, the _integrated_ graphics card is not a separate piece of hardware, it's integrated into the machine's mother board.

The browser exposes settings to enable or disable the use of the _dedicated_ graphics card, but you may also need to change settings on your operating system to make this option truly available to the browser.

## Browser configuration

In Chrome or Brave:

- Open the _three dots menu_, select _Settings_
- Open _Advanced_ > _System_ (or directly search for "hardware")
- Tick _Use hardware acceleration when available_
- Restart the browser

<figure>
    <img src="{{ site.baseurl }}/images/media/chrome.png" alt="Chrome hardware settings" width="400"/>
</figure>

_On other browsers, the steps may vary slightly, but should be essentially the same._

> Note: If you keep seeing the warning message in Decentraland, you may also need to set up your operating system to allow the browser to access this hardware.

## Operating System configuration

### Mac

To set up hardware acceleration:

- Open _System Preferences_
- Open **Battery**
- Uncheck the box for _Automatic graphics switching_. This will keep the _dedicated_ graphics card always in use when applicable.

> Note: Having this option checked turns off the _dedicated graphics card_ whenever the laptop is unplugged. Another alternative is to always keep the machine plugged to a power outlet.

### Windows

To set up hardware acceleration:

- Right click anywhere on the desktop and select **Display Options**
- Scroll down to find the **Graphics Settings** link
- Under _Choose an app to set preference_ select _Chrome_ or your browser of choice
- Click on the app and click **Options**
- Under _Set graphics preference_, choose **High Performance** and click **Save**


### GNU/Linux

Note: Thes following instructions are meant for using with a Chromium-based browser and an NVIDIA GPU with drivers installed.

To set up hardware acceleration:

- Open up a terminal and run `sudo prime-select on-demand` then logout of your seesion and log back in.
- Open [chrome://flags](chrome://flags) in your browser and search for these flags and enable them:

```
#enable-gpu-rasterization
#enable-accelerated-video-decode
#enable-zero-copy
#enable-vulkan
```

- Hit Relaunch and close your browser again.
- To force your browser to use NVIDIA gpu; run it using terminal using these commands:
```__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia brave-browser```
or
```__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia google-chrome-stable```


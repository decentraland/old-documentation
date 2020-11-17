Since Decentraland runs in the browser, you might need to configure your browser and/or machine to be able to access all of your machine's potential to run Decentraland as smoothly as possible.

[image]

If you see this warning, it means that you are using a sub-optimal set up for rendering 3d graphics. Your experience playing Decentraland might be laggy and unresponsive because of this.

> Note: Some lower end machines, or machines that are not designed for gaming, may not have a _dedicated_ graphics card at all. If that's your case, then ignore this warning. You might still be able to improve how you experience Decentraland by opening the Settings panel and lowering the graphics quality.

## Context

Many machines have a _dedicated graphics card_, a piece of hardware that is specifically optimized for graphics processing. This graphics card is not always in use, this may be done to save battery or because certain programs (like the web browser) are not expected to require heavy use of 3d graphics processing. If the _dedicated graphics card_ is off, the _integrated graphics card_ takes its place. This other graphics card is a lot less powerful. Unlike the _dedicated_ graphics card, the _integrated_ graphics card is not a separate piece of hardware, it's integrated into the machine's mother board.

The browser exposes settings to enable or disable the use of the _dedicated_ graphics card, but you may also need to change settings on your operating system to make this option truly available to the browser.

## Browser configuration

In Chrome or Brave:

- Open the _three dots menu_, select _Settings_
- Open _Advanced_ > _System_ (or directly search for "hardware")
- Tick _Use hardware acceleration when available_
- Restart the browser

<figure>
    <img src="/images/media/chrome.png" alt="Chrome hardware settings" width="400"/>
</figure>

_On other browsers, the steps may vary slightly, but should be essentially the same._

> Note: If you keep seeing the warning message in Decentraland, you may also need to set up your operating system to allow the browser to access this hardware.

## Operating System configuration

### Mac

To set up hardware acceleration:

- Open _System Preferences_
- Open _Battery_
- Uncheck the box for _Automatic graphics switching_. This will keep the _dedicated_ graphics card always in use when applicable.

### Windows

In Windows there are three options you can always choose:

- Let each software choose what graphics card to use
- Always force the use of the _dedicated_ graphics card
- Always force the use of the _integrated_ graphics card

You need to make sure you're not using the third of these options.

On an NVIDIA card:

- Open the _NVIDIA Control Panel_
- Select _Manage 3D Settings_ and the _Program Settings_ tab
- Choose _Chrome_ or your browser of choice, and set the preferred graphics card to be _dedicated graphics_.
- Save your changes

<figure>
    <img src="/images/media/nvidia.png" alt="NVIDIA software settings" width="400"/>
</figure>

_With other hardware providers, the steps may vary slightly, but should be essentially the same._

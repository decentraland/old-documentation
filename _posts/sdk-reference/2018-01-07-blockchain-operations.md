---
date: 2018-01-07
title: Blockchain operations
description: Learn what the SDK offers for performing operations with the Ethereum blockchain
categories:
  - sdk-reference
type: Document
set: sdk-reference
set_order: 7
---

The SDK includes an _ethereum controller_ that can call a series of functions on your secene to perform actions on the Ethereum blockchain. For example, you can require that a user pays a fee before actioning something in your scene.

## Importing the Ethereum Controller

All of the operations that are possible on the Ethereum blockchain are done through the ethereum controller. You must first import it into your scene:

1.  Import the `EthereumController` to the .tsx file:

{% raw %}

```tsx
import {
  createElement,
  ScriptableScene,
  EthereumController,
  inject
} from "metaverse-api"
```

{% endraw %}

2.  Then inject the ethereum controller as a decorator into your custom scene class:

{% raw %}

```tsx
export default class myScene extends ScriptableScene {
  @inject("experimentalEthereumController") eth: EthereumController
  // (...)
}
```

{% endraw %}

## Require a payment

Once the `EthereumController` has been imported, you can run the `requirePayment` function. This function prompts the user to accept a paying a sum to an Ethereum wallet of your choice. Users must always accept payments manually, a payment can never be implied directly from the user's actions in the scene.

{% raw %}

```tsx
this.eth.requirePayment(receivingAddress, amount, currency)
```

{% endraw %}

The function requires that you specify an Ethereum wallet address to receive the payment, an ammount for the transaction and a specific currency to use (for example, MANA or ETH).

If accepted by the user, the function returns the hash number of the transaction that has been started.

{% raw %}

```tsx
const myWallet = ‘0x0123456789...’
const enterPrice = 10

// (...)

async sceneDidMount() {
  this.eventSubscriber.on(‘door_click’, async () => {
    await this.eth!.requirePayment(myWallet, entrancePrice, ‘MANA’)

    this.setState(isDoorClosed: !this.state.isDoorClosed)
  }
}
```

{% endraw %}

The example above listens for clicks on a `door` entity. When clicked, the user is prompted to make a payment in MANA to a specific wallet for a given ammount. Once the user accepts this payment, the rest of the function can be executed, in this case the `isDoorClosed` variable in the scene's state is changed. If the user doesn't accept the payment, the rest of the function won't be executed and the variable's state won't change.

![](/images/media/metamask_confirm.png)

> Tip: We recommend defining the wallet address and the ammount to pay as global constants at the start of the _.tsx_ file. These are values you might need to change in the future, setting them as constants makes it easier to update the code.

## Using the Ethereum test network

While testing your scene, to avoid transfering real MANA currency, you can use the _Ethereum Ropsten test network_ and transfer fake MANA instead.

To use the test network you must set your Metamask Chrome extension to use the _Ropsten test network_ instead of _Main network_. You must also own MANA in the Ropsten blockchain, which you can aquire for free from Decentraland.

To preview your scene using the test network, add the `DEBUG` property to the URL you're using to access the scene preview on your browser. For example, if you're accessing the scene via `http://127.0.0.1:8000/?position=0%2C-1`, you should set the URL to `http://127.0.0.1:8000/?DEBUG&position=0%2C-1`.

Any transactions that you accept while viewing the scene in this mode will only occur in the test network and not affect the MANA balance in your real wallet.

## Wait for a transaction

Another thing that the ethereum controller allows you to do is check if a specific transaction has been already mined. This looks for a specific transaction's hash number and verifies that it has been validated by a miner and added to the blockchain.

{% raw %}

```tsx
await this.eth.waitForMinedTx(currency, tx, receivingAddress)
```

{% endraw %}

The function requires that you specify a currency to use (for example, MANA or ETH), a transaction hash number and the Ethereum wallet address that received the payment.

{% raw %}

```tsx
const myWallet = ‘0x0123456789...’

// (...)

async sceneDidMount() {
  this.eventSubscriber.on(‘door_click’, async () => {
    const tx = await this.eth!.requirePayment(myWallet, entrancePrice, ‘MANA’)
    const userPaid = await this.eth!.waitForMinedTx(currency,tx, receivingAddress)
    this.setState(isDoorClosed: !this.state.isDoorClosed)
  }
}
```

{% endraw %}

The example above first requires the user to accept a transaction, if the user accepts it, then `requirePayment` returns a hash that can be used to track the transaction and see if it's been mined. Once the transaction is mined and accepted as part of the blockchain, the `isDoorClosed` variable in the scene state is changed.

<!--

## Signing messages

A user can sign a message using their Ethereum public key. This signature is a secure way to give consent or to register an accomplishment or action that is registered with the block chain. The signing of a message doesn't imply paying any gas fees on the Ethereum network.

Messages that can be signed need to be follow a specific format to match safety requirements. They must include the “Decentraland signed header” at the top, this prevents the possibility of any mismanagement of the user’s wallet.

Signable messages should follow this format:

```
# DCL Signed message
<key 1>: <value 1>
<key 2>: <value 2>
<key n>: <value n>
Timestamp: <time stamp>
```

For example, a signable message might look like this:

```tsx
# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678
```

Before a user can sign a message, you must first convert it into an object using the `convertMessageToObject()` function, then it can be signed with the `signMessage()` function.

{% raw %}

```tsx
const messageToSign = `# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678`

const convertedMessage = await this.eth!.convertMessageToObject(messageToSign)
const { message, signature } = await this.eth!.signMessage(convertedMessage)
```

{% endraw %}

#### Checking if a message is correct

To verify that the message that the user signed is in fact the one that you want to send, you can use the `utils.toHex` function, from the `decentraland-eth` package, to convert it and easily compare it.

To use this, you must first install some dependencies manually in your scene's directory. Navigate to your scene's folder and run the following:

```bash
npm install --save decentraland-eth
```

You must then import these dependencies on the _.tsx_ file

{% raw %}

```tsx
import { eth } from "decentraland-eth"
```

{% endraw %}

{% raw %}

```tsx
const { message, signature } = await this.eth!.signMessage(convertedMessage);

const messageHex = await eth.utils.toHex(messageToSign)
const isEqual = message === messageHex
console.log(‘Is the message correct?’, isEqual)
```

{% endraw %}

#### Example:

{% raw %}

```tsx
import { inject, EthereumController, createElement, ScriptableScene } from 'metaverse-api'
import { eth } from 'decentraland-eth'

const messageToSign = `# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678`

export default class SignMessage extends ScriptableScene {
 @inject('experimentalEthereumController')
 eth: EthereumController | null = null

 async sceneDidMount() {
   this.subscribeTo('click', async e => {
     if (e.elementId === 'button-sign') {
       await this.signMessage()
     }
   })
 }

 async signMessage() {
   const convertedMessage = await this.eth!.convertMessageToObject(messageToSign)
   const { message, signature } = await this.eth!.signMessage(convertedMessage)

   console.log({ message, signature })

   const messageHex = await eth.utils.toHex(messageToSign)

   const isEqual = message === messageHex
   console.log("Is the message correct?", isEqual)
 }

 async render() {
   return (
     <scene position={{ x: 5, y: 0, z: 5 }}>
       <entity position={{ x: -3, y: 1.4, z: -3 }}>
         <plane id="button-sign" scale={{ x: 0.8, y: 0.2, z: 1 }} color="#bada55" />
         <text value="Sign message" fontSize={60} color="black" />
       </entity>
     </scene>
   )
 }
```

{% endraw %}
-->

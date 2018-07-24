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



The SDK includes a series of functions that you can run in your project that perform actions on the Ethereum blockchain. For example, you can require that a user pays a fee before actioning something in your scene.

## Importing the Ethereum Controller

To use any of the operations on the Ethereum blockchain, you must first import the ethereum controller into your scene, to do this:

1) Import the ethereumController to the .tsx file:

```tsx
import { createElement, ScriptableScene, EthereumController, inject } from "metaverse-api"
```

2) Then inject the ethereum controller as a decorator into your custom scene class:

```tsx
export default class Scene extends ScriptableScene {
 @inject('experimentalEthereumController') 
 eth: EthereumController

(...)
```


## Require a payment


Once the ethereumController has been imported, you can run the requirePayment function. This function prompts the user to accept a payment. The user must always manually accept this payment, the acceptance of a payment can never be implied directly from the user's actions in the scene.


```tsx
this.eth!.requirePayment(
        receivingAddress,
        amount, 
        currency
    );
```

The function requires that you specify an Ethereum wallet address to receive the payment, an ammount for the transaction and a specific currency to use (for example, MANA or ETH).



```tsx
const myWallet = ‘0x0123456789...’;
const enterPrice = 10;

(...)

    async sceneDidMount() {
        this.eventSubscriber.on(‘door_click’, async () => {
            await this.eth!.requirePayment(myWallet, entrancePrice, ‘MANA’);

            this.setState(isDoorClosed: !this.state.isDoorClosed);
        }
    }
```

The example above listens for clicks on a `door` entity. When clicked, the user is prompted to make a payment in MANA to a specific wallet for a given ammount. Once the user accepts this payment, the `isDoorClosed` variable in the scene's state is changed. If the user doesn't accept the payment, the rest of the function won't be executed and the variable's state won't change.

![](/images/media/metamask_confirm.png)

> Tip: We recommend setting the wallet address and the ammount to pay as global constants in your scene. These are values you might need to change in the future, this makes it easier to update the code.


## Wait for a transaction

Another thing you can do, once the ethereum controller is imported, is check if a transaction has been already mined. This looks for a specific transaction and verifies that it has been validated by a miner and added to the blockchain.

```tsx
this.eth!.waitForMinedTx(
       currency,
       tx,
       receivingAddress
     );
```

The function requires that you specify a currency to use (for example, MANA or ETH), a transaction hash number and the Ethereum wallet address that received the payment.


```tsx
const myWallet = ‘0x0123456789...’;

(...)

    async sceneDidMount() {
        this.eventSubscriber.on(‘door_click’, async () => {
            const tx = await this.eth!.requirePayment(myWallet, entrancePrice, ‘MANA’);
            const userPaid = await this.eth!.waitForMinedTx(currency,tx, receivingAddress);
            this.setState(isDoorClosed: !this.state.isDoorClosed);
        }
    }
```

The example above first requires the user to accept a transaction, if the user accepts it, then the function will wait until the transaction is effectively mined by a miner in the Ethereum network. Once that happens the isDoorClosed variable in the scene state is changed.

## Signing messages

// There could be a case where you want to add another layer of protection. If your script wants to communicate with an external service or API, you can let the user sign the information he is being requested to send.

You can use a user's public key to sign a message in a secure way that is registered in the block chain. This can be used, for example, for users to vote or leave proof that they were at a certain place or did a certain thing.

Messages that can be signed need to be follow a specific format text to match safety validations. They must include the “Decentraland signed header” at the top, this prevents the possibility of any mismanagement of the user’s wallet.

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

Before you can sign a message, you must first convert it into an object using the `convertMessageToObject()` function, then you can sign it with the `signMessage()` function.

```tsx
const messageToSign = `# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678`

const convertedMessage = await this.eth!.convertMessageToObject(messageToSign);
const { message, signature } = await this.eth!.signMessage(convertedMessage);
// … do something with message and signature
```

### Checking if a message is correct

To verify that the message that the user signed is in fact the one that you want to send, you can use the `utils.toHex` function, from the `decentraland-eth` package, to convert it and easily compare it:

```tsx
import { eth } from 'decentraland-eth'

// inside your scene
await eth.utils.toHex(messageToSign)

// (...)

const { message, signature } = await this.eth!.signMessage(convertedMessage);

const messageHex = await eth.utils.toHex(messageToSign);
const isEqual = message === messageHex;
console.log(‘Is the message correct?’, isEqual);
```

### Example:

```tsx
import { inject, EthereumController, createElement, ScriptableScene } from 'metaverse-api/src'
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
   console.log(‘Is the message correct?’, isEqual)
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

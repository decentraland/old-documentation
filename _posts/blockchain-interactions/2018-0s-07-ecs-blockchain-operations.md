---
date: 2018-02-07
title: Scene blockchain operations
description: Learn what the SDK offers for performing operations with the Ethereum blockchain
categories:
  - blockchain-interactions
type: Document
set: blockchain-interactions
set_order: 7
---

If you're building a scene to upload to your LAND in Decentraland, the scene's code can interact directly with the Ethereum blockchain. This can be used to obtain information about the users entering your scene and what tokens they own,  to require a payment for activating something or even for selling virtual goods.

The _Ethereum controller_, included in the Decentraland SDK, is based on the `eth-connect` library, but it whitelists specific operations and includes additional operations.


Note that in most of the examples here, we're using an [async function]({{ site.baseurl }}{% post_url /development-guide/2018-02-25-async-functions %}) to run the blockchain operations. This is because it might take some time to retrieve data from the blockchain.

## Import the ethereum controller to your scene

The Ethereum controller is packaged as part of the Decentraland SDK, but it must be imported into a scene before it can be used.

All blockchain operations are  triggered through this controller.

```ts

```

## Obtain a user's public key

You can obtain a user's public Ethereum key by using `getUserPublicKey()`. You can then use this information to send payments to the user, or as a way to recognize users.

The example below imports the `Identity` library and runs `getUserPublicKey()` to get the public key of the user's Ethereum account and log it to console. The user must be logged into their Metamask account on their browser for this to work.

```ts
import { getUserPublicKey } from "@decentraland/Identity"

const publicKeyRequest = executeTask(async () => {
  const publicKey = await getUserPublicKey()
  log(publicKey)
  return publicKey
})

class IDSystem {
  update() {
    if (publicKeyRequest.didFail) {
      log("error fetching id" + publicKeyRequest.error)
    } else {
      log("id:" + publicKeyRequest.result)
    }
  }
}
```


## Require a payment

The `requirePayment` function prompts the user to accept paying a sum to an Ethereum wallet of your choice. 

Users must always accept payments manually, a payment can never be implied directly from the user's actions in the scene.


```tsx
eth.requirePayment(receivingAddress, amount, currency)
```


The function requires that you specify an Ethereum wallet address to receive the payment, an amount for the transaction and a specific currency to use (for example, MANA or ETH).

If accepted by the user, the function returns the hash number of the transaction that has been started.


```tsx
const myWallet = ‘0x0123456789...’
const enterPrice = 10

function payment(){
  executeTask(async () => {
    try {
      await eth.requirePayment(myWallet, entrancePrice, ‘MANA’)
      openDoor()
    } catch {
      log("failed process payment")
    }
  })
}

const button = new Entity()
button.set(new OnClick( _ => {
    payment()
  }))
```


The example above listens for clicks on a _button_ entity. When clicked, the user is prompted to make a payment in MANA to a specific wallet for a given amount. Once the user accepts this payment, the rest of the function can be executed. If the user doesn't accept the payment, the rest of the function won't be executed.

![](/images/media/metamask_confirm.png)

> Tip: We recommend defining the wallet address and the amount to pay as global constants at the start of the _.tsx_ file. These are values you might need to change in the future, setting them as constants makes it easier to update the code.


## Send a transaction

```
  @exposeMethod
  async sendAsync(message: RPCSendableMessage): Promise<any> {
    return sendAsync(message)
  }

  @exposeMethod
  async sendTransaction(options: TransactionOptions): Promise<TxHash> {
    return requestManager.eth_sendTransaction(options)
  }
```

## Get data before a transaction


```

  @exposeMethod
  async gasPrice(): Promise<BigNumber> {
    return requestManager.eth_gasPrice()
  }


  @exposeMethod
  async estimateGas(data: Partial<TransactionCallOptions> & Partial<TransactionOptions>): Promise<Quantity> {
    return requestManager.eth_estimateGas(data)
  }

    @exposeMethod
  async getBalance(address: Address, block: Quantity | Tag): Promise<BigNumber> {
    return requestManager.eth_getBalance(address, block)
  }
  


```

## Get data from executed transactions

```
@exposeMethod
  async getTransactionReceipt(hash: TxHash): Promise<TransactionReceipt> {
    return requestManager.eth_getTransactionReceipt(hash)
  }


  async getBlockNumber(block: Quantity | Tag, fullTransactionObjects: boolean): Promise<BlockObject> {
    return requestManager.eth_getBlockByNumber(block, fullTransactionObjects)
  }

  @exposeMethod
  async getTransactionCount(address: Address, block: Quantity | Tag): Promise<number> {
    return requestManager.eth_getTransactionCount(address, block)
  }
```

<!--



## The Ethereum Controller



2.  Then inject the ethereum controller as a decorator into your custom scene class:



```tsx
export default class myScene extends ScriptableScene {
  @inject("experimentalEthereumController")
  eth: EthereumController
  // (...)
}
```



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
import { inject, EthereumController, createElement, ScriptableScene } from 'decentraland-api'
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


## Using the Ethereum test network

While testing your scene, to avoid spending real MANA currency, and real Ether for gas fees, you can use the _Ethereum Ropsten test network_ and transfer fake MANA instead.

To use the test network you must set up your Metamask Chrome extension to use the _Ropsten test network_ instead of _Main network_.

You must also own MANA and Ether in the Ropsten blockchain. 

- For free Ropsten MANA, go to [MANA faucet](https://faucet.decentraland.today/).

- For free Ropsten Ether, there are various external faucets like [this one](https://faucet.ropsten.be/).

To preview your scene using the test network, add the `DEBUG` property to the URL you're using to access the scene preview on your browser. For example, if you're accessing the scene via `http://127.0.0.1:8000/?position=0%2C-1`, you should set the URL to `http://127.0.0.1:8000/?DEBUG&position=0%2C-1`.

Any transactions that you accept while viewing the scene in this mode will only occur in the test network and not affect the MANA or Ether balance in your real wallet.

---
date: 2018-01-07
title: Scene blockchain operations
description: Learn what the SDK offers for performing operations with the Ethereum blockchain
redirect_from:
  - /sdk-reference/blockchain-operations/
categories:
  - blockchain-interactions
type: Document
set: blockchain-interactions
set_order: 7
---

A Decentraland scene can interface with the Ethereum blockchain. This can serve to obtain data about the user's wallet and the tokens in it, or to trigger transactions that could involve any Ethereum token, fungible or non-fungible.

There currently are three tools to use for this, all of them specifically provided by Decentraland.

- The `Identity` library: used to obtain general user data from their Ethereum account.
- The `eth-connect` library: used to interface with Ethereum contracts and trigger transactions.
- The `Ethereum controller`: used for more low-level transactions.

Note that all transactions triggered by a scene will require a user to approve and pay a gas fee.

## User identity

#### Import the identity library

The identity library is ported with the Decentraland ECS. You can simply import it into a scene without any additional steps.

```ts
import { getUserPublicKey, getUserData } from '@decentraland/Identity'
```

#### Get a public key

You can obtain a user's public Ethereum key by using `getUserPublicKey()`. You can then use this information to send payments to the user, or as a way to recognize users.


```ts
import { getUserPublicKey } from '@decentraland/Identity'

executeTask(async () => {
  let key = await getUserPublicKey()
  log(key)
})

```

> Note: The user must be logged into their Metamask account on their browser for this method to work.

#### Get other user data

You can obtain other user data via the `getUserData()` function. This function returns the following data:

- displayName: the user's name Decentraland
- publicKey: the user's Ethereum public key

```ts
import { getUserPublicKey } from '@decentraland/Identity'

executeTask(async () => {
  let userData = await getUserData()
  log(userData)
})

```

> Note: The user must be logged into their Metamask account on their browser for this method to work.

## Interact with contracts

#### Download and import the eth-connect library

The eth-connect library is made and maintained by Decentraland. It's based on the popular [Web3.js](https://github.com/ethereum/web3.js/) library, but it's fully written in TypeScript and features a few improvements of our own.

To use eth-connect library, you must manually install the package via `npm` in your scene's folder. To do so, run the following command in the scene folder:

```
npm install eth-connect
```

> Note: Decentraland scenes don't support older versions than 4.0 of the eth-connect library.

> Note: Currently, we don't allow installing other dependencies via npm that are not created by Decentraland.

To use the eth-connect controller in your scene, you must import it from the scene code:

```ts
import * as EthConnect from '../node_modules/eth-connect/esm'
```



> Note: The eth-connect library is currently lacking more in-depth documentation. Since this library is mostly based on the Web3.js library and most of the function names are intentionally identical to those in Web3.js, it can often be helpful to refer to the [Web3's documentation](https://web3js.readthedocs.io/en/1.0/).


#### Import a contract ABI

An ABI (Application Binary Interface) describes how to interact with an Ethereum contract, determining what functions are available, what inputs they take and what they output. Each Ethereum contract has its own ABI, you should import the ABIs of all the contracts you wish to use in your project.

For example, here's an example of one function in the MANA ABI:

```json
{
  anonymous: false,
  inputs: [
    {
      indexed: true,
      name: 'burner',
      type: 'address'
    },
    {
      indexed: false,
      name: 'value',
      type: 'uint256'
    }
  ],
  name: 'Burn',
  type: 'event'
}
```

ABI definitions can be quite lengthy, as they often include a lot of functions, so we recommend pasting the JSON contents of an ABI file into a separate `.ts` file and importing it into other scene files from there. We also recommend holding all ABI files in a separate folder of your scene, named `/contracts`.

Ether:
https://solidity.readthedocs.io/en/develop/abi-spec.html

MANA:
https://etherscan.io/address/0x0f5d2fb29fb7d3cfee444a200298f468908cc942#code


fake MANA?:

> Tip: For contracts that follow a same standard, such as ERC20 or ERC721, you can import a single generic ABI for all. You then generate a single `ContractFactory` object and use that to instance interfaces for each contract.

#### Call the methods in a contract

After importing the `eth-connect` library and a contract's _abi_, you can call the methods in the contract.

Before you do, you must

```ts
import { getProvider } from '@decentraland/web3-provider'
import { getUserPublicKey } from '@decentraland/Identity'
import * as EthConnect from '../../../node_modules/eth-connect/esm'

const abi =   //////////////////

executeTask(async () => {
  // create an instance of the web3 provider to interface with Metamask
  const provider = await getProvider()
  // Create the object that will send the messages
  const requestManager = new EthConnect.RequestManager(provider)
  // Create a factory object based on the contract
  const factory = new EthConnect.ContractFactory(requestManager, abi)
  // Instance a `contract` object from the factory
  const contract = (await factory.at('0x2a8fd99c19271f4f04b1b7b9c4f7cf264b626edb')) as any
  // Perform a function from the contract
  const res = await contract.setBalance('0xaFA48Fad27C7cAB28dC6E970E4BFda7F7c8D60Fb', 100, {
    from: await getUserPublicKey()
  })
  // Log response
  log(res)
})

```

The example above imports the abi for the Ropsten MANA contract and transfers 100 _fake MANA_ to your account in the Ropsten test network when you open it.




<!--
## Web3 API

We have only whitelisted the following methods from the API, all others are currently not supported:

- eth_sendTransaction
- eth_getTransactionReceipt
- eth_estimateGas
- eth_call
- eth_getBalance
- eth_getStorageAt
- eth_blockNumber
- eth_gasPrice
- eth_protocolVersion
- net_version
- eth_getTransactionCount
- eth_getBlockByNumber


Below is a sample that uses this API to get the contents of a block in the blockchain.


```tsx
import { createElement, ScriptableScene } from "decentraland-api"
import Web3 = require("web3")

export default class EthereumProvider extends ScriptableScene {
  async sceneDidMount() {
    const provider = await this.getEthereumProvider()
    const web3 = new Web3(provider)

    web3.eth.getBlock(48, function(error: Error, result: any) {
      console.log("Eth block 48 (from scene)", result)
    })
  }

  async render() {
    return <scene />
  }
}
```


-->

## Lower level functions




Another way to perform operations on the Ethereum blockchain is through the _ethereum controller_ library. This controller is packaged with the SDK, so you don't need to run any manual installations. This controller is lower level than `eth-connect`, so it's tougher to use but more flexible.

To import the Ethereum controller into your scene file:


```ts
import * as EthereumController from "@decentraland/EthereumController"
```

The examples below show some of the things you can do with this controller.


#### Async sending

Use the function `sendAsync()` to send messages over [RPC protocol](https://en.wikipedia.org/wiki/Remote_procedure_call).

```ts
 /**
   * Used to build a Ethereum provider
   */
  export function sendAsync(message: RPCSendableMessage): Promise<any>
```



#### Signing messages

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

```ts
# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678
```

Before a user can sign a message, you must first convert it from a string into an object using the `convertMessageToObject()` function, then it can be signed with the `signMessage()` function.

```ts
const messageToSign = `# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678`

const convertedMessage = await this.eth!.convertMessageToObject(messageToSign)
const { message, signature } = await this.eth!.signMessage(convertedMessage)
```


#### Checking if a message is correct

To verify that the message that the user signed is in fact the one that you want to send, you can use the `utils.toHex` function, from the `decentraland-eth` package, to convert it and easily compare it.

To use this, you must first install some dependencies manually in your scene's directory. Navigate to your scene's folder and run the following:

```bash
npm install --save decentraland-eth
```

You must then import these dependencies on the _.tsx_ file


```tsx
import { eth } from "decentraland-eth"
```

new functions...

personal_sign   -> eth-connect  (dentro de request manager)

signMessage -> de ethereum controller

toHex ->  debe haber algo en eth-connect

const signature = await requestManager.personal_sign(message, account, 'test')
const signerAddress = await requestManager.personal_ecRecover(message, signature)



```tsx
const { message, signature } = await this.eth!.signMessage(convertedMessage);

const messageHex = await eth.utils.toHex(messageToSign)
const isEqual = message === messageHex
console.log(‘Is the message correct?’, isEqual)
```
Below is a full example that signs a message and checks its validity


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
     <scene >
       <entity >
         <plane id="button-sign" color="#bada55" />
         <text value="Sign message" fontSize={60} color="black" />
       </entity>
     </scene>
   )
 }
```



## Using the Ethereum test network

While testing your scene, to avoid transferring real MANA currency, you can use the _Ethereum Ropsten test network_ and transfer fake MANA instead.

To use the test network you must set your Metamask Chrome extension to use the _Ropsten test network_ instead of _Main network_.

You must also own MANA in the Ropsten blockchain. To obtain free Ropsten mana in the test network, go to our [MANA faucet](https://faucet.decentraland.today/).

> Tip: To run the transaction of transferring Ropsten MANA to your wallet, you will need to pay a gas fee in Ropsten Ether. If you don't have Ropsten Ether, you can obtain it for free from various external faucets like [this one](https://faucet.ropsten.be/).

To preview your scene using the test network, add the `DEBUG` property to the URL you're using to access the scene preview on your browser. For example, if you're accessing the scene via `http://127.0.0.1:8000/?position=0%2C-1`, you should set the URL to `http://127.0.0.1:8000/?DEBUG&position=0%2C-1`.

Any transactions that you accept while viewing the scene in this mode will only occur in the test network and not affect the MANA balance in your real wallet.
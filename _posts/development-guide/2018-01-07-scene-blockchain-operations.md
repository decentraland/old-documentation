---
date: 2018-01-07
title: Scene blockchain operations
description: Learn what the SDK offers for performing operations with the Ethereum blockchain
redirect_from:
  - /sdk-reference/blockchain-operations/
  - /blockchain-interactions/scene-blockchain-operations
  - /blockchain-integration/scene-blockchain-operations
categories:
  - development-guide
type: Document
---

A Decentraland scene can interface with the Ethereum blockchain. This can serve to obtain data about the user's wallet and the tokens in it, or to trigger transactions that could involve any Ethereum token, fungible or non-fungible. This can be used in many ways, for example to sell tokens, to reward tokens as part of a game-mechanic, to change how a player interacts with a scene if they own certain tokens, etc.

The following tools currently exist, all of them provided by Decentraland:

<!--
- The `Identity` library: used to obtain general player data.
-->

- The `Ethereum controller`: A basic library that offers some limited but simple functionality.
- The `eth-connect` library: A lower level library to interface with Ethereum contracts and call their functions, for example to trigger transactions or check balances.

Note that all transactions triggered by a scene will require a player to approve and pay a gas fee.

All blockchain operations also need to be carried out as [asynchronous functions]({{ site.baseurl }}{% post_url /development-guide/2018-02-25-async-functions %}), since the timing depends on external events.

When running a preview of a scene that uses one of the ethereum libraries, you must have Metamask open in your browser and you must run the preview with:

```
dcl start --web3
```

<!--

## User identity

#### Import the identity library

The identity library is ported with the Decentraland ECS. Simply import it into a scene, no additional steps are needed.

```ts
import { getUserPublicKey, getUserData } from '@decentraland/Identity'
```

#### Get a public key

You can obtain a user's public Ethereum key by using the `getUserPublicKey()` function.


```ts
import { getUserPublicKey } from '@decentraland/Identity'

executeTask(async () => {
  let key = await getUserPublicKey()
  log(key)
})

```
The user's public key is necessary to send payments or other transactions that involve the user. The public key can also be used as a persisting ID to recognize a user over multiple sessions.

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

Users can change their display name at any time while in Decentraland. For this reason, the public key is generally a more recommendable way to keep track of users over time.

> Note: The user must be logged into their Metamask account on their browser for this method to work.

-->

## Ethereum controller library

The simplest way to perform operations on the Ethereum blockchain is through the _ethereum controller_ library. This controller is packaged with the SDK, so you don't need to run any manual installations.

To import the Ethereum controller into your scene file:

```ts
import * as EthereumController from "@decentraland/EthereumController"
```

Below we explain some of the things you can do with this controller.

## Get a player's ethereum account

Use the `getUserAccount()` function from the EthereumController to find a player's Ethereum public key.

```ts
import { getUserAccount } from "@decentraland/EthereumController"

executeTask(async () => {
  try {
    const address = await getUserAccount()
    log(address)
  } catch (error) {
    log(error.toString())
  }
})
```

As shown in the example above, you should wrap the function in an `async()` function, learn more about this in [async functions]({{ site.baseurl }}{% post_url /development-guide/2018-02-25-async-functions %})

The following example keeps track of provided addresses.

```ts
import { getUserAccount } from "@decentraland/EthereumController"

let registeredAddresses: String[] = []

executeTask(async () => {
  try {
    const address = await getUserAccount()
    let lowerCaseAddress = address.toLowerCase()
    for (let i = 0; i < registeredAddresses.length; i++) {
      if (lowerCaseAddress == registeredAddresses[i]) {
        log("already registered")
      } else {
        registeredAddresses.push(lowerCaseAddress)
      }
    }
  } catch (error) {
    log(error.toString())
  }
})
```

> Note: Even though the eth address may contain upper case characters, some browsers convert the returned string to lower case automatically. If you wish compare address values and have it work on all browsers, use the `.toLowerCase()` method to convert the value into lower case.

## Sign messages

A player can sign a message using their Ethereum public key. This signature is a secure way to give consent or to register an accomplishment or action that is registered with the block chain.

The signing of a message isn't a transaction, so it doesn't imply paying any gas fees on the Ethereum network, it does however open a pop-up to ask the player for consent.

Messages that can be signed need to follow a specific format to match safety requirements. They must include the “Decentraland signed header” at the top, this prevents the possibility of any mismanagement of the player’s wallet.

Signable messages should follow this format:

```
# DCL Signed message
<key 1>: <value 1>
<key 2>: <value 2>
<key n>: <value n>
Timestamp: <time stamp>
```

For example, a signable message for a game might look like this:

```ts
# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678
```

Before a player can sign a message, you must first convert it from a string into an object using the `convertMessageToObject()` function, then it can be signed with the `signMessage()` function.

```ts
import * as EthereumController from "@decentraland/EthereumController"

const messageToSign = `# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678`

let eth = EthereumController

executeTask(async () => {
  const convertedMessage = await eth.convertMessageToObject(messageToSign)
  const { message, signature } = await eth.signMessage(convertedMessage)
  log({ message, signature })
})
```

## Check if a message is correct

To verify that the message that the player signed is in fact the one that you want to send, you can use the `toHex()` function from `eth-connect` library, to convert it and easily compare it. See further below for instructions on how to import the `eth-connect` library.

```ts
import { toHex } from "eth-connect"
import * as EthereumController from "@decentraland/EthereumController"

const messageToSign = `# DCL Signed message
Attacker: 10
Defender: 123
Timestamp: 1512345678`

let eth = EthereumController

function signMessage(msg: string) {
  executeTask(async () => {
    const convertedMessage = await eth.convertMessageToObject(msg)
    const { message, signature } = await eth.signMessage(convertedMessage)
    log({ message, signature })

    const originalMessageHex = await toHex(msg)
    const sentMessageHex = await toHex(message)
    const isEqual = sentMessageHex === originalMessageHex
    log("Is the message correct?", isEqual)
  })
}

signMessage(messageToSign)
```

#### Require a payment

The `requirePayment()` function prompts the player to accept paying a sum to an Ethereum wallet of your choice.

Players must always accept payments manually, a payment can never be implied directly from the player's actions in the scene.

```ts
eth.requirePayment(receivingAddress, amount, currency)
```

The function requires that you specify an Ethereum wallet address to receive the payment, an amount for the transaction and a specific currency to use (for now only `ETH` is supported).

If accepted by the player, the function returns the hash number of the transaction.

> Warning: This function informs you that a transaction was requested, but not that it was confirmed. If the gas price is too low, or it doesn't get mined for any reason, the transaction won't be completed.

```ts
const myWallet = ‘0x0123456789...’
const enterPrice = 0.05

function payment(){
  executeTask(async () => {
    try {
      await eth.requirePayment(myWallet, enterPrice, 'ETH')
      openDoor()
    } catch {
      log("failed process payment")
    }
  })
}

const button = new Entity()
button.addComponent(new BoxShape())
button.addComponent(new OnClick( e => {
    payment()
  }))
engine.addEntity(button)
```

The example above listens for clicks on a _button_ entity. When clicked, the player is prompted to make a payment in ETH to a specific wallet for a given amount. Once the player accepts this payment, the rest of the function can be executed. If the player doesn't accept the payment, the rest of the function won't be executed.

![]({{ site.baseurl }}/images/media/metamask_confirm.png)

> Tip: We recommend defining the wallet address and the amount to pay as global constants at the start of the _.ts_ file. These are values you might need to change in the future, setting them as constants makes it easier to update the code.

<!--
#### Wait for a transaction to be mined

The Ethereum controller allows you to check if a specific transaction has been already mined. It looks for a specific transaction's hash number and verifies that it has been validated by a miner and added to the blockchain.

> Important: Because of how a blockchain works, there might be [reorgs]({{ site.baseurl }}{% post_url /blockchain-integration/2018-01-01-ethereum-essentials %}#blockchain-reorgs) of the network that can lead to a mined transaction being reverted. A transaction that was confirmed once by one node has no guarantee of ending up in the official consensus of the network. We don't advise relying on this function for dealing with things that are of value.


```ts
await this.eth.waitForMinedTx(currency, tx, receivingAddress)
```


```ts
const myWallet = ‘0x0123456789...’
const enterPrice = 0.05

function payment(){
  executeTask(async () => {
    try {
      const tx = await eth.requirePayment(myWallet, entrancePrice, ‘ETH’)
      await eth.waitForMinedTx(‘ETH’, tx, myWallet)
      openDoor()
    } catch {
      log("failed process payment")
    }
  })
}

const button = new Entity()
button.addComponent(new BoxShape())
button.addComponent(new OnClick( e => {
    payment()
  }))
engine.addEntity(button)
```

The example above first requires the player to accept a transaction, if the player accepts it, then `requirePayment` returns a hash that can be used to track the transaction and see if it's been mined. Once the transaction is mined and accepted as part of the blockchain, the `openDoor()` function is called.
-->

## Async sending

Use the function `sendAsync()` to send messages over [RPC protocol](https://en.wikipedia.org/wiki/Remote_procedure_call).

```ts
import * as EthereumController from "@decentraland/EthereumController"

// send a message
await eth!.sendAsync(myMessage)
```

## Lower level operations

The eth-connect library is made and maintained by Decentraland. It's based on the popular [Web3.js](https://github.com/ethereum/web3.js/) library, but it's fully written in TypeScript and features a few security improvements.

This controller operates at a lower level than the _Ethereum controller_ (in fact the _Ethereum controller_ is built upon it) so it's tougher to use but more flexible.

It's main use is to call functions in a contract, it also offers a number of helper functions for various tasks. Check it out on [GitHub](https://github.com/decentraland/eth-connect).

> Note: The eth-connect library is currently lacking more in-depth documentation. Since this library is mostly based on the Web3.js library and most of the function names are intentionally kept identical to those in Web3.js, it can often help to refer to [Web3's documentation](https://web3js.readthedocs.io/en/1.0/).

#### Download and import the eth-connect library

To use eth-connect library, you must manually install the package via `npm` in your scene's folder. To do so, run the following command in the scene folder:

```
npm install eth-connect -B
```

> Note: Decentraland scenes don't support older versions than 4.0 of the eth-connect library.

> Note: Currently, we don't allow installing other dependencies via npm that are not created by Decentraland. This is to keep scenes well sandboxed and prevent malicious code.

Once installed, you can import whatever you need from `eth-connect` to the scene's code:

```ts
import { toHex } from "eth-connect"
```

#### Import a contract ABI

An ABI (Application Binary Interface) describes how to interact with an Ethereum contract, determining what functions are available, what inputs they take and what they output. Each Ethereum contract has its own ABI, you should import the ABIs of all the contracts you wish to use in your project.

For example, here's an example of one function in the MANA ABI:

```ts
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

```ts
import { abi } from "../contracts/mana"
```

Here are links to different Decentraland contracts. Obtain the ABI for each contract by clicking _Export ABI_ and choosing _JSON Format_.

- [MANA Token ABI](https://etherscan.io/address/0x0f5d2fb29fb7d3cfee444a200298f468908cc942#code)
- [Decentraland Marketplace](https://etherscan.io/address/0x19a8ed4860007a66805782ed7e0bed4e44fc6717#code)
- [LAND ABI](https://etherscan.io/address/0xf87e31492faf9a91b02ee0deaad50d51d56d5d4d#code)
- [Estate ABI](https://etherscan.io/address/0x959e104e1a4db6317fa58f8295f586e1a978c297#code)
- [AvatarNameRegistry ABI](https://etherscan.io/address/0x894b883905bfEe2CC448880F1b59f4A762E67566)
- [Catalyst ABI](https://etherscan.io/address/0xcc054fab08127c19f621ab83ade5962cd10584ec)

These are the contracts for the various wearable collections: (each collection was emitted as a separate contract)

- [ExclusiveMasksCollection ABI](https://etherscan.io/address/0xc04528c14c8ffd84c7c1fb6719b4a89853035cdd)
- [Halloween2019Collection ABI](https://etherscan.io/address/0xc1f4b0eea2bd6690930e6c66efd3e197d620b9c2)
- [Halloween2019CollectionFactory ABI](https://etherscan.io/address/0x07ccfd0fbada4ac3c22ecd38037ca5e5c0ad8cfa)
- [Xmas2019Collection ABI](https://etherscan.io/address/0xc3af02c0fd486c8e9da5788b915d6fff3f049866)
- [MCHCollection ABI](https://etherscan.io/address/0xf64dc33a192e056bb5f0e5049356a0498b502d50)
- [CommunityContestCollection ABI](https://etherscan.io/address/0x32b7495895264ac9d0b12d32afd435453458b1c6)
- [DCLLaunchCollection ABI](https://etherscan.io/address/0xd35147be6401dcb20811f2104c33de8e97ed6818)
- [DCGCollection ABI](https://etherscan.io/address/0x3163d2cfee3183f9874e2869942cc62649eeb004)

> TIP: To clearly see the functions exposed by a contract, open it in [abitopic.io](https://abitopic.io). Just paste the contract address there and open the _functions_ tab to see the full list of supported functions and their arguments. You can even test calling the functions with different parameters via the webpage.

Configuring TypeScript to be able to import from a JSON file has its difficulties. The recommended easier workaround is to change the `ABI.JSON` file's extension to `.ts` and modifying it slightly so that it its content starts with `export default`.

For example, if the ABI file's contents starts with `[{"constant":true,"inputs":[{"internalType":"bytes4" ...etc`, modify it so that it starts with `export default [{"constant":true,"inputs":[{"internalType":"bytes4" ...etc`.

#### Instance a contract

After importing the `eth-connect` library and a contract's _abi_, you must instance several objects that will allow you to use the functions in the contract and connect to Metamask in the player's browser.

You must also import the web3 provider. This is because Metamask in the player's browser uses web3, so we need a way to interact with that.

```ts
import { RequestManager, ContractFactory } from "eth-connect"
import { abi } from "../contracts/mana"
import { getProvider } from "@decentraland/web3-provider"

executeTask(async () => {
  // create an instance of the web3 provider to interface with Metamask
  const provider = await getProvider()
  // Create the object that will handle the sending and receiving of RPC messages
  const requestManager = new RequestManager(provider)
  // Create a factory object based on the abi
  const factory = new ContractFactory(requestManager, abi)
  // Use the factory object to instance a `contract` object, referencing a specific contract
  const contract = (await factory.at(
    "0x2a8fd99c19271f4f04b1b7b9c4f7cf264b626edb"
  )) as any
})
```

Note that several of these functions must be called using `await`, since they rely on fetching external data and can take some time to be completed.

> Tip: For contracts that follow a same standard, such as ERC20 or ERC721, you can import a single generic ABI for all. You then generate a single `ContractFactory` object with that ABI and use that same factory to instance interfaces for each contract.

#### Call the methods in a contract

Once you've created a `contract` object, you can easily call the functions that are defined in its ABI, passing it the specified input parameters.

```ts
import { getProvider } from "@decentraland/web3-provider"
import { getUserAccount } from "@decentraland/EthereumController"
import { RequestManager, ContractFactory } from "eth-connect"
import { abi } from "../contracts/mana"

executeTask(async () => {
  try {
    // Setup steps explained in the section above
    const provider = await getProvider()
    const requestManager = new RequestManager(provider)
    const factory = new ContractFactory(requestManager, abi)
    const contract = (await factory.at(
      "0x2a8fd99c19271f4f04b1b7b9c4f7cf264b626edb"
    )) as any
    const address = await getUserAccount()
    log(address)

    // Perform a function from the contract
    const res = await contract.setBalance(
      "0xaFA48Fad27C7cAB28dC6E970E4BFda7F7c8D60Fb",
      100,
      {
        from: address,
      }
    )
    // Log response
    log(res)
  } catch (error) {
    log(error.toString())
  }
})
```

The example above uses the abi for the Ropsten MANA contract and transfers 100 _fake MANA_ to your account in the Ropsten test network.

#### Other functions

The eth-connect library includes a number of other helpers you can use. For example to:

- Get an estimated gas price
- Get the balance of a given address
- Get a transaction receipt
- Get the number of transactions sent from an address
- Convert between various formats including hexadecimal, binary, utf8, etc.

<!--

#### Obtain gas price


 * Generates and returns an estimate of how much gas is necessary to allow the transaction to complete.
     * The transaction will not be added to the blockchain. Note that the estimate may be significantly more
     * than the amount of gas actually used by the transaction, for a variety of reasons including EVM mechanics
     * and node performance.
     */
    eth_estimateGas: (data: Partial<TransactionCallOptions> & Partial<TransactionOptions>) => Promise<Quantity>;
    /** Returns information about a block by hash. */

  @exposeMethod
  async estimateGas(data: Partial<TransactionCallOptions> & Partial<TransactionOptions>): Promise<Quantity> {
    return requestManager.eth_estimateGas(data)
  }

#### Get Balance

 /** Returns the balance of the account of given address. */
    eth_getBalance: (address: Address, block: BlockIdentifier) => Promise<BigNumber>;


      @exposeMethod
  async getBalance(address: Address, block: Quantity | Tag): Promise<BigNumber> {
    return requestManager.eth_getBalance(address, block)
  }

## Get data from executed transactions

 /**
     * Returns the receipt of a transaction by transaction hash.
     * Note That the receipt is not available for pending transactions.
     */
    eth_getTransactionReceipt: (hash: TxHash) => Promise<TransactionReceipt>;

@exposeMethod
  async getTransactionReceipt(hash: TxHash): Promise<TransactionReceipt> {
    return requestManager.eth_getTransactionReceipt(hash)
  }


  /** Returns the number of transactions sent from an address. */
    eth_getTransactionCount: (address: Address, block: BlockIdentifier) => Promise<number>;

  @exposeMethod
  async getTransactionCount(address: Address, block: Quantity | Tag): Promise<number> {
    return requestManager.eth_getTransactionCount(address, block)
  }
-->

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


```ts
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

<!--

const signature = await requestManager.personal_sign(message, account, 'test')
const signerAddress = await requestManager.personal_ecRecover(message, signature)


/**
     * The sign method calculates an Ethereum specific signature with:
     *   sign(keccack256("Ethereum Signed Message:" + len(message) + message))).
     *
     * By adding a prefix to the message makes the calculated signature recognisable as an Ethereum specific signature.
     * This prevents misuse where a malicious DApp can sign arbitrary data (e.g. transaction) and use the signature to
     * impersonate the victim.
     *
     * See ecRecover to verify the signature.
     */
    personal_sign: (data: Data, signerAddress: Address, passPhrase: Data) => Promise<Data>;
    /**
     * ecRecover returns the address associated with the private key that was used to calculate the signature in
     * personal_sign.
     */
    personal_ecRecover: (message: Data, signature: Data) => Promise<Address>;
    constructor(provider: any);

-->

## Using the Ethereum test network

While testing your scene, to avoid transferring real MANA currency, you can use the _Ethereum Ropsten test network_ and transfer fake MANA instead.

To use the test network you must set your Metamask Chrome extension to use the _Ropsten test network_ instead of _Main network_.

You must also own MANA in the Ropsten blockchain. To obtain free Ropsten mana in the test network, go to our [MANA faucet](https://faucet.decentraland.io/).

> Tip: To run the transaction of transferring Ropsten MANA to your wallet, you will need to pay a gas fee in Ropsten Ether. If you don't have Ropsten Ether, you can obtain it for free from various external faucets like [this one](https://faucet.ropsten.be/).

To preview your scene using the test network, add the `DEBUG` property to the URL you're using to access the scene preview on your browser. For example, if you're accessing the scene via `http://127.0.0.1:8000/?position=0%2C-1`, you should set the URL to `http://127.0.0.1:8000/?DEBUG&position=0%2C-1`.

Any transactions that you accept while viewing the scene in this mode will only occur in the test network and not affect the MANA balance in your real wallet.

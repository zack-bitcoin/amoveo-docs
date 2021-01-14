## Amoveo White Paper

## Table of Contents
* Abstract
* Motivation
* Blockchain Consensus Protocol
* Accounts
* Oracles
* Governance
* Smart Contracts 
* Derivatives and synthetic assets
* Markets
* Light Nodes
* stateless full nodes
* Example Use Cases
* Oracle Game Theory


## Abstract

Blockchain is a form of cryptographic database technology. Each blockchain hosts a cryptocurrency. Cryptocurrencies are a form of wealth that is made secure by blockchain technology.
Amoveo is a blockchain which secures a cryptocurrency called Veo.
Using Veo in the markets, you can buy and sell risk in anything.
With Amoveo it is impossible for customers to steal from a market, and it is impossible for the market to steal from its customers.


## Motivation

Separating church and state is good. It makes both the church and the state less dangerous.
Combining religious convictions with a monopoly on violence was deadly. It meant that people could be easily convinced to kill you at any time, and there was no consequence to the religious leader who called for your death. 

Separating finance and state will also be good. It will make both the state and finance less dangerous.
Combining finance with a monopoly on violence means that we can't truly trust the finance system. The people who are holding our money are able to steal our money without consequence. This is a terrible combination.
[Amoveo mission statement](mission_statement.md)


## Blockchain Consensus Protocol

Amoveo is secured by Nakamoto consensus, like Bitcoin. In this system some people act as miners. They receive a reward for producing blocks. Producing a block involves doing an expensive calculation called proof-of-work. The difficulty of this proof-of-work changes so that the rate of block production stays about 10 minutes.
To interact with Amoveo, you create transactions that get included in blocks. Miners will include your transaction in their blocks because you pay them a fee.
[Read more about the Amoveo transaction types here](design/transaction_types.md).


## Accounts

Amoveo accounts work similarly to accounts in other blockchains, like Ethereum.

Accounts are data structures recorded in the blockchain consensus state. Each account has a positive balance of Veo that it can spend to other accounts by making transactions. Anyone with sufficient Veo to pay the fee can create new accounts. Spending from an account requires a signature from the private key that the owner of the account knows. To give someone Veo, you need to know their public key.

Accounts are stored in one of the consensus state merkle trees. [Read more about the trees used in Amoveo here](design/trees.md).


## Oracles
For a small fee, anyone can ask the oracle any question about publicly available data.
The result provided by the oracle is honest.
We use the oracle to settle bets.
The oracle can settle in 3 states: True, False, Bad Question.

Amoveo oracles do not depend on any trading fees in order to provide accurate data to the blockchain.
Instead, the oracle is based on an escalation-betting game with a nash equilibrium of honesty.

The lack of trading fees not only makes the Amoveo oracle more affordable, it is also a necessary feature to prevent the oracle-parasite problem. The oracle-parasite problem is when an attacker blockchain oracle is set up to automatically provide the same outcome as an existing victim blockchain oracle, and undercuts on fees, as a way to steal customers and fees from the victim. If enough fees are stolen, then the victim doesn't have enough funds to maintain security, and both the attacker oracle and the victim oracle will fail to provide accurate data.

Amoveo's oracle is the only existing blockchain oracle design that is immune to the oracle-parasite problem

The Amoveo oracle does not usually have much collateral at stake, so the cost of launching an oracle is small. To launch an oracle, you pay just enough to provide a small prize for whoever reports the result on-chain.

[Read more about oracles here](design/oracle.md)


## Governance

Using the oracle mechanism we can trustlessly report to the amoveo blockchain about the results from futarchy markets. This way we can adjust the parameters that define the Amoveo blockchain. The mechanism is built with the goal that the oracle will choose parameters that improve Amoveo.
[Read more about governance here](design/governance.md)


## Smart Contracts

Amoveo is a blockchain for financial derivatives. The smart contract system is Turing complete, so any kind of contract is technically possible. Amoveo is highly optimized for financial derivatives. It is not recommended to use Amoveo to make other kinds of contracts.

Amoveo smart contracts are optimized to be scalable and affordable. [How to make smart contracts scalable](design/smart_contracts_as_derivatives.md) 

You can learn more about amoveo contracts and the history of how we ended up using this design [here](design/smart_contracts.md)

[Amoveo smart contracts in the context of truthcoin](design/truthcoin_contracts.md)

Amoveo uses the chalang VM for our smart contracts. [learn more about chalang in the chalang github page](https://github.com/zack-bitcoin/chalang) Chalang is a forth-like VM, heavily influenced by Bitcoin script and the Ethereum VM.


## Derivatives and synthetic assets

Veo is the native currency of Amoveo. All other assets in Amoveo are derivatives collateralized by Veo.
So, Amoveo does not work well for ICOs, but Amoveo does support other better forms of fundraising.

Derivatives are very versatile. 
With derivatives, as an example, you can build an asset that stays the same value as a Euro. It is a synthetic asset. 
You can send these synthetic-Euros to your friends, and treat them like Euros.
You could participate in a market that is priced in synthetic-Euros.
You could use the synthetic Euros as collateral for other contracts.


## Markets

The killer app of blockchain is a scalable market to trade assets whose price is determined by a trust-free and affordable oracle.

Amoveo uses 2 tools to enable markets.
Amoveo has on-chain constant product market makers, similar to the Uniswap protocol on Ethereum.
Amoveo supports off-chain order books with limit orders.

[Markets and synthetic assets are a critical component to enable secure cross-chain atomic swapping](design/state_channel_without_off_chain_market.md).


## light nodes

The amoveo light node in javascript [here](https://github.com/zack-bitcoin/light-node-amoveo) makes it easy for anyone to participate in Amoveo from the convenience of their browser.
The light node downloads block headers, verifies proof of work in them. It uses merkel proofs so you can have cryptographic evidence that the consensus state reported in the light node is correct.
The light node is the standard way to interact with the Amoveo blockchain. You use the light node to create contracts, and markets. To trade in markets. To create off-chain limit orders. To report on the outcome of contracts. 
Full nodes are only needed for mining, everything else can be done with light nodes.

## Stateless Full Nodes

Amoveo uses the stateless full node model. That means a full node doesn't have to store any consensus state to stay in sync and verify blocks. You only have to store headers. Every block has all the merkel proofs that you need to verify that block.
So, an Amoveo full node can process blocks in any order. In particular, it can process blocks in reverse order. Which means that a mining pool can launch a new Amoveo node and start mining immediately, without waiting to re-process the history of blocks.


## Example Use Cases

* [Maintaining the climate so our planet can support future generations of humans](use-cases-and-ideas/climate_maintenance.md) This is an example of futarchy, which means using financial derivative markets to help communities of people make better decisions.
* [Fund-raising for creation of public goods](use-cases-and-ideas/insured_crowdfund.md) This is how we will fund further development of Amoveo.
* [Prediction markets and futarchy](use-cases-and-ideas/prediction_market.md) This is how we will plan further development of Amoveo.
* [Insurance](use-cases-and-ideas/insurance.md)
* Gambling
* [Stablecoin, also called "synthetic assets"](use-cases-and-ideas/stablecoin.md) This way you can own US dollars on Amoveo.
* [Preventing nuclear disaster](use-cases-and-ideas/north_korea.md) 
* [Preventing sexual abuse in the workplace](use-cases-and-ideas/Harvey_Weinstein.md)
* [Options](use-cases-and-ideas/options.md)


## Oracle Game Theory
Users can bet at 50-50 odds on which of the 3 outcomes they think will win.
Whichever outcome gets the most bets, and maintains it's lead for a long enough amount of time, wins.
If you are uncomfortable with the outcome of an oracle, simply move to a fork of the blockchain that you think is honest.
By default, nodes will go with the fork that has the most difficulty, but it is easy to manually tell your node to follow a different fork.
The developers promise to maintain the honest fork.
Letting users bet helps the situation escalate to the point where it gets the miner's attention.
Any honest individual who notices an attack on the oracle can double their money by participating in defense.
The Nash equilibrium will be for honest individuals to participate in the defense. Once enough honest individuals participate in the defense, then the oracle will catch the attention of the miners.
Yes there is a cost for the miners to keep an eye on the oracle this way, but every time an attack happens, the miners can participate in the defense, and double all their money. This should more than make up for the cost of watching the oracle for attacks.
The Nash equilibrium will be for miners to put some effort into watching the oracle for potential cheaters.
Therefore, the Nash equilibrium will be an honest oracle.
[Read more about oracles here](design/oracle.md)


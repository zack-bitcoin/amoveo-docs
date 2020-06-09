## The nature of smart contracts

Blockchains need to scale much bigger for global adoption.

Mutable Contracts
============

Also known as "state channels".

Scalability plans today tend to involve [turing complete state channels](programmable_state_channels.md)

Putting the smart contracts into the channels gives many advantages
* speed - off-chain state can be updated as quickly as you can communicate with your channel partner. This is much faster than waiting for confirmations on-chain. If your partner is a server, you can use Amoveo smart contracts instantly.
* privacy - off-chain state can stay secret. As long as neither channel participant disappears or tries to cheat, they never have to publish the contract on-chain.
* scalability- parallel off-chain computation. The channel contracts are usually only processed by the 2 participants in the channel. Every pair of channel participants can be running different channel contracts simultaneously.

The majority of smart contracts will exist off-chain, inside of state channels, in the lightning network.

We used to think that sharding would solve scalability entirely, allow for scalable contracts on-chain. But, modern sharding techniques tend to be a compliment to state channels rather than a replacement. The shards can depend upon channels to achieve certain security requirements, like front-running prevention.

So, let's make the assumption that smart contracts will be in the channels, and let's use cryptoeconomics to try to predict what these contracts would look like. 
[Why we need markets.](why_markets.md)

Techniques like [hashlocking](https://en.bitcoin.it/wiki/Atomic_cross-chain_trading) are used to connect many channels together into markets.

Amoveo has passing tests for smart contracts that connect many channels together to make a big market. Amoveo has off-chain order books to enforce these markets in the channels.

Since you get a better price in a bigger market, we know that most contracts will be formatted in a simple way that will be useful to the maximum number of people, that way the markets can be as big as possible.
Traditional markets for financial contracts face these same problems. They have settled on a handful of popular contracts, like: contract for difference, options, forwards.

The limitation of mutable contracts is that they are limited to a finite list of participants, and everyone needs to sign off on every update.

A simple example of using a mutable contract would be for micropayments between the same pair of users.

Shareable Contracts
===============

the limitation of shareable contracts is that they can't be changed.

A shareable contract has an source currency, and it creates 2 or more new subcurrencies.
Any of these subcurrencies can be the source of another shareable contracts. You can make mutable contracts out of the subcurrencies.

If you give some source currency to the shareable contract

a shareable contract creates 2 or more subcurrencies. you can split the parent currency into the child types. If you send all the child types to the shareable contract, then it converts them back into the source currency.

So an example of a shareable contract would be a stablecoin contract. We could split VEO into 2 types: one kind that follows the price of USD, and one that has double VEO volatility.

And anyone who owns both USD-stablecoin as well as the double-VEO, they could use this same contract to convert them back into normal VEO.

[you can learn about how shareable contracts are implemented here](shareable_contracts_implementation.md)


conclusion
=========

If you have a mutable contract, and they aren't cooperating, you just put a hash of the last smart contract on-chain, and it becomes shareable, so you can sell you stake as subcurrency, or make channels out of it with other people.

If you and someone else want to do something faster or at higher bandwidth than the blockchain offers, you can make a mutable contract out of any subcurrency in the system.

So smart contracts can switch types over time, depending on the needs of the users.
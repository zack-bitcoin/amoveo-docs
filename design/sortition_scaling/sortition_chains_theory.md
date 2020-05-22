Sortition Chains Theory
===========

[sortition chains home](./sortition_chains.md)


[why smart contracts need to be formatted as derivatives](smart_contracts_as_derivatives.md)


Smart Contract Liquidity
==============

Let me make a more concrete example.
If we use VEO denominated channels to bet that the price of BTC will be above $8k.
I want to bet 2 veo vs 2 veo.

First lets imagine trying to do this with normal state channels.

If I want to be able to win 2 veo, then I need to have 2 veo locked into the other side of the channel with the hub, and 2 veo locked on my side.
Also, the hub will have another channel with someone on the other side of the trade, it locks up 2 veo on each side.
So in total, 8 veo of liquidity are locked for the duration of the trade.

Now imagine I am doing the same thing in a sortition chain.
I could make a channel with the hub, and the channel is denominated in derivative contracts. So if BTC is worth > $8k, the channel has veo, and if BTC is worth < $8k, the channel is empty.
The hub also makes a channel with the person I am trading with. That channel is set up so if BTC is worth >$8k, the channel is empty, but if BTC is worth <$8k, the channel has veo in it.

Each channel can have up to 4 veo at the end, but the total number of veo at the end is only 4.
So the total liquidity locked up in this case is only 4 veo.

Without sortition chains, we would need 8 veo to enforce this contract. With sortition chains we only need 4.


Why we need sharding
==============

In order to be scalable, the maximum resource cost per computer in the network needs to have some upper bound, even as the number of users increases without bound.

So, there needs to be a way for the computational and storage capacity of the network to increase as the number of computers in the network increases.

Splitting up a single large resource between multiple computers, this is called "sharding".

Short Fraud Proofs
==============

Fraud proofs are used to enforce security on the shards. It is how someone would provide evidence to the main chain to show that cheating had occured.

In order to be scalable, we need the maximum size of the fraud proofs to be bounded and the size of the bound needs to be known to the participants in the contract.

If you need to publish the entire history of the winning part of the value in the lottery, this is not scalable, because that value could have been spent many times, so the history could be very long.

Validators provide what?
=============

We want the fraud proof to be short. So the fraud proof can't involve proving a complete chain of ownership history.
So when the validators assign value to someone, they don't say anything about where the value has come from.
Which means that when the validators are assigning value to someone, there is no record of who owned it previously, so there is no signature from a previous owner giving permission.

It needs to be impossible for the validators to assign your value to someone else without your permission.

So it is necessary that any sortition ownership claim has a priority based on the block height in which the validators had added it to the sortition chain.
Earlier block heights have higher priority.

This way, if you are assigned the value first, the validators can't give it away to anyone else without your permission.

Waiver Design
========

In order to minimize the size of the fraud proofs, we should have an individual small proof for every case where someone had given up control of part of the sortition value. We call this a "waiver".

So, in order to own some value, you need to maintain waivers from every previous owner of that value.

Kinds of computation
==============

We are going to have 2 different kinds of environments where turing complete contracts can be run.
The combination of which should allow us to build convenient interfaces for derivatives.

1) sortition contracts. Besides dividing up the value in the sortition chain probabilistically, we can also divide it up based on the outcome of a smart contract. Only the merkle root of this contract is contained in the merkle proof showing that you own part of the value in the sortition chain. If you lie about the outcome of a smart contract, someone else can post that smart contract to show that you lied, and you lose money for this.

This kind of computation has the draw-back that it is slow to update your contract. You need to wait for a merkle root to get recorded on-chain, and for enough confirmations on top of it so you can be sure that the tx wont get orphaned.

sortition contracts have the advantage that the only people who need to record the contract is someone who owns value in it.
If we only had waivers to do smart contracts, and we tried to use waivers to split a single ownership contract between 2 people. They would both need to keep track of each other's payments in order to own their own side.
sortition contracts have the advantage that you only need to keep track of your own payments. 

Unlike state channels, you cannot provide script-sig style evidence when the sortition contract is run. So it isn't possible to atomically connect this kind of contract to others.

2) waivers. Ownership in a sortition chain is like standing in a line for each part of the value. A person can give up their spot in line without having to post anything on-chain. They simply send a message to whoever is second in line, so it can be instantaneous.
You can embed a smart contract in the waiver, so that you can give up your spot in line conditional on the outcome of a football game for example. 
The drawback of waivers is that in some cases, the amount of data you may need to keep track of to own value in the sortition chain can become very large. For example. if you use a waiver to sell a stablecoin contract and are left holding long-veo, and then other people keep trading those stablecoins between each other. In that situation, if you want to be able to spend your long-veo, then you would need to remember the entire history of their transfers.
I expect that waivers will mostly be used to atomically connect different contract changes together.

When a waiver contract is run, you can provide evidence. So it can be used for atomic swapping.


Ownership Claims
==============

Ownership claims are how we do layer 2 computation.

Ownership claims are defined by:
* the pubkey of who owns this claim.
* A priority nonce.
* the ID of the sortition chain it is related to.
* the portion of the probability space that it is claiming.
* any smart contracts that need to resolve as `true` in order for this claim to be valid.

The priority nonce and the sortition ID are independent from everything else, and easy to handle.
The smart contracts and the probability space, these aspects interact in complicated ways.

The probabilistic value space is like the space of rational numbers between 0 and 1. A person can own any contiguous region of the interval from 0 to 1, defined by the 2 rational numbers that are the bounds of that region.

the contract space is like the space created by a 2^256 binary number, where you can set some of the bits to 1 or 0, and let the rest of the bits be free.

If we have smart contracts in layer 2, then we need to divide up the 2D space made by combining the probabilistic value space with the contract space, and we need to be sure that none of the 2D claims are overlapping with any other 2D claim. So a merkle proof of an ownership claim needs to also prove that no one else is simultaniously claiming the same value.

Dividing the 2D space up by contract first is dangerous, because it can cause a data availability vulnerability.
If Alice owns veo in a sortition chain, and Bob creates a contract with Charlie, we want it to never be the case that Alice needs to know the content of Bob and Charlie's contract in order to claim her winnings. So this means that new contracts need to be as near to the leaves of the tree as possible, and far from the root.

So this means that during merkle proof verification, we need to keep track of the bounds of the 2D space being defined at every step of the proof.


lottery randomness is necessary for sharding
==============

properties we want for sharding

* cost of bandwidth to run a full node should at worst be as expensive as O(log(#users))
* the currency on different shards is fungible.
* the same consensus mechanism is securing all the shards at once.

The goal of this proof is to show that any blockchain with all 3 of these properties at once must be using some lottery randomness type accounts.

If we are using the same single consensus mechanism to secure all the shards, then that means there is a main chain that records the order of history of the heart of the consensus mechanism.

For the same consensus mechanism to secure all the shards, and have fungibility, that means it needs to be possible to move your money onto or through the main chain without anyone else's permission, just by giving txs to miners.

if the bandwidth is only O(log(#users)) or less, then that means the number of accounts recorded on the main chain needs to be less than O(log(#users)).

For it to be possible to move your value onto the main chain without anyone's permission, while it also being the case that only O(log(#users)) at most have their account recorded on the main chain, the only way to have both of these at once is if it is lottery-ticket type value.


Lottery randomness is necessary for sharding #2
===============

If the main chain ever needs to verify the validatity a shard-block's state transition, then an attacker could cause data from each shard to need to be validated at the same time, and over-load the system.
This means that such a sharding system would only be able to scale a constant order more than having a single blockchain.

With probabilitic-value contracts, you never need to prove the validity of a shard state transition to the main chain, so this means it is possible for us to scale with logarithmic efficiency.

Before buying part of a sortition chain, you need to download merkel proofs of the state of that part of the probability space at every block height back to the origin of the sortition chain, as well as all the txs where others had given up ownership of this part of the probability space.
Once you have all this data, then you have trust-free ownership of your part of the probability space.
You don't need to know anything about any other part of the probability space.
If other parts of the probability space were double-spent, it does not matter to you at all. You still own your part of the probability space.

Horizontal and Vertical payments
=================

Sortition chains offer 2 different ways to make payments: horizontal and vertical.
A horizontal payment is how you give someone control of part of an existing sortition chain.
A vertical payment is how you create a baby sortition chain inside of an existing sortition chain, and then you give someone control of a part of the new baby sortition chain.

The off-chain cost of either kind of payment is that the person receiving the payment needs to download merkel proofs of the history of this part of the probability space.

The on-chain cost of horizontal transfers is zero.

The on-chain cost of vertical transfers is (the probability that you win)*(length of a signed chalang contract).

When you make a baby sortition chain, you get to choose a new list of operators for that new sortition chain.


multiple random samples
============

Maybe a sortition chain would be better if we did multiple random samples instead of just 1.

So when a sortition chain closes, it could randomly pay to up to 100 accounts, each receiving 1% of the veo from that chain.

The trade-off is that the on-chain cost per sortition chain increases 100x, but the risk of holding lottery tickets reduces 10x.

We can already know that this strategy is no good, because costs are increasing by the square of the benefits.

Therefore it is always better to have 2 small sortition chains that each pay out once, instead of 1 big one that pays out twice.


Making the value less probabilistic
===============
There are ways to compromise to make the value less probabilistic.
Like if I had 10 sortition chains going at once, and everyone who make a contract in one, I did the identical contract in all 10 with them.

So now there are 10 winners instead of 1 winner.
Which significantly reduces the risk.

Each sub-sortition chain of the recursive tree can still have only 1 winner.

Liquidity in Sortition Chains
=========

A major limitation of channels is that they are terrible for lottery.
You can only win as much money as is in the channel.
Sortition chains don't have this problem.
If you lock $1000 in stake, you could make 1000 sortition contracts, each with a 0.1% chance of winning $1000.

Similarly, if you are running a market inside a sortition chain, you could sell many mutually exclusive sortition contracts using the same staked funds.

If you want to run a market like amoveobook to match trades, you need to have twice as much money locked in channels vs the amount actually at stake in the bet. Half the money is being canceled out by arbitrage.

These lockup costs mean that only very rich people can run a hub (since 1/2 the money in a market at any time is money owned by the hub).

If we go with sortition chains instead, then the market operator only needs to control something like 2% - 10% of the money in his markets. So, it costs a lot less to launch new markets for people to trade.

Liquidity in Sortition Chain Channels
============

Lets say I want to make a market to bet on a sporting event.
To start, I could make a sortition contract to split up some of my money into 2 types. the A type can only win if Alice wins the game. The B type can only win if Alice does not win the game against her competitor Bob.

Next I want to sell these 2 piles of value in single price batches.
If Charlie wants to bet on Alice, I can make a channel with Charlie. Charlie puts veo from inside the sortition chain into the channel, and I put in some A type value, that can only have value if Alice wins.

So now, we have a channel that contains both veo and A type value, so we can make contracts to exchange these 2 kinds of value.
We could use atomic swaps, or single price batches.

The trick is to use the same Channel ID in both ownership objects. That way a single channel smart contract is valid for either of them.

Instant Payment Scalability
============

Lightning network is the idea to use lots of channels and use hashtimelocking to connect payments in different channels together. That way you can make an instant payment to anyone, as long as there is some path of channels between you two.

The lightning network of channels does not work as a scalable system of instant payments.
As the number of participants who want to be able to instantly pay each other increases, if we keep the payments volume per customer constant, then the liquidity cost to maintain the channel network increases.

Amoveo uses sortition ownership cycles to solve this problem. An ownership cycle is when the validators assign some value to a sequence of different pubkeys.
For example, it could be pubkeys P1, P2, P3.
They are assigned priorities in an infinite cycle: P1, P2, P3, P1, P2, P3, P1, P2 ...

This way they can send the money back and forth between each other infinite times, just by signing waivers.
If P1 owns the value, and he wants to send it to P3, then P1 and P2 need to sign waivers so that P3 ends up at the top of the priority queue.

Since waivers can have smart contracts in them, these payments can be atomically linked to other smart contracts, so we can send a lightning payment through one of these cycle-hubs.

A cycle hub is like a channel, but it allows for more than 2 participants.

Similar to a channel, if one of the other participants goes off-line or stops participating, then the money gets frozen.
Similar to the security model with the sortition validators, you can't spend it until the final-spend-tx period, when this sortition chain is ending.


The Leverage of Sortition Chains
============

If a sortition chain operator keeps selling sortition contracts, eventually they will make back almost all the money that they had paid to create the soritition chain, which means they have enough money to make another sortition chain.
It is like he is getting a leveraged position.
The total value of all the sortition chains he is operating becomes much larger than the total value of the account he had started with.

So a person with only 1 veo can generate and profit from 20+ veo worth of sortition chains all containing smart contracts.

The capital cost of being a sortition chain operator is very low. So it is cheap to launch a new sortition chain and offer custom markets in whatever you care about.

"contracts == chains" Resource Consumption Advantages
===================

By layering sortition chains inside of each other, any individual sortition chain wont have to keep track of too much data. So the memory requirement of running a sortition chain can be bounded.

By layering sortition chains, each individual sortition chain can store less value.
So if you are running many different sortition chains, you can use a different private key for each one, so if one of your servers is compromised, you don't lose everything.

Parallelizing tx processing across multiple computers running different sortition chain databases increases throughput of txs.



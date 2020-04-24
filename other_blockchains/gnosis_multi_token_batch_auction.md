Gnosis Ring Batch Markets
==============

[informal blog post explaining the basics of ring batches](https://blog.gnosis.pm/announcing-the-gnosis-protocol-89b3d7794da7)

[Here is a formal paper explaining the ring batch tool](https://github.com/gnosis/dex-research/blob/master/dFusion/dfusion.v1.pdf)

Ring batches are an on-chain, subcurrency-based version of [Amoveo's limit orders in state channels](../design/limit_order_in_channel.md)

The problem
============

We want to be able to trade blockchain enforced assets for other blockchain enforced assets. We want the trading to happen at a good price.

Good approximations of NP problems on the blockchain
============

The big technological innovation of Gnosis Ring Batch Markets is that they have found a way to find good approximations of NP hard problems, and put the solution on the blockchain.

This is a significant innovation both because it is computationally intractable to calculate even a good approximation to these problems on-chain, and because approximate solutions are not deterministic.

These kinds of problems, coming up with a perfect solution is often impossible, but the accuracy of an approximate solution can be quickly verified. So the strategy used by Gnosis is to allow many people to provide approximate solutions, and the most optimal of these submissions is used.

Thanks to Gnosis, it is now possible to solve the traveling salesman problem on the blockchain. Or the knapsack problem.


Gnosis' new tool is in the same family of mechanisms as TrueBit fraud proof mechanism. With TrueBit, you can verify any computation with N steps on-chain, at a on-chain cost of only O(log2(N)) in time and space.


Distributed Encryption Key Generation PoS
=============

This component is the weakness in Gnosis new market engine.

the DKG tool works like this:
N different people generate entangled messages, one public and one private.
They share all the public messages, and use them to generate a public key.
Now encrypted messages can be made using this public key.
Eventually, some subset of the N different people share the private messages together, and use them to calculate a private key which can be used to decrypt all the messages.

Gnosis intends to use this DKG tool to prevent front-running in the markets.
If everyone's bets are secret, then people who want to front-run those bets don't have the information that they need to be able to front-run.
The people can have encrypted bets in the market, and the bets don't get decrypted until the betting round ends.

All of the participants who created entangled messages, they all provide security deposits. So if anyone can show that an entangled private message was revealed early, the person who improperly revealed it can be punished.

DKG, as it is being used in gnosis, can be thought of as a kind of PoS consensus protocol. the N participants who provide bonds are the validators of the consensus protocol.

Normal PoS consensus protocols are based on 2/3rds participation, so if 1/3rd of validators cooperate the attack, they can halt the protocol. If 2/3rds of the validators cooperate, then they can do soft fork updates to make arbitrary changes to the protocol.
[You can read more about why PoS protocols don't work here](https://github.com/zack-bitcoin/amoveo-docs/blob/master//other_blockchains/proof_of_stake.md)

The consensus state being agreed upon by the participants in Gnosis DKG PoS, is only one bit per auction batch. They either agree to reveal the private key generated from their messages, or they decide to not reveal.

Gnosis DKG has some threshold M of participants who need to reveal their private messages, and they have a total number of participants N. So it is analogous to a PoS protocol based on M/N participation, and has 2 possible failure modes analogous to the 2 failure modes of PoS.

DKG broken by omision
=========

This attack is possible if N-M+1 of the validators cooperate to attack.

The participants in the DKG PoS can make the decision to not reveal their private messages, so the orders in this batch all stay private, and this batch never gets executed.

This allows the DKG PoS validators to front-run the market.
The attackers can look at the trades in each batch, and then use that knowledge to decide which batches should be canceled.
They can put risky trades into each batch, and only decrypt the batches where the trades work out to their advantage.

DKG broken by early reveal
=========

if M of the validators cooperate, they can do this attack.

If the validators share their secret messages ahead of time, they can use the private key to decrypt all the orders. So they can work with the miners to have certain orders selectively censored.

This makes front-running trivial:

First have a batch where they censor all sell orders. Only the attackers can sell. Since there are so few sellers, the attackers get good deals on all the trades.

Then have a batch where they censor all buy orders. Only the attackers can buy. Since there are so few buyers, the attackers get good deals on all the trades.

Making the DKG PoS validators use a security deposit bond does not prevent this kind of attack.
The attackers can use smart contracts together and lock up more money into more bonds to enforce that they cooperate to execute the attack.


Conclusions
============

It still seems like it is impossible to have secure on-chain markets.
Someone will probably soon prove that this goal is impossible.

Atomically linking updates of different contracts together is a solved problem.
Channels have had atomic swapping for almost a decade now.
If we move the computation off-chain, into the channel network, then single price batches are easily enforced. Secure markets are trivial.

I can not understand why people put so much effort into trying to put markets on-chain.
On chain smart contracts are not scalable.
Even if on-chain markets were possible, they would still fail in the competition against markets in channels.


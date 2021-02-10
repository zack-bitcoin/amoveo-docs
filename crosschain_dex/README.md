Amoveo crosschain DEX
===============

The idea of a "crosschain DEX" is to allow users to swap currency from one blockchain for currency on another blockchain.

There are multiple designs for how the crosschain DEX can work, with their own trade-offs. The Amoveo DEX is one of these designs.

The purpose of the code in this folder is to explain the Amoveo DEX, and compare it's costs and benefits to other similar tools.

Basics of Amoveo DEX
============

The Amoveo DEX is enforced using Amoveo's [oracle, which you can read about here.](../design/oracle.md)

Using the oracle you can ask any question in a human language like English, making it very versatile.

Using Amoveo's oracle for DEX has advantages:

* It is very cheap, currently costing about 0.015 VEO to use.
* You only need to use it in the case where one of the participants refuses to cooperate, and the participant who refuses to cooperate pays the cost of making the oracle. So this makes the oracle effectively free.
* It is completely trustless. There is no one who can make the oracle lie.
* It does not require any special programming on any blockchain. No need to use the same crypto or support certain types of transactions.
* It does not require any special user interfaces for any blockchain.
* It is compatible with all blockchains.
* It has a security deposit to prevent the free option problem after a trade has been matched.
* Amoveo supports synthetic assets, to solve the free option problem before a trade has been matched.
* It is non-interactive. You can post an offer to an orderbook, and go offline.
* It is commitable. You can commit to making a trade, and if someone accepts it, you are locked in.

Amoveo's oracle has disadvantages:

* It is slow. It takes at least a week to have a result. It can take longer, but in that case, the attacker who caused the oracle to take longer, they are paying any costs incurred by this delay.
* It only works if there is a way for the Amoveo oracle reporters to look up the account balance or transaction on the other blockchain to verify that the payment on that blockchain had occured.

Alternative DEXs
=========

[Atomic swaps are the original DEX tech](atomic_swap.md)

[chainflip](chainflip.md)
Amoveo crosschain DEX
===============

The idea of a "crosschain DEX" is to allow users to swap currency from one blockchain for currency on another blockchain.

There are multiple designs for how the crosschain DEX can work, with their own trade-offs. The Amoveo DEX is one of these designs.

The purpose of the code in this folder is to explain the Amoveo DEX, and compare it's costs and benefits to other similar tools.

[This page has the current interface for the Amoveo DEX, in the "crosschain DEX" tab](http://159.89.87.58:8080/wallet.html)

Basics of Amoveo DEX
============

The Amoveo DEX is enforced using Amoveo's [oracle, which you can read about here.](../design/oracle.md)

Using the oracle you can ask any question in a human language like English, making it very versatile.

Basically, one person bets some veo that bitcoin will not be sent to their address. anyone can match that bet, send the bitcoin, and then they win the veo from the bet. effectively, they have traded bitcoin for VEO.

Using Amoveo's oracle for DEX has advantages:

* It is very cheap, currently costing about 0.015 VEO to use.
* You only need to use it in the case where one of the participants refuses to cooperate, and the participant who refuses to cooperate pays the cost of making the oracle. 
* It is completely trustless. There is no one who can make the oracle lie.
* It does not require any special programming on any blockchain. No need to use the same crypto or support certain types of transactions.
* It does not require any special user interfaces for any blockchain.
* It is compatible with all blockchains.
* It has a security deposit to prevent the free option problem after a trade has been matched.
* Amoveo supports synthetic assets, to solve the free option problem before a trade has been matched.
* It is asynchronous. You can post an offer to an orderbook, and go offline. The entire process of your trade can happen while you are offline.
* It is commitable. You can commit to making a trade, and if someone accepts it, you are locked in and can't back out part way through.

Amoveo's oracle has disadvantages:

* It is slow. It takes at least a week to have a result. It can take longer, but in that case, the attacker who caused the oracle to take longer, they are paying any costs incurred by this delay. In practice, if you want to get your money out faster, you can sell your shares in the contract for 99% of their value to someone who is willing to wait for the oracle to finalize.
* It only works if there is a way for the Amoveo oracle reporters to look up the account balance or transaction on the other blockchain to verify that the payment on that blockchain had occured.

Examples of using the DEX
=========

[Here is an example where someone sold 10 veo for 0.015 BTC. It links to the smart contract and all the txs involved](../blog_posts/DEX_7_feb_2021.md)

[Here is the report from the very first time the DEX was used. To trade 0.182 VEO for 160 DOGE. This example was from before we had a specialized DEX UI, so it goes in depth about what is happening behind the scenes during a crosschain swap.](../blog_posts/DEX_feb_2021.md)

Alternative crosschain DEXs
=========

[atomic swaps are the original DEX tech](atomic_swap.md)

[chainflip](chainflip.md)

[thorchain](thorchain.md)

[Bisq](bisq.md)

[Binance crosschain DEX](binance.md)

[serum](serum.md)

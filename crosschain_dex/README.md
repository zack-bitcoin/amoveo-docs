Amoveo crosschain DEX
===============

The idea of a "crosschain DEX" is to allow users to swap currency from one blockchain for currency on another blockchain.

There are multiple designs for how the crosschain DEX can work, with their own trade-offs. The Amoveo DEX is one of these designs.

The purpose of the code in this folder is to explain the Amoveo DEX, and compare it's costs and benefits to other similar tools.

[This page has the current interface for the Amoveo DEX, in the "crosschain DEX" tab](http://64.227.21.70:8080/wallet.html)

Basics of Amoveo DEX
============

The Amoveo DEX is enforced using Amoveo's [oracle, which you can read about here.](../design/oracle.md)

Using the oracle you can ask any question in a human language like English, making it very versatile.

Basically, one person bets some veo that bitcoin will not be sent to their address. anyone can match that bet, send the bitcoin, and then they win the veo from the bet. effectively, they have traded bitcoin for VEO.

Using Amoveo's oracle for DEX has advantages:

* Oracle enforcement is very cheap, currently costing about 0.015 VEO to use.
* You only need to use oracle enforcement in the case where one of the participants refuses to cooperate, and the participant who refuses to cooperate pays the cost of making the oracle. 
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

Free Options after matching.
=========

The free option problem can happen when people are exchanging assets that change in price relative to each other. If one of the participants in the exchange has a period of time during which they have the choice to either accept or cancel the exchange, they can wait around an see how the price moves before making their decision.

For example, if Bob has the free option when he is selling VEO for BTC. Bob could wait to see the price of VEO/BTC. If VEO is worth more, he would cancel the trade to not lose his VEO. If VEO is worth less, he would complete the trade to get the more valuable BTC. This is a way of stealing from the counterparty of the trade.

Amoveo's DEX is secure against free options after an order is matched, because the amount of VEO enforcing the delivery is worth more than how much BTC is being sent. If Bob decides not to send the BTC, he loses an amount of VEO worth more than that much BTC. So even if the price of BTC increased, it is still not in Bob's interest to cancel the swap after he has agreed to participate in the swap.

Free Options before matching.
==========

Imagine using the Amoveo DEX to swap VEO for ZEC.

You could make an Amoveo contract to be a synthetic version of ZEC, and trade those synthetic ZEC for ZEC on Zcash.
Amoveo is a platform for financial derivatives, a synthetic version of ZEC is a financial derivative designed to maintain the same value as ZEC. Basically, a contract for difference.
Since the price of ZEC and synthetic ZEC don't move relative to each other, there is no free option.

Another way to deal with free options is that you could make a tx to cancel your order in reaction to the ZEC/VEO price moved too much. This technique can be more costly, because you need to pay a tx fee to cancel your order.

Another way to deal with free options is to make your orders have very short expirations, and you keep re-publishing them at the new price as the ZEC/VEO price moves. This strategy is free of cost, because making an order that doesn't get matched is all off-chain, you don't pay anything. But you need to stay online to keep publishing new limit orders.

Alternative crosschain DEXs
=========

[atomic swaps are the original DEX tech](atomic_swap.md)

[chainflip](chainflip.md)

[thorchain](thorchain.md)

[Bisq](bisq.md)

[Binance crosschain DEX](binance.md)

[serum](serum.md)

[incognito](incognito.md)

[ren](ren.md)

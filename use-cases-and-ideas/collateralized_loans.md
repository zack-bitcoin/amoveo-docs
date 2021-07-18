Collateralized Loans
===============

Why do we want this?
==============

A collateralized loan is a tool used for:
* it can be a more capital efficient way to gain exposure to a cryptocurrency.
* gaining access to a cryptocurrency for a chosen period of time, without needing to use illiquid markets to convert back and forth.
* gaining the ability to use a cryptocurrency without needing to pay capital gains tax.

Capital Efficiency
===============
If you make a normal bet on the price of BTC, you get a lot of flexibility. Your bet can be customized to have any amount of leverage. But the problem is that both sides of this bet, they are not BTC. You can hold an asset which stays the same value as BTC, but it is not actual BTC and can't be used as BTC.

With a normal financial derivative, both sides of the contract are specialized assets that aren't fungible with any popular cryptocurrency, and so don't have any liquid market.

With a collateralized loan, one side of the contract is BTC, which can be traded in efficient markets.

So this means there are cases where collateralized loans can be a more efficient tool than standard financial derivatives.

Liquid way to access other cryptocurrencies
=================

Imagine you are holding a lot of VEO, but there is some new tool you want to test out in Ethereum.

The market for VEO is not very liquid. It looks like selling VEO for Eth and buying back in later could cost more than 15% of the money you want to use.

Instead of selling your VEO, you could use your VEO to collateralize a loan that gives you access to the Eth you want to test out. The loan is over-collateralized, so you need to lock up ~150 Eth worth of VEO to have ability to use 100 Eth for your test.
But this comes with the benefit that after your test is done, you can change that Eth back into VEO, and the total cost for the round trip is less than 1% of the money you sent.

There are lots of people who want to farm their Eth with these collateralized loans, and are happy to take the 1% fee.

How can it work in Amoveo?
==============

person A bets 1000 veo (~$40,000), person B bets 0 VEO

the bet is "(1000 veo does not drop below $11,000 at any point by time Y AND person B sends person A $10000 in usdt to ethereum address X) OR (person A sends person B $10000 in usdt to ethereum address Z)"

person A bets on true person B bets on false

How Amoveo improves on existing solutions
==============

Amoveo collaterlized loans don't need to be for currency that is on the same blockchain.
You can use VEO as collateral to have access to BTC on bitcoin or Eth on Ethereum.

If you wanted to use Eth to get access to BTC on bitcoin, you would need to exchange some wrapped BTC for BTC at some step of the process and pay a fee for this exchange. In Amoveo we don't have this limitation. You can borrow BTC that are already on Bitcoin without needing to use any exchange. Similarly, when the loan ends, you are paying BTC on the Bitcoin blockchain to end the loan and unlock your VEO.


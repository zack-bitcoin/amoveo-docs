Composing Conditional Contracts Together via collateralization for Perpetual Stablecoins
==================

abstract: composing conditional contracts with conditional contracts, via collateralization. Swapping out the collateral of a contract from one currency into another. This can be used to create a perpetual stablecoin that can quickly rebalance it's collateral to keep the amount of leverage optimized. So the twin goals of security and cost are kept in the proper balance.

What is a conditional contract:
Defined by it's source currency, how many subcurrencies it has, and a turing complete contract that determines how to divide the value between the subcurrencies.

How to use it:
If you give it the source currency, it gives you a complete set of it's subcurrencies.
If you give it a complete set of it's subcurrencies, it gives you the source currency.
You can provide evidence to help the smart contract resolve.
Once the smart contract has resolved, then you can exchange any of the subcurrencies to receive the portion of source currency that has been assigned to that subcurrency.



A finite stablecoin is a stablecoin that has an expiration date. After the expiration, the stablecoin contract automatically converts back to the source currency based on whatever the final price was.

A perpetual stablecoin doesn't expire. It continues holding it's value against the stable asset for as long as it can.

For a perpetual stablecoin to be efficient, we want to maintain the proper amount of collateralization. If the collateralization is too low, then there is risk that the stablecoin will break due to a price fluctuation. If the collateralization is too high, then this makes the stablecoin more expensive, because you need to pay someone to lock up that extra unnecessary capital.

The way we can change the collateralization of a perpetual stablecoin, without resolving that perpetual stablecoin, is by swapping out the currency that is used as collateral for the perpetual stablecoin. So it is a 2 layer system.

The first layer is built of finite stablecoins with various collateralizations and expiration dates.
The perpetual stablecoin has one of the finite stablecoins as it's collateral.
If that finite stablecoin is approaching it's expiration, or one of the collateralizations bounds, then the perpetual stablecoin can hold an auction.
It auctions off all the collateral in the old finite stablecoin, and receives new collateral in the new finite stablecoin.

Collateral swapping mechanism cost.
==============

Because of flash minting, the cost of participating in this auction is very low. You don't need to have any currency besides veo. If no one bids a higher price, it is possible to win the auction with an account that has zero veo, and profit in veo terms, without being left holding any currency besides veo.

If there are finite stablecoins collateralizing the perpetual stablecoin, then someone must own the finite long-veo. Lets assume that they have set up sell orders.

Since everyone knows it is almost time for the perpetual stablecoin to get it's collateral swapped out, and they are able to calculate what the next finite stablecoin contract will be, that means they can anticipate the demand for this next finite stablecoin. So people will put out buy orders for the finite long veo.

Someone needs to build the tx that does the collateral swap. Let's imagine this person's balances in the relevant currencies, and how they change during this tx.
Thinking of their balances in vector format, `[veo, finite_stablecoin1, finite_long_veo1, finite_stablecoin2, finite_long_veo2]`

* matching swap offers to purchase the current long-veo for veo. [-1, 0, 2, 0, 0]
* matching swap offers to sell the next long-veo for veo. [1, 0, 0, 0, -2]
* swapping old stablecoin for new stablecoin in the contract. [0, 2, 0, -2, 0]
* selling the old subcurrency set for veo. [2, -2, -2, 0, 0]
* buying the new subcurrency set with veo. [-2, 0, 0, 2, 2]

So their balances change according to this transformation matrix:
```
[[-1, 0, 2, 0, 0],
 [ 1, 0, 0, 0,-2],
 [ 0, 2, 0,-2, 0],
 [ 2,-2,-2, 0, 0],
 [-2, 0, 0, 2, 2]]
 ```
 If you apply this matrix M to a vector of all 1s, [1, 1, 1, 1, 1], you get a vector of all zeros [0,0,0,0,0].

That means that this combination of 5 txs, it can be done by flash minting, and as long as there is enough arbitrage profit to cover the tx fee, then you can do this combination of 5 txs, even from an account with practically zero veo balance.

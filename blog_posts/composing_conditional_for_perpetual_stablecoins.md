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



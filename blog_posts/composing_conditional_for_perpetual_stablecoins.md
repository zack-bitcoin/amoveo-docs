Composing Conditional Contracts Together via Resolution for Perpetual Stablecoins
==================

abstract: composing conditional contracts with conditional contracts, via resolution, and lazily creating the new iteration of the contract at the last minute. This can be used to create a perpetual stablecoin that can quickly rebalance it's collateral to keep the amount of leverage optimized. So the twin goals of security and cost are kept in the proper balance.

A finite stablecoin is a stablecoin that has an expiration date. After the expiration, the stablecoin contract automatically converts back to the source currency based on whatever the final price was.

A perpetual stablecoin doesn't expire. It continues holding it's value against the stable asset for as long as it can.

For a perpetual stablecoin to be efficient, we want to maintain the proper amount of collateralization. If the collateralization is too low, then there is risk that the stablecoin will break due to a price fluctuation. If the collateralization is too high, then this makes the stablecoin more expensive, because you need to pay someone to lock up that extra unnecessary capital.

The way we can change the collateralization of a perpetual stablecoin, without resolving that perpetual stablecoin, is by swapping out the currency that is used as collateral for the perpetual stablecoin. So it is a 2 layer system.

The first layer is built of finite stablecoins with various collateralizations and expiration dates.
The perpetual stablecoin has one of the finite stablecoins as it's collateral.
If that finite stablecoin is approaching it's expiration, or one of the collateralizations bounds, then the perpetual stablecoin can hold an auction.
It auctions off all the collateral in the old finite stablecoin, and receives new collateral in the new finite stablecoin.



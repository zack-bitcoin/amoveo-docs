Collateral
========

every contract is enforced by locking up some veo in it.

Lets say we made a contract that is worth $50 of USD stablecoins.
in order to enforce that someone owns the $50, the contract would need to have at least $50 worth of veo locked inside of it.
If the price of veo/usd falls, then eventually the value of the veo locked in the contract could become worth less than $50, and the stablecoin becomes worth less than USD.

In order to protect the value of the stablecoin, we need to lock more than $50 of veo into the contract, just in case the price of veo falls before the contract finishes.

If we lock $75 of veo in the contract, then the contract is 150% collateralized. because 75/50 = 1.5

if we lock $110 of veo in the contract, then it is 220% collateralized, because 110/50 = 2.2

The collateralization of the stablecoin is connected to the leverage of the inverse-stablecoin.
higher collateralization means lower leverage.
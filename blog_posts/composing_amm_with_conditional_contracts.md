Composing conditional contracts with constant product market makers to solve arbitrage issues between them
===============

Abstract:
By atomically (creating or destroying a full set of subcurrencies from a conditional contract) and (trading in one or more markets), we can achieve about double the liquidity in comparison to using the markets without creating/destroying subcurrency from the conditional contract. We further generalize this technique by atomically participating in multiple conditional contracts and markets simultaniously, for the goal of arbitrage-free swapping and maximum liquidity for trading.


## what is a conditional contract
Defined by it's source currency, how many subcurrencies it has, and a turing complete contract that determines how to divide the value between the subcurrencies.

## How to use a conditional contract
If you give it the source currency, it gives you a complete set of it's subcurrencies.
If you give it a complete set of it's subcurrencies, it gives you the source currency.
You can provide evidence to help the smart contract resolve.
Once the smart contract has resolved, then you can exchange any of the subcurrencies to receive the portion of source currency that has been assigned to that subcurrency.

Given a conditional contract with 2 subcurrencies, there are 3 currencies we care about. The source currency, and the 2 different subcurrencies.
There are 3 ways to make pairs of currencies out of 3 currencies, so there are 3 ways to make constant product markets. market1 is between the source currency and subcurrency 1. market2 is between the source currency and subcurrency 2. market3 is between the two subcurrencies.

Given a conditional contract, along with one of the 3 possible markets, it is possible to exchange any one of the 3 currencies for any of the other two.
In matrix form, where the columns represent source, sub1, sub, and the rows represent using the contract to create/destroy subcurrency, using market1, using market2, using market 3

```
[[-1 1 1]
 [1 -2 0]
 [1 0 -2]
 [0 1 -1]]
```
this matrix is showing the simple case where the prices of the subcurrencies are equal.

There are 2 unknowns in each of the equations, so any pair of these equations is a basis vector of the space, sufficient to create a transformation between any of the pairs of currencies.

So for every pair of these 4 equations, we have one way to convert our spending currency into the currency we want to buy.
6 possible pairs of equations gives 6 ways to convert between any pair of the 3 currencies.
These 6 conversion paths convert our money without leaving us with any leftovers in any other types of money.

If I spend all my money on a single conversion path, then the price along that path will move a lot, and I will end up making it expensive for myself.

In order to minimize the cost of my swap, I may want to use a mixture of the 6 available paths.

In order to calculate this ideal mixture, the strategy I have found that works is a gradient descent. I look at the price on each path. If a path is more expensive than average, then I spend less on that path. If a path is less expensive than average, then I spend more on that path. Eventually every path has the same price, which means there is no arbitrage opportunity left, and this is the ideal trade.

## flash minting

Flash minting makes it much easier to avoid losses to front-running and arbitrage.

An example of where flash minting is especially helpful. Lets say there is a contract with 2 share types. You own share type 1, but you want to own share type 2. For this example, you dont have any other money in the system, besides your type 1 shares.
There is a market with liquidity between share type 1 and the source currency of the contract.

In this scenario the ideal solution is to use the market to sell more than all of your type 1 shares for source currency. Then use the contract to convert that source currency into a mix of type 1 and type 2, this pays back your debt in type 1, and leaves you holding only type 2 shares.

If we dont have flash minting, then this process would be divided up into many smaller txs, each tx costing a miner fee, and you will lose money to front running the entire way.



Corollary:

Since any of the 3 markets can be used to provide liquidity, this means that a person holding the source currency of that contract is able to convert the source currency entirely into liquidity shares of the 3 markets, without being left holding any of the subcurrencies, and without changing the price in any of the markets.


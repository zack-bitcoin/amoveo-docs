Composing conditional contracts with constant product market makers to solve arbitrage issues between them
===============

A conditional contract.
what it is:
Defined by it's source currency, how many subcurrencies it has, and a turing complete contract that determines how to divide the value between the subcurrencies.

How to use it:
If you give it the source currency, it gives you a complete set of it's subcurrencies.
If you give it a complete set of it's subcurrencies, it gives you the source currency.
You can provide evidence to help the smart contract resolve.
Once the smart contract has resolved, then you can exchange any of the subcurrencies to receive the portion of source currency that has been assigned to that subcurrency.

Given a conditional contract with 2 subcurrencies, there are 3 subcurrencies we care about. The source currency, and the 2 different subcurrencies.
There are 3 ways to make pairs of currencies out of 3 currencies, so there are 3 ways to make constant product markets. market1 is between the source currency and subcurrency 1. market2 is between the source currency and subcurrency 2. market3 is between the two subcurrencies.

Given a conditional contract, along with one of the 3 possible markets, it is possible to exchange any one of the 3 currencies for any of the other two.
In matrix form, where the columns represent source, sub1, sub, and the rows represent using the contract to create/destroy subcurrency, using market1, using market2, using market 3

```
[[-1 1 1]
 [1 -2 0]
 [1 0 -2]
 [0 1 -1]]
```
this matrix is showing the simple case where the price of each subcurrency is equal.

There are 2 unknowns in each of the equations, so any pair of these equations is sufficient to create a transformation between any of the pairs of currencies.

So every pair of equations, we have one way to convert our spending currency into the currency we want to buy.

If I spend all my money on a single conversion path, then the price along that path will move a lot, and I will end up making it expensive for myself.

In order to minimize the cost of my swap, I may want to use a mixture of many of the available paths.

In order to calculate this ideal mixture, the strategy I have found that works is a simple gradient descent. I look at the price on each path. If a path is more expensive than average, then I spend less on that path. If a path is less expensive than average, then I spend more on that path. Eventually every path has the same price, which means there is no arbitrage opportunity left, and this is the ideal trade.



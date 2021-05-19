Futarchy
=============

Futarchy is a mechanism for groups of people to make a decision together. It is an alternative to voting or representative governance.

With Futarchy, the decision is made in the best interest of the group making that decision. It is not possible for anyone to manipulate the outcome of futarchy for their own benefit.

The futarchy interface is on [this page](http://159.89.87.58:8080/wallet.html). The button that says "create Futarchy".

The Mechanism
===============

A futarchy mechanism is made up of 3 smart contracts. One binary contract, and 2 scalar contracts.

For example, if we are deciding between plan A or plan B.

First we need the binary contract, collateralized in VEO. It is used for betting on whether we go with plan A or plan B. So this binary contract, it is creating 2 new currencies. Currency A is valuable only if we do plan A, and currency B is valuable only if we do plan B.

Next we make scalar contract A, collateralized in currency A. This scalar contract is betting on the price of USD, or some other stable asset, measured in terms of VEO. So it is a lot like a stablecoin contract.

Finally we need scalar contract B. It is identical with scalar contract A, except it is collateralized with currency B.

The market price of shares from scalar contract A, they tell us what the price of VEO will be, conditional on if the community goes with plan A.

Similarly, the market price of shares in scalar contract B, they tell us what the price of VEO will be, conditional on if we use plan B.

So by comparing the prices in these 2 markets, we can find out the impact of plan A vs plan B on the price of VEO.


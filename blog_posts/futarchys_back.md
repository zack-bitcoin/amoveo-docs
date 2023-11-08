Futarchy is Back
==========

What is Futarchy?
============

Futarchy is the idea that we could use prediction markets to allow people to prove the consequences of group decisions, and that this would allow the group to more effectively make decisions, based on maximizing the shared values of that group.

What is a prediction market?
===========

A prediction market is a betting market that was carefully crafted so that the price of that market reveals some useful information about the future. The prediction market rewards accurate predictions, and punishes poor predictions.

Futarchy history
========

Robin Hanson invented prediction markets, and futarchy. 

Vitalik explained it elegantly in this blog post from 2014: https://blog.ethereum.org/2014/08/21/introduction-futarchy

Attempts to put futarchy on the blockchain have failed
=======================

Fungible subcurrencies are easier to program in the blockchain setting than reversible swaps would be. There are some simplifying principles used in blockchain design, based on loose assumptions about what is and is not enforceable.
The fact that people can sell their private keys makes it seem like it would be impossible to enforce a reversible swap. In order to be reversible, there needs to be a period of time where you cannot sell your stake in the swap that you had made. Because if you did sell 
That hackers would find a way to sell their coins, even when it is in a supposedly untradeable state.

Paul Sztorc fully embraced the fungible subcurrency model, you can see Paul Sztorc's recommended design here https://bitcoinhivemind.com/papers/3_PM_Applications.pdf
A 2x2 prediction market, with 4 fungible assets. I will call them "combinatorial markets".

This same design mistake was carried over into Augur and Amoveo.

In the [futarchys failure](futarchys_failure.md) document, I explain why combinatorial markets does not work as a prediction markets, using cryptoeconomic analysis.

What do I mean by reversible swap prediction markets
=================

There are 2 binary markets. Possibly with LMSR or constant product, or possibly they are just limit orders being paired up.

Both markets are betting on whether we achieve the goal of futarchy or not. (A higher token price, or higher hashrate for example)

One of the two markets will get reversed.
If a market gets reversed, then everyone who had bet in that market, their bets are undone. The participants get their money back, no matter which outcome they had bet in.

The other market is no longer reversible. Now that they can't be reversed, the shares have become fungible. It is now possible to re-sell your shares in this market to other users, or use them as collateral in other contracts.

If the futarchy mechanism makes the true decision, then the second market is reversed.
If the futarchy mechanism makes the false decision, then the first market is reversed.


Cryptoeconomic analysis of reversible swap prediction markets
======================

There are 2 ways the prediction market could fail.
Either (1) the defenders stop participating because it is not profitable for them to participate, or (2) the defenders stop participating because they no longer have funds available with which to participate.

(1) no longer profitable
=========

S = Signal. How much our shared choice determines whether we achieve our goal. If raising the block limit would increase the bitcoin price by 5%, then S=0.05. The signal is important, because of the kelly criterion. Just because a bet has expected profit doesn't mean you are incentivized to invest 100% of your funds in it.

I = interest rate in cryptocurrency for the duration of the market. If you can earn 20% a year by lending your VEO, and the market will last for 3 months, then the for 3 months is around 4.7%, so I=0.047

(gain from defending) < (loss from defending)
`S < I/2`

`I/2` is because one of the two markets gets unlocked early, so your money isn't trapped if it was in that market.

S is because the attacker is only expected to lose S portion of his funds, so the defender can only expect to earn that much.

(2) no money left to defend
==========

L = Liquidity. The amount of money defenders have ready to participate in prediction markets. In the context of blockchains, it is possible that L > S * (market cap), because the defenders could potentially own other investments besides their currency in this blockchain.

X = amount of money an attacker is willing to lose to manipulate the market.

(money available for defending) < (money available to attack)
`L * S < X`
`S < (X / L)`

The S is because we are expecting the defenders to use a profit maximizing strategy. They want to hedge against the risk that the result of the market is determined by something other than the decision futarchy is making. Kelly's criterion says that investing only S portion of their funds is the most profitable strategy for defenders https://en.wikipedia.org/wiki/Kelly_criterion


Can reversible swap prediction markets be degraded into combinatorial markets using some kind of nothing-at-stake attack?
=================

Since combinatorial markets do not work for futarchy, it is important that we can prove that our reversible swap market cannot be converted into a combinatorial market no matter what strategies the users participate with.

What aspect of the combinatorial market is bad?
if the defender needs to buy high-valued shares, and the attacker only needs to buy lower-valued shares, then it can cost the defender 10x or 100x more capital to move the price the same distance that the attacker does.

in the combinatorial market context, here is the price of a share betting that we made the true decision, and it achieves our goal.
```
veo * (odds that we made the true decision) /
(odds that it achieves our goal conditional on making the true decision)
```
If the odds of making the true decision are very low, then this share type is going to be much cheaper than other share types.

in the reversible swap market context, here is the price of a share betting that we made the true decision, and it achieves our goal.

```
veo *
((odds that we make the false decision)*(odds that we will make the false decision as recorded at the moment this trade executes) +
 ((odds that we make the true decision) /
  (odds that it achieves our goal conditional on making the true decision)))
```

Focusing on the case when the odds of a true decision are very low, because this is when the market is usually sensitive to price manipulation from someone buying shares of true.

If the odds of making the true decision are very low, then this becomes ```veo * (odds that we will make the false decision as recorded at the moment this trade executes)```
Which may be very low for some traders, but if you had purchased this when the odds of a true decision are very low, then it would be worth almost 1 veo. So You can't buy this to move the price in a liquidity efficient way.

Can the attacker use something like a nothing-at-stake attack to get his victims to hold something worth `veo * (odds that we make the false decision)`, and is this a cost effective way to attack futarchy?

No, because these kinds of attacks can only increase the amount of money you need locked in contracts, not reduce. They are used to move risk to someone else, not for recovering locked liquidity.

So you can't get anyone else to put up the liquidity for you. That means there is no liquidity efficient way to manipulate the price of this kind of futarchy.


What if the attacker ignores our futarchy market entirely, but makes a combinatorial market on another blockchain, and arbitragers are making the prices match between our markets
=====================

Arbiteragers can only profit from doing arbitrage if the extra money they earn from a contract is worth more than the loss they experience due to having money trapped in this contract for a period of time.

The combinatorial market is insecure because there isn't a profit motive to fix an incorrect price in some situations. So, arbiteragers wouldn't have a profit motive to fix a discrepancy between the 2 markets.


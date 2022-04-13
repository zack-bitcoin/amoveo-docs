Futarchy's Failure
==============

What is Futarchy?
============

Futarchy is a way for groups of people to make a decision together, where they are trying to optimize for achieving some shared goal.

A couple examples of the kind of situations where we would like to use futarchy.

1) The bitcoin users wanted to make a decision about whether the block size should increase.
They could use futarchy to find out which choice results in BTC having a higher value.

2) People living in a country, and they want to decide who their leader should be. The shared goal could be GDP, or whatever other measure we could want to optimize for.


Futarchy is a kind of prediction market.
All markets have a price.
This price always reveals information.
Sometimes that information is useful.
The market for futures for corn is a prediction for what the price of corn will be on some future date.
A political betting market's price reveals the probabilities that different candidates have for winning the election.
A sports betting market has a price that reveals the probability of which team will win.

In prediction markets we are crafting a financial asset, such that the market price of that financial asset reveals something useful to us.
For example, if we want to decide whether bitcoin blocks should be Big or Small, and we want the price to be High instead of Low.
Then we would create these four assets:

* BH - block size is Big and the price is High.
* SH - block size small Small, the price is High.
* BL - block size is Big and the price is Low.
* SL - block size small Small, the price is Low.

And by comparing the prices of these 4 assets traded against each other, we could find out whether a bigger block size in Bitcoin would impact the likelyhood that the BTC price will be high.

Robin Hanson and Ryan Oprea did experimental research, and wrote this paper showing that prediction markets do work in some cases.
http://archive.dimacs.rutgers.edu/Workshops/Markets/hanson.pdf?wptouch_preview_theme=enabled

Robin Hanson also participated in this entertaining debate where he explains using prediction markets to make decisions. https://www.youtube.com/watch?v=Tb-6ikXdOzE

The goal of this paper is to find out what exactly are the situations when futarchy works.

Equations explaining when futarchy does not work.
===========

Attackers make bets that will have an expected loss. They do this to manipulate the prices in the futarchy market.
Defenders make bets with an expected profit, and this causes the price in the futarchy market to return to being an honest signal.

S = Signal. How much our shared choice determines whether we achieve our goal. If raising the block limit would increase the bitcoin price by 5%, then S=0.05

P = Probability that we make the less likely choice. A number between 0 and 1. If the bitcoin community only has a 0.2% chance of increasing the block size, then P=0.002

L = Liquidity. The amount of money defenders have ready to participate in prediction markets. In the context of blockchains, L is necessarily less than the market cap of the tokens in the blockchain where the prediction market happens.

X = amount of money an attacker is willing to lose to manipulate the market.

I = interest rate in cryptocurrency for the duration of the market. If you can earn 20% a year by lending your VEO, and the market will last for 3 months, then the for 3 months is around 4.7%, so I=0.047

Attack succeeds due to inprofitabilty of defence, if
```
(profit of defense) < (cost of defense)
S * P < I
```
P is because it is liquidity inefficient to move the price by buying the more expensive type of share. If defenders need to spend 2x as much to move the price the same distance, then the defenders are losing interest on 2x as much money.
S is because the attacker is only expected to lose S portion of his funds, so the defender can only expect to earn that much.
I is because the defender expects to lose this much while waiting for the prediction market to settle.


Attack succeeds due to defenders having insufficient funds to defend, if 

```
(defenders have) < (defenders need)
(S * L) < (X / P)
```

The S is because we are expecting the defenders to use a profit maximizing strategy. They want to hedge against the risk that the result of the market is determined by something other than the decision futarchy is making. Kelly's criterion says that investing only S portion of their funds is the most profitable strategy for defenders https://en.wikipedia.org/wiki/Kelly_criterion

P is because the defenders are buying the more likely outcome, so they need to invest more money to move the price a smaller distance.

If both equations are false, then futarchy works.

examples
=========

If we want to use futarchy to increase the bitcoin block reward.
The likelyhood that the reward will increase is very low, the bitcoin community cares a lot about not increasing it. Only a 1 in 200 chance.
So P = 0.005.
The market needs to last a few months, so we can see the effect of the new block reward on the price. Due to volatility, the interest rate over that period is estimated at 5%.
So I = 0.05.
The BTC price is influenced by a lot of things besides the block reward. So S is probably very low. But for arguments sake, lets estimate S as the highest value possible. This would be the case if the BTC price is 100% determined by whether we raise the block reward or not.
So S = 1.

Now we have enough variables to know if participating in the defense for this futarchy market will be profitable.
If S*P<I, then defenders will not participate.
```
(S=1)*(P=0.005)<(I=0.05)
1*0.005<0.05
0.005<0.05
```
So, it is not profitable for anyone to participate in this futarchy market. The price of this futarchy market is not an indicator of how changing the block reward of Bitcoin will influence the price of BTC.

But lets continue the example anyway, and see how much liquidity would be needed for the defenders to block this attack.
If we are using Amoveo to host this futarchy market, then L is at most the market cap of Amoveo. So lets estimate L as around one million dollars.
L = $1 000 000

The attacker is actually someone who owns a lot of BTC mining hardware, and they stand to profit substantially if the block reward were increased. He expects to earn ten thousand dollars.
X = $10 000.

The attack succeeds if
(S * L) < (X / P)
(1 * $1 000 000) < ($10 000 / 0.005)
$1 000 000 * 0.005 < $10 000
$5 000 < $10 000

So this shows that the defenders do not have sufficient funds to prevent the attack. The attacker would successfully manipulate the futarchy market, and it would only cost him $5000, which is 1/2 of the money he is willing to lose to manipulate this market.


What can we do to make futarchy accurate?
=============

First off, never trust the result of a futarchy market if either of these 2 inequalities are true.

Futarchy is more accurate if the signal is stronger. So that means when we are making the financial asset fo rthe futarchy market, we want to cancel out noise as much as possible.
Looking at the example of futarchy to increase the bitcoin block reward, instead of asking "Is the price of BTC above $40k?", it would be better to ask "Is the price of bitcoin above 13 ETH?".
Because a lot of things that would cause BTC to move would also cause ETH to move, there is less noise, so S is higher.

Futarchy is more accurate if we are making a decision between 2 choices, and the likelyhood of each choice is nearly the same.
This makes futarchy a kind of self-fulfilling prophesy. It works better for groups of people who believe in it more.
It is like the pixie dust from Peter Pan. Which granted the ability to fly, but only to people who believed in it.
If this futarchy market only exists to give advice to someone else who has real control, and they already made their decision, and they will ignore whatever the futarchy market says, then P=0, and it is almost free for an attacker to manipulate the result.

Futarchy is more accurate when I is lower. So it is better to use a currency with very low volatility for the bet. A stablecoin. And it is better if the bet lasts for the least time possible.

Futarchy is more accurate if L is bigger. So when choosing the currency for making the futarchy market, it is better to use a currency with a higher market cap. And it is better to use a currency where a larger portion of the holders are interested in participating in a futarchy market where they will earn expected profit.

Futarchy is more accurate if X is smaller. So when using futarchy to make decisions, it is better if there are no individuals who can earn or lose a large amount of money based on which decision is made. We should try to format our decisions so that there are no winners or losers. Instead we want to make decisions that result in mutual benefit vs mutual loss. Basically, try to minimize corruption in the decision making processes.
Review of MetaDAO.
===========

MetaDAO is a futarchy DAO built on Solana. That means they have bets in the blockchain to make decisions about how to inflate the money supply, and use the new money to make the currency more valuable.

According to metaproph3t, who designed this futarchy, it works like this:

"it's 2 markets: one for conditional-on-pass USDC to conditional-on-pass META and one for conditional-on-fail USDC to conditional-on-fail META. so if I'm bullish on a proposal, I lock USDC in exchange for conditional-on-pass USDC and conditional-on-fail USDC, then trade my conditional-on-pass USDC for conditional-on-pass META. that way, if the proposal passes, I get the META. if the proposal fails, I keep my USDC"

USDC is a stablecoin, META is the governance currency for the MetaDAO.


1) Split the USDC token based on whether the proposal passes. Making True-USDC and False-USDC. True-USDC is worth USDC if the proposal passes, and it is worth zero otherwise.
2) Split the META token based on whether the proposal passes. Making True-Meta and False-Meta.
3) make a market between True-USDC and True-Meta.
4) make a market between False-USDC and False-Meta.

By comparing the markets from steps 3 and 4 we can tell how this proposal will impact the price of META.

If an attacker wanted to manipulate the result of this futarchy to make the proposal pass, they would need to either buy up True-Meta or False-USDC to manipulate the price.


How this is different from Amoveo's Futarchy
============

The key difference is that in (Amoveo's design)[../blog_posts/futarchys_back.md], we are using reversible bets for the futarchy. This was the recommendation of Robin Hanson, who invented the idea of futarchy.

Reversible swaps are limited in comparison to other alternatives. Especially in the blockchain setting, we would really like our assets to be fungible, so we can use normal subcurrencies to represent them.
This has caused generations of futarchy mechanisms to use alternatives to reversible swaps.

Why are reversible swaps so important?
Reversible swaps make it so that participants on both side of the market need to lock up similar amounts of coins in order to impact the price of the market similar distances.
If one side of the market can move the price using less money than the other side, this can make it liquidity-inefficient to defend the market from manipulation, and can leave the futarchy vulnerable to having it's result profitably manipulated by an attacker.

So, the goal of the remainder of this paper will be to show that MetaDAO's futarchy market is vulnerable to this kind of attack.

The attack
============

The attacker wants a futarchy market that is unlikely to pass.
So, they can propose giving themselves a bunch of newly inflated coins, for doing little or no work.
And, the attack is more effective if it looks like the proposal will harm the price a moderate amount.
For this proposal, lets inflate the supply just enough so that the price will fall by 5%. and set P = 0.05
They give all the newly inflated money to themselves.

True-USDC measures the probability that the event will pass. So, it will be worth almost zero. Since it is unlikely that people will give me free money for nothing.

True-Meta measures ` (the prob that the proposal will pass) * (the impact this proposal will have on the price) `. So, it will be worth almost zero as well.

This means it will be cheap for an attacker to buy up either True-USDC or True-Meta.

* buy USDC, and convert it to true-USDC and false-USDC.
* sell false-usdc for almost the price of USDC, since people expect the proposal to fail. Make sure they pay more than (1-P).
* accumulate as much true-USDC as you can before people realize you are preparing to attack.
* use the true-USDC to make orders in the market to buy true-meta

This manipulation is very cheap. You are paying less than P per token bet in the market.

For defenders to try and block the manipulation, they would need to:

* buy meta, and convert it to true-meta and false-meta.
* sell the false-meta for almost the price of META, since people expect the proposal to fail. But, now that the attack has started in public vision, the price is going to be steeper than it would have been before when the attacker was accumulating in secret.
* use the true-meta to make orders in the market to buy true-USDC.


The defenders need to lock up more than the attackers, so it is not secure.

Unusual payout for this game if the attack succeeds
=============

At the end of the attack and defense, the attacker ends up holding lots of true-meta. the defender ends up holding lots of true-usdc.

And there are other participants in the futarchy who are holding false-meta and false-usdc, because they rightfully expect the proposal to fail. These participants lose everything.

So, if the attack succeeds, the attacker will have earned many meta and he has only paid a small fraction of their cost. 
And, if the attack succeeds, the defender will have earned many USDC, and has only paid a small fraction of their cost.

The attacker also wins all the free Meta that they have inflated into existence, because of their proposal succeeding.

If the attack fails, then the attacker and defender both lose all the money that they had used to attack/defend with.


Reassessing defender altruism
=============

If defense succeeds, then the defenders lose the money they had used to defend with.
That means defense is working by P+epsilon logic. The only people who participate in defense are those who think that the attack could succeed, and are hedging against that possibility.

But, the defender could also just sell everything and get out of the metadao before this futarchy market terminates.
If they use Q portion to defend with, then either they are left with
1) (1-Q) OR
2) Q/(P * 2)

So, we set them equal to minimize loss and solve for Q.
```
(1-Q) = Q/(P * 2) ->
1/Q - 1 = 1/(2 * P) ->
1/Q = (1 + 2 * P)/(2 * P)
Q = (2 * P)/(1 + (2 * P))
```

For our example,

```
P = 0.05
Q = 0.1 / (1 + 0.1) = 1/11
```

So, this means even if a defender is perfectly hedged, they are expected to lose 1/11th of their money.

assuming the defense succeeds, a free-loader wouldn't lose any money, even though they didn't help in the defense at all.

This means defenders are better off exiting the meta-dao before the futarchy resolves, instead of trying to participate.


Can we prevent the attack if the users avoid certain markets?
===================

A key step for this attack to work is that the attacker needs to be able to buy True-Meta, without holding False-Meta or False-USDC.

As long as everyone else refuses to do trades that enable the attacker to hold True-Meta without any False assets, then the attacker cannot do the attack.

This does not work, in game theory it is called a tragedy of the commons.
Just because the UI you build doesn't have a tool for swapping certain assets, doesn't mean people wont do it anyway. If the attacker is paying above market rate, you can't expect users to forgo the opportunity to earn money.

This is similar to the parasite oracles problem in Augur.
Individual trades are incentivized to use the parasite oracles, even though if too many of them use it, the whole thing becomes insecure.
It is a situation where the benefit is individual, but the cost is collectivized. A kind of tragedy of the commons.

So, MetaDAO cannot be made secure by advising the users to avoid certain trades.


Can we prevent the attack by doing the DAO proposal mechanism twice?
====================

The new version of MetaDAO will work by doing the proposal mechanism twice. In order for a proposal to pass, the first round of futarchy must result in True, and the second round muss result in False.
The second round is a chance to cancel the proposal.

The idea is that if an attacker successfully got a bad proposal through the first round, everyone will see what he is doing, and it will be more difficult for the attacker in the second round now that he has more attention.

Since the users know that the attack is happening, the attacker has lost the element of surprise. So, it wont be quite so cheap for them to buy upr the True-USD. It costs as much for defenders and attackers to move the price.

But, it still is not profitable to participate in defense. It would be more profitable to sell your Meta and buy back in after the attack is over instead of participating in defense.

So, doing two rounds of the MetaDAO protocol still is not secure.

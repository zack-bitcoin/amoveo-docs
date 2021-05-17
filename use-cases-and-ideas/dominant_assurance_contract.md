Dominant Assurance Contracts
==================

Also called DACs, are tools to raise funds to pay for public goods.
The people who benefit from these public goods are the ones who pay for them.
No one pays more than how much it could benefit them.

Mechanism
==============

We use futarchy mechanisms to measure how much this public good will benefit the stock price of many companies in the case where they don't have to pay for it. Now we have a list of who will benefit, and by how much.

We take the costs of how much it will cost to build the public good.

We verify that the total benefit is more than 150% of the cost of building it, otherwise the DAC will fail.

We use a secure random number to remove about 1/3rd of the companies from the list, weighted by how much they benefit.

We distribute the costs to the companies that will benefit proportionally to how much they will benefit.

If every company agree to pay their portion, then we attempt to build it. If the public good gets built, then the builder gets the money that the companies had provided. If the public good is not built, then every investor gets a refund, plus some extra money from the builder for having wasted their time.

If even one company refuses to pay their portion, then we do not build it. Every company on the list gets a refund of the money they had locked in the contract, as well as some extra money from the builder for having wasted their time.

Why cancel it if someone doesn't agree to pay?
========================

If there was a way to not participate, then every company would prefer to not pay, and be able to benefit from the public good anyway.

Why remove 30% from the list?
========================

The prediction market is asking about the case when they are not on the list. So we need there to be some significant probability that each company will not be included, that way there is enough probability space available to be measured by the prediction market.

It is important that if we re-attempt to raise money for a DAC after the first DAC failed to get everyone to sign, that we exclude the same 30% of the list. If we change who is excluded, then people have an incentive to refuse to pay, in the hopes that they are in the next round's 30%.

Why does the prediction market ask about their benefit conditional on them not having to pay?
===============

We want to measure how much the public good would have benefited each company, independent of the impact this DAC has on them.

In particular, we want to avoid the burning-money strategy, like what exists in the Battle-of-the-Sexes game from game theory https://en.wikipedia.org/wiki/Battle_of_the_sexes_(game_theory)

The older version of the DAC involved insurance, why did we get rid of that?
================

For the DAC to work, we need to know how much the public good will benefit various entities. One way we had though to get them to reveal this information is by selling insurance.
The problem with selling insurance is that if that insurance potentially comes with an obligation to pay for something that would have been free otherwise, this significantly impacts how much insurance they are willing to buy, and so the price of insurance fails to reveal how much each entity is benefiting from the public good.

Why reward participants if someone refuses to sign?
==========

The worry is that one of the entities on the list of who should pay for the public good, they could demand a bribe and refuse to pay their portion unless everyone else on the list pays them first. This kind of problem means that everyone would want to be the last participant to lock their funds into the DAC.

Giving a reward to the other participants means that they can safely ignore the hostage attempt, and still profit.

The attacker's hostage attempt will fail, and they are missing out on receiving the extra reward for having participated, so this mechanism prevents hostage attempts from occuring.

Nash equilibrium analysis
================

Whether the project is funded or not, it is more profitable for each company to sign up to fund their part. So the Nash equilibrium is that the project gets funded.

Trust Theory analysis
=============

[trust theory explained here](../basics/trust_theory.md)

If someone refuses to pay their part of the public good, this causes a cost to them of not being able to receive the extra reward money from the builder.

If someone refuses to pay their part, the cost on the builder is as much as all the extra reward money they need to pay to those entities which did sign up.

So the cost of the attack is less than how much value the attack can destroy. This means that the mechanism has security level 3.

If customers of the companies reduced their business with companies that engage in extortion threats, this extra cost could move the mechanism to security level 2.

Related documents
==============

[raising funds with amoveo](raising_funds.md)


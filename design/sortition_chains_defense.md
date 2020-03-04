Sortition Chain Defense
=============

[sortition chains home](./sortition_chains.md)


The purpose of this document is to look at several criticisms of sortition chains, and see if they will break under various situations.

operators steal the money attack
===========

What if the operators assign your money to them in the probabilistic value tree?

As long as they had assigned it to you first, then your claim has higher priority. So if you win the lottery, they cannot prevent you from taking the prize.

What if the operators make a waiver saying that you gave up ownership of your part of the probabilistic value space?

The waiver is only valid if you signed it.

Tx censorship attack
===========

What if the sortition operators refuse to allow you to move your money? Will you get stuck holding lottery risk?

When the sortitoin chain is finally being settled, before the RNG is generated to choose a winner, there is a period of time when you will have one final chance to sell your part of the soritition chain.

Frozen sidechain attack
===========

What if one of the sortition operators stops signing any updates, so no one can transfer their funds inside the sortition chain.

If the sortition chain is frozen, it is still possible to prove what your current balance is in the sortition chain. So we can have a period of time between when the sortition operators are able to make updates, and when we generate the RNG to determine the winner.
During this period of time, we can give everyone one final chance to sell their value from the sortition chain.

So during this time we should allow people to sign an agreement off-chain that says "If I win the sortition chain, I want 100% of the value to go to X".

we can use hashlocking to connect the creation of this agreement to a payment in a different sortition chain, and we can combine it with a safety deposit that you pay.

We can set it up so that if you make multiple of these agreements that contradict with each other, that you will not receive the payment, and you lose your safety deposit.
This is re-using a trick from probabilistic payment research.

Data availability attack
==========

If some of the operators sign sortition-blocks even though some of the data is not available, this is a kind of attack.

This can make it impossible to spend your funds, because you can't prove to anyone if you have money or not. So you can be left holding lottery risk.

As long as at least 1 of the validators is honest, then this attack can't happen.

If this attack does occur, it is not profitable for the attacker, and we know who did it, it was the validators.
But, the cost of the attack is less than how much value can potentially be destroyed.
In terms of [trust theory](basics/trust_theory.md), this is a 3.2 level trust theory situation.

But, given that even 1 honest validator can prevent this attack from occuring, this level of crypto-economic trust is acceptable.


Sortition chain Timeline
===========

~2 months: it is possible to make payments and contracts in the sortition chain.
~1 week: everyone gets one final chance to sell their stake.
~1 week: people can provide evidence to resolve the random value used to determine the lottery winner.
~1 week: people can provide evidence to prove that they won the sortition chain.




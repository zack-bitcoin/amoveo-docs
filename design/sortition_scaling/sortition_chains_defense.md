Sortition Chain Defense
=============

[sortition chains home](./sortition_chains.md)


The purpose of this document is to look at several criticisms of sortition chains, and see if they will break under various situations.

operator steal the money attack
===========

What if the sortition operator assigns your money to someone else in the probabilistic value tree?

As long as they had assigned it to you first, then your claim has higher priority. So if you win the lottery, the sortition operator cannot prevent you from taking the prize.

What if the operator make a waiver saying that you gave up ownership of your part of the probabilistic value space?

The waiver is only valid if you signed it.

Tx censorship attack
===========

What if the sortition operator refuses to allow you to move your money? Will you get stuck holding lottery risk?

When the sortitoin chain is finally being settled, before the RNG is generated to choose a winner, there is a period of time when you will have one final chance to sell your part of the soritition chain. During the final-spend period, validators can't stop you from spending.

Frozen sidechain attack
===========

What if the sortition operator stops signing any updates, so no one can transfer their funds inside the sortition chain.

If the sortition chain is frozen, it is still possible to prove what your current balance is in the sortition chain. So we can have a period of time between when the sortition operators are able to make updates, and when we generate the RNG to determine the winner.
During this period of time, we can give everyone one final chance to sell their value from the sortition chain.

So during this time we should allow people to sign an agreement off-chain that says "If I win the sortition chain, I want 100% of the value to go to X".

we can use hashlocking to connect the creation of this agreement to a payment in a different sortition chain, and we can combine it with a safety deposit that you pay.

We can set it up so that if you make multiple of these agreements that contradict with each other, that you will not receive the payment, and you lose your safety deposit.
This is re-using a trick from probabilistic payment research.

Data Unavailability + double-spend final_spend_tx
==========

If the validator is refusing to reveal merkle proofs, then you can't know if the validator has put more people in line to own some value.

Bob wants to accept a final_spend_tx from Alice, and he is atomically linking it to another payment in another sortition chain.

So if Alice tries to spend her value to whoever is next in line after her, then Bob needs some way to undo his payment to Alice, so she can't rob him. Now I will show that the probabilistic nature of sortition chains makes it impossible to enforce this kind of contract.


The smart contract in Bob's payment to Alice, it should require that Alice does not create a waiver which would invalidate the final_spend_tx.

Alice puts Charlie second in line, and gives him a waiver so he owns the value.
If Charlie doesn't win, he has no reason to reveal the waiver, and Alice can pay him to not reveal the waiver in that case. So Bob's payment to Alice is not canceled.

If Charlie does win, he can publish the waiver and claim the winnings. So Bob does not win. and Bob's payment to Alice is canceled.

So Bob can't possibly win, and if he doesn't win, his payment to Alice is not canceled.  Bob can lose money, but cannot gain, so the final_spend_tx has failed.


Sortition chain Timeline
===========

~2 months: it is possible to make payments and contracts in the sortition chain.
~1 week: everyone gets one final chance to sell their stake.
~1 week: people can provide evidence to resolve the random value used to determine the lottery winner.
~1 week: people can provide evidence to prove that they won the sortition chain.











Using oracles to check for availability
===============


The attack we are worried about is that the validator will create some on-chain merkle commitments for the sortition chain, and they will refuse to reveal any merkle proofs to the users.
This is a problem, because the users can't know who is next in line to own their value.
It prevents the final_spend_tx from happening, because whoever is receiving the final_spend_tx can't be sure if there is someone else in line after you, and you will sign a waiver to give the value to them, which would invalidate the final_spend_tx.

To prevent this kind of attack, we will have a specialized version of the oracle that is used to find out the earliest height when data became unavailable.
Oracles can know about any publicly available information, so as long as <the fact that data became unavailable at a particular point in time> is common knowledge, then the oracle can import this fact into the blockchain.
So as long as we can make this fact common knowledge, we can prevent this kind of attack.


The plan is that availability-explorers should keep a historical record about which data became unavailable at which times in which sortition chains.
In order to afford this, users will buy insurance contracts from the explorers.
So if an availability attack occurs, and the explorer fails to record it, then the explorer loses money to the users.

The explorer is specialized in giving a useful interface to provide this service to users. So you can easily buy insurance from the explorer, and you can easily check the historical records of availability. The explorer publishes merkle roots on-chain, that way it is unable to re-write the history of which data was available when.



what if the validator and explorer team up to attack

So, lets say that a data availability attack does occur, and the explorer does not record it for the first few hours.
In this case, the users of the explorer will notice that their data is not available, and they will send warnings to the explorer, and they will realize that the explorer is failing to record unavailable data.
So the users can send out a warning to each other that this explorer has gone corrupt.
Anyone who is online at this time will have evidence that the explorer is corrupt.

Hopefully enough people realize that an attack is occuring so that when the oracle can correctly report the height at which the attack started.

As long as the delay for how long an attack needs to occur to matter is long enough.

This will also let us realize that this explorer should no longer be used, and we will use other explorers instead.




we could have one oracle that triggers the insurance payment and another oracle that freezes the block
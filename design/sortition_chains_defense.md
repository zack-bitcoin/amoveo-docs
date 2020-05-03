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


Data availability attack
==========

If the operator signs a merkle root for a sortition block tx, and then refuses to reveal the data that can be proved from this root, that is a "data availability attack".

You still get one final chance to spend your value in the final-spend-tx period, but until then your money is frozen.

If the operator doesn't reveal the data from the merkle root in the sortition block, then no one can know if new people were added to the line to own different value or not.

Sortition chain Timeline
===========

~2 months: it is possible to make payments and contracts in the sortition chain.
~1 week: everyone gets one final chance to sell their stake.
~1 week: people can provide evidence to resolve the random value used to determine the lottery winner.
~1 week: people can provide evidence to prove that they won the sortition chain.




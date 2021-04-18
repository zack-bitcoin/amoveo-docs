PoS time warp attack
=============

All proof of stake protocols depend on an unbonding period to be secure.
The goal of this paper is to show that an unbonding period cannot be enforced, and so PoS cannot be secure.

Unbonding Period
============

An unbonding period is when a PoS validator signals their intent to retire as a validator. They want to withdraw their stake, and stop having an obligation to participate as a validator.

It is important that the unbonding period is not too short, because if validators could withdraw their stake too quickly, then we don't have an opportunity to punish them for misbehaving. It can take the network a while to realize that a validator had done something wrong and needs to be punished, so the validator's stake needs to be locked in the network for at least that long.

The attack
=============

A coalition of validators, they make a bunch of blocks ahead of time.
For example, if the unbonding period is 1000 blocks.
In that case, the validators immediately make the 1000 blocks, then the following 1000 blocks, each one takes 2x longer than normal.
So after 2000 blocks, the network is back on track, and normal full nodes can sync all the history as if nothing unusual had happened.

Non-attacking validators are not able to do any validation for the 2000 block period, and so are dropped out of the system.
After the first 1000 blocks, the attacking validators have unbonding the vast majority of their stake, but the attackers still have 100% control.




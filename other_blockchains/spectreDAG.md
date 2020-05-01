Spectre - DAG
=========

https://eprint.iacr.org/2016/1159.pdf

The attack against DAG is like this:
bribe some of the miners to add a new rule about what kinds of txs they accept.
These miners will not build on top of any block that breaks the new rule, but they still publish their blocks right away.

Honest miners will build on top of attacker's blocks, because the attackers are obeying the entire rule set that the honest miners know about.

eventually, enough honest miner blocks are being orphaned, so they switch to the new ruleset so they can get better block rewards.

In bitcoin you could only achieve this by paying at least 50% of the block rewards for an extended period of time.

with DAG miners still get paid even if they censor the honest miner's blocks. So the cost of the bribes is very low.

Honest assumption
===========

on page 17 section C they are talking about censorship attacks.
soft fork bribery attacks are a kind of censorship attack.
But they don't go very deep into details.

A 66 page paper, and the part that matters is only 1/2 page. haha
774 KB
But it seems like they are making an assumption that the majority of miners will honestly report about which tx they had seen first.


Assuming that miners will honestly report which tx they had seen first, even if there is not financial incentive to enforce them to report honestly, that is a vulnerability based on my model of trust theory https://github.com/zack-bitcoin/amoveo/blob/master/docs/basics/trust_theory.md
If the cost to execute an attack is zero, then it is not secure.


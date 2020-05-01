Spectre - DAG
=========

paper about spectral dag: https://eprint.iacr.org/2016/1159.pdf

Spectre's challenge
=============

Spectre has 2 contradictory problems to solve.
They want to stop people from building blocks in secret to overtake the chain.

So to stop this, they need to reject blocks that don't get referenced by other recent blocks.

The other problem is if an attacker builds blocks and refuses to reference other blocks, in an effort to censor them, this needs to be punished also. 

But any effort to prevent the first failure mode would make the second failure mode easier to pull off. And any effort to prevent the second makes the first easier to pull off.
So when you are imagining features that could help prevent one failure mode, you need to also consider if you are creating a vulnerability in the other failure mode.

Unreferenced blocks are necessarily censored
============

If the top priority block doesn't have your block as an ancestor, then your block is censored.

Imagine I made a tx that conflicted with a tx in the dead block, and my tx got included in a recent block. Which of the conflicting txs wins?

If the dead block wins, that means I can rewrite history after the fact by building dead blocks.

If the dead block loses, then all the txs in it are worthless. Since they always lose.

So a block that is never built on top of, might has well not exist at all.

Soft fork bribery attacks
===========

bribe some of the miners to add a new rule about what kinds of txs they accept.
These miners will not build on top of any block that breaks the new rule, but they still publish their blocks right away.

Honest miners will build on top of attacker's blocks, because the attackers are obeying the entire rule set that the honest miners know about.

eventually, enough honest miner blocks are being orphaned, so they switch to the new ruleset so they can get better block rewards.

In bitcoin you could only achieve this by paying at least 50% of the block rewards for an extended period of time.

with DAG, miners still get paid even if they censor the honest miner's blocks. So the cost of the bribes is very low.

Spectre's fork choice rule
============

If spectre was a serious attempt at a blockchain consensus, the first thing they would do is give a fork choice rule. To calculate the weight of the chain from any given block. So we can know which block has highest priority.
Blockchain designers are always scared to admit the fork choice rule, because then it is obvious how it is broken.

If they can obscure the fork choice rule, then they can secretly use a different fork choice rule for every example, and trick people into thinking it is something that can exist.

This is an example of [over generalization in blockchain design](over_generalization_in_blockchain_design.md)

Spectre light nodes are computationally infeasible.
============

Assuming that Spectre doesn't force every user to run a full node and sync every single tx, there must be a way to do light nodes.
If there are light nodes, then there needs to be a way for the light nodes to verify merkle proofs to be sure that their tx was included in a block and wont get un-spent.

So, each block must have a merkle root for the utxo set/accounts database from that point.

But, according to the spectre paper, conflicting txs can switch out which has the highest priority when new blocks get mined. So that means a full nodes would need to scan the entire UTXO set for every single block, to assign new priorities to every output, and possibly switch out valid and invalid outputs.


Honest assumption
===========

on page 17 section C they are talking about censorship attacks.
Soft fork bribery attacks are a kind of censorship attack.
But they don't go very deep into details.

But it seems like they are making an assumption that the majority of miners will honestly report about which tx they had seen first.

Assuming that miners will honestly report which tx they had seen first, even if there is not financial incentive to enforce them to report honestly, that is a vulnerability based on my model of trust theory https://github.com/zack-bitcoin/amoveo/blob/master/docs/basics/trust_theory.md
If the cost to execute an attack is zero, then it is not secure.


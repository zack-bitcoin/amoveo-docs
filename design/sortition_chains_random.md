Lottery Random Number Generator
============

[sortition chains home](design/sortition_chains.md)

The requirements for a RNG for a lottery with a large prize are much stricter than most other blockcain RNG applications.
If an attacker has even 1% ability to predict or influence the bits produced by the RNG, this can seriously impact the cost of using the lottery or sortition chain.

Reroll attacks
==========

A reroll attack is when one of the participants involved in generating the random entropy, if they choose to not participate in some part of the process.

For example, lets say we are using the block hash at block height H as our random entropy.
That means that the mining pool that finds block H will be the first to know what randomness is being generated. If they are unhappy with the randomness that was drawn, they can choose to delete the block and never publish it.
This gives the attacker influence over the randomness being generated in proportion to how much of the hashpower they control.

Modeling Financial Randomness
==========

In the context of blockchains, when we are modeling some random entropy, there are 2 main factors that are important to us about the entropy:
1) how many bits of entropy is it?
2) how much does it cost to gain influence or predictive ability of the bits?


Delayed cryptography RNG
=============

A couple papers on this topic:
https://eprint.iacr.org/2015/1015.pdf
http://www.jbonneau.com/doc/BGB17-IEEESB-proof_of_delay_ethereum.pdf

[Here is the delayed crypto library I wrote for Amoveo](https://github.com/zack-bitcoin/vdf_calculate)

We use time-delay crypto to generate the random value to determine the winner. We use an on-chain fraud proof in log128(number of hashes in the time-delay) steps.

https://www.gwern.net/Self-decrypting-files a blog post on this topic

The average user doesn't need to run the time-delay crypto operation. There is a reward for proving who won.
Since whoever can prove the winner first gets a prize, we will have a good estimate of how long it took to find the winner. So if hardware improves, we will know when it is time to make the time-delay more expensive.

Calculating the cost to attack this RNG
=================

If the fastest computer needs 30 blocks of time to know who won the lottery, then an attacker would need to bribe ~30 miners to not publish their blocks. That way the attacker has enough time to calculate what the next block should be to make them win.

So lets estimate the cost of those 30 bribes.
The first one is as expensive as a block reward. Because the miner is forgoing a block reward by deciding to not publish.
The second one would again cost the miner 1 block reward to not publish. But the 2nd miner knows that you already paid 1 bribe. So they know that if they publish the block immediately, the cost to the attacker is 1 block reward. So that means the 2nd miner, they can demand a bribe of 2 block rewards.

The Nth miner would need a bribe worth (1 block reward) + (sum of all the bribes so far)
Which works out to (2^N)*(block reward)

So if we increase the time-delay linearly, the cost to attack the system increases exponentially.

If the fastest RNG computation takes 30 blocks, then the total bribes to attack one sortition chain would be ~1 billion block rewards.


Estimating time for on-chain proofs
=================

if we do 10 million hashes per second for the time delay function, and we set it up to take 30 blocks, and each block is 10 minutes = 600 seconds, then the on-chain proof to show that you won is log128(10 million * 30 * 600) = 4.87.

the most round that the fraud proof could possibly need is 5.
If you have 20 blocks of time to provide evidence for each round, and the person trying to show that you cheated also has 20 blocks, (20+20)*5 = 200.

So at most, it could take up to 200 blocks to prove that you won and get your winnings out of the sortition chain.
That is about a day and a half, if we have 10 minutes per block.

Fast verification of RNG
=========
computing the RNG initially takes like 8 hours or so. But once we have solved it once, it can be efficiently verified using GPU.
The cpu makes 128 checkpoints evenly spaced out.
The GPU can simultaniously verify many batches of the VDF result, it can verify the connections between each of the 128 checkpoints concurrently.

The RNG computer is based on a CPU SHA256 miner written in C.
The RNG verifier is based on a GPU SHA256 miner written in cuda.
So verification will be faster based on the relative speed difference between CPU mining and GPU mining.

RSA Accumulators
============

Ive been studying RSA accumulators lately. I wrote this test version to try it out: https://github.com/zack-bitcoin/homomorphic-tools/blob/master/rsa_accumulator.erl

I explored the possibility of using them to allow for private oracles https://github.com/zack-bitcoin/amoveo-docs/blob/master/design/private_oracles.md

The goal of this blog post is to explore the trade-offs you can make for the different configurations you can have an RSA Accumulator in.

Merkle Trees
===========

RSA Accumulators are an alternative to merkle trees. So we should have a basic comparison with merkle trees.

A merkle tree with N elements, it has proofs that are O(log2(N)) long.

An RSA accumulator proofs are O(1) long.

A merkle tree with N elements, it costs O(log2(N)) to produce a proof.
In an accumulator, it costs O(N).

Proof production can happen off-chain in parallel, so moving cost to the proof production stage can be a good trade off.

In the stateless full node design, proofs make up >90% of the block space, so getting them shorter helps scalability.

The main idea with RSA accumulators is that we are trying to use them instead of merkle proofs whenever possible, to move computation off of the full nodes, to make the blockchain more scalable.

They aren't better than merkle trees in every case, but there are certain situations where RSA accumulators work very well.


Mandatory settings for on-chain accumulators
===========

If we want an RSA accumulator on-chain, then there needs to be a O(# transactions in that block) way for the miners to update the RSA root to be valid at each block.

This means the RSA accumulator is write-only. You cannot delete any information, but we can restart an accumulator from being empty again. You cannot edit any information after it has been written.


Binary storage
===========

One strategy is to specifically use the first 100k prime numbers to store binary information. One bit per prime number.

If you assign useful questions to these prime numbers, then this is a good way to store the answers to those questions, once they become available.

Because we are using the entire sequence of primes, it is very compressible. You can make a reference to 346th through 362nd prime numbers, and look up the 1 byte of information that can be stored there. And you don't need to write out 8 prime numbers that you are looking up, you can just write [346, 362], and they know the range of prime numbers you are refering to. This means proofs are much shorter.

It makes it cheaper to maintain a proof-creating node. Since you are only using the first 100k primes, the proof creating nodes only need to remember at most 100k bits.

Because we are using the smallest available primes, the computations are simpler, so it is cheaper to make proofs, so we can afford to accumulate over more data.

Generating proofs does get harder as we accumulate over more data. O(# of bits)

For amoveo, binary storage could be a good way to store results of oracles and contracts. Because we can assign a prime number to oracles and contracts as they are created, and then insert their final state into the accumulator when they finalize.


Membership poofs
=============

Membership proof based accumulators let you store facts.
Facts get converted into random prime numbers in the available range, so we are using very big primes that are harder to calculate over. 

A fact is some information of any length. It could be the hash of a book or movie. It could be a number, or a short string of characters.

Generating proofs does get harder as we accumulate over more data. O(# of facts)


Multi-signature
==========

RSA Accumulators allow us to create multi-signatures over collections of values.
The signer accumulates over all the hashes, and then signs the root produced by the accumulator.
This way, anyone can generate proofs that parts of the collection was signed over, without needing to reveal the entire collection.

This allows for another way to organize smart contracts. Merklized abstract syntax trees allow for a contract that is N-long, but the on-chain part to use the contract is only log2(N).
If we instead used an RSA Accumulator to accumulate over all possible pages of code in the smart contract, then the on-chain part can be O(1), no matter how long the smart contract is.
This also makes the contract more private. If you run part of the contract, you are only revealing that exact clause. You aren't revealing any meta information about the size or structure of the contract.


Mini Storage
===========

This is a small accumulator that gets re-built for every block. So an element can change or disappear from one block to the next.
The cost of building an N-element accumulator is O(N), so if a block is processing O(T) transactions, we need the accumulator to contain O(1) elements per transaction.

This can work well if your blockchain needs a cache of a few values that are rarely changing, and need to be referenced in a large portion of blocks.
A merkle tree with only 8 elements has proofs that are 3x longer than the equivalent RSA accumulator.
A merkle tree with 1024 elements has proofs that are 10x longer than the equivalent RSA accumulator.
You can only use an rsa proof instead of a merkle proof if the value being referenced is not changing in this block. Otherwise you would be unable to calculate the new merkle proof.

One way to use this kind of accumulator is to just accumulate over all the data being proved in the block. So that if the next block happens to re-use any of the same data (without editing it), they can use a short RSA proof instead of the long merkle proof.

A miner can initially build a block with a long merkle proof, and someone can later do the computation to replace it with a short RSA proof. So blocks shrink over time.

So an RSA accumulator would be ideal for storing something like pure functional smart contracts that get posted on-chain, and never get edited. They only get read.

With Centralized Trust
============

If the RSA accumulator has a trusted administrator, then there are many more possibilities.

We can fit trillions of elements into the accumulator because proofs are all constant time for them to make.
We can edit or delete elements, because it is constant-time for the administrator to calculate.

We could have a smart contract where the outcome is determined by data stored in the RSA accumulator, and not even the trusted administrator knows what we are betting on.

This can be risky, because if you are betting with someone who is cooperating with the trusted administrator, they can cheat the bet and steal your money.

Simulated mutible variable
===========

Even though you cannot edit anything stored in RSA accumulators, you can simulate a mutible variable by storing versions of it over time.

In binary storage we should consume the next prime number every time we update the state. So if we are on version 9, then the first 8 primes should have already been consumed. So it should be possible to make a proof that the 8th prime is used up, but the 9th prime is not. These 2 proofs together tell us that we are on step 9.

Using fact storage, we should be able to proof a fact of the form [9, State].
The 9 indicates that this is the state on step number 9. Since we are on step 9, we want to know the state for step 9.

All together, to be able to prove the current state, you need 3 rsa proofs, but they can be compressed into a single multi-proof of 64 bytes.

Simulated mutible variables
==========

You want V many variables.

In binary storage, assign the prime numbers to the V variables in a round robin fasion.

So if variable #3 is on version 12, then primes 3, 3+V, 3+2V, ... , 3+11V have all been consumed. So it should be possible to make a proof that the 3+11V prime is used up, but the 3+12V prime has not. These 2 proofs together tell us that variable 3 is on step 12.

using fact storage, we should be able to make a proof of the form [3, 12, state].
The 3 tells us that this is in reference to variable #3, and the 12 tells us that this is the 12th state of variable #3.

All together, to be able to prove the current state of a variable you need 3 rsa proofs. if you are proving multiple variables from this same accumulator, you can use a multi-proof. so it is only 64 bytes, no matter how many things you want to prove.

The cost of making each proof or multi-proof is O(N), where N is the number of times we have updated the state of any variable in this accumulator.

Eventually, once we have made many updates, say, more than 1000, then it gets too expensive to make more updates. So we can refresh this accumulator.

The cost of refreshing the accumulator is:
you need to prove the final state of all of the variables.
This can be done as a multi-proof, so the cost is only O(N), and it only consumes 64 bytes of block space + however big the final state of all the variables are.

RSA accumulator trees
=========

If we have an RSA accumulator with 128 variables, and each of those variables is potentially the root of another RSA accumulator, then we can use this like a merkle tree to store consensus state, like account balances.

The on-chain cost of a state proof is only be log_128(# elements stored).

If we let each accumulator go until it has been updated 10k times, then that means every 5k proofs or so we need to refresh an accumulator. But that only costs something like 128*64 = ~ 8 kilobytes, and we can pay a reward to whoever refreshes it, the mandatory transaction fees can more than cover this reward.

If there are 1 trillion elements being stored, that would mean merkle proofs are 64*40 bytes, which is around 2560 bytes each.

but rsa trees with 128 children per node, they would be 64*log_128(1 trillion) = 364 bytes each. So RSA trees with 128 children per node have proofs that are about 7x shorter than a merkle tree.


Optimistic RSA Accumulator
==============

RSA accumulators have big commit sizes. like 256 bytes.
so using them as the vector commit in a verkle tree wasn't efficient,
the commit at each layer was too big.

So instead of a tree, what if we use the RSA accumulator as an infinite vector, and just keep assigning values to more prime numbers.
So the entire proof for a block is 256 bytes.
The proof can be quickly verified using O(# transactions) finite field operations.

If we keep track of a binary tree of partially completed membership proofs,
it only takes log2(# things in tree) steps to produce a membership proof.

And updating the binary tree of partially completed proofs,
it only takes log2(# things in tree) to update.

If certain values do not need to be individually proved any more,
they can be aggregated together to make proving everything else faster.
So it only takes log2(# active state elements) operations to make proofs and maintain the tree.

We can use an opportunistic non-membership proof.
The block proposer  includes a list of things that they claim have not been accumulated over.
If they lied, then anyone else can take most of the block reward from them by proving that they had lied, and that block is reverted.

Kinds of Stateless blockchains.
=============

Stateful blockchains require you to know all of the consensus state to be able to verify or produce blocks. Like bitcoin.

Strong stateless blockchains do not require you to know the consensus state to either verify or produce blocks. When you produce blocks, people who make transactions can send you the proofs you need to be able to include their block.
Strong statelessness is an important goal, because it means we can add more accounts to the blockchain without making transactions any slower. It gives infinite scalability.
Strong statelessness gives the ability to do sharding. You can keep track of whatever portion of the state you care about.

Weak stateless blockchains require you to know the consensus state to be able to produce blocks, but you don't need the consensus state in order to verify blocks.
This means if someone tells you a blockchain is invalid because one block is invalid, you can try verifying just that one block, without needing to first process the entire history of that blockchain.
Weak statelessness provides partial sharding, with the limit that a block producer can only include transaction that are restricted to only touching state that the block producer has a shard for.

Pedersen Commit Verkle Tree with IPA bullet proofs
=============

Optimized for weak statelessness. https://dankradfeist.de/ethereum/2021/02/14/why-stateless.html

https://dankradfeist.de/ethereum/2021/07/27/inner-product-arguments.html

https://dankradfeist.de/ethereum/2021/06/18/pcs-multiproofs.html

Compared with Pedersen Commit with IPA Verkle Tree
========

RSA commits are 1 group element from a large finite field, 256 bytes.
Pedersen commits are an elliptic curve point, 32 bytes.

RSA operations are finite field exponentials in a very large field. Since the field is 8x larger than the one pedersen is using, exponentials require 8x more multiplications, and each multiplication is over numbers that are 8x. the cost of multiplication is (number of bits)^2, so each multiplication is 64x more expensive. All together, RSA finite field exponentials are 256-fold more expensive than the ones used in Pedersen commits.

Pedersen commit operations are scalar multiplications over elliptic curves. Each multiplication is ~256 additions. Each addition needs to calculate an inverse in a finite field, which is a finite field exponential. So Pedersen commits needs to do ~256-fold more finite field exponentials than RSA.

These 2 factors of 256 cancel out, so Pedersen commit computational operations cost about the same as RSA operations.

Challenge 1: size of membership proofs for a block.

Challenge 2: computational cost to verify membership proofs for a block. 

Challenge 3: membership proofs can be merged. 

Challenge 4: membership proofs can be updated after we process a block. This is critical for strong statelessness.

Challenge 5: calculational cost to produce membership proofs for a block. Important for block producers. In strong stateless blockchains, it is only the cost of verifying the proofs, because tx producers send their own proofs.

Challenge 6: database reads to produce membership proofs for a block * log2(size of data read). Important for block producers, and the servers behind light clients. we multiply by the log of the size of data read, because hardware can read longer contiguous blocks of data faster. In strong stateless blockchains, it is 0 because transaction producers send their own proofs.

Challenge 7: cost to produce a membership proof to give to a light node.

Challenge 8: size of a membership proof to give to a light node.

A = # of elements stored in consensus state.

T = # of changes to consensus state per block and # of things from consensus state proved per block.

B = # of children per verkle tree node for the pedersen tree.

S = # of shards.


Challenge | Optimistic RSA strong stateless | optimistic RSA weak statless | Pedersen + IPA |
| --- | --- | --- |
1 | 256*S     |  256        | log2(B) + T*logB(A) |
2 | O(T)      |  O(T)             | O(T*B*logB(A)) |
3 | yes      |  yes              | no |
4 | yes      |  yes              | no |
5 | O(T)      |  O(T*log2(A))     | O(T*B*logB(A)) |
6 | 0      |  O(T*log2(A+256)) | O(T*logB(A)*log2(B*32)) |
7 | O(log2(A)) |  O(log2(A))  | O(B*logB(A)) |
8 | 256 | 256 | log2(B) + logB(A) |
 


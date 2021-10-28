Parallel Blocks with Flexible Ordering.
=============

flexible ordering for last N blocks.

incompatible transactions are ignored.

Block B need to include the root hash after processing block B-N.

The goal of this blog post is to explain why this strategy to parallelize block production does not work.


finality of transactions in block B
=============

Blocks B+1 until B+N-1 do not add to B's finality, because they are independent of B.

Blocks > B+N-1 do add to B's finality.

Since blocks happen N-fold more frequently, the block reward is N-fold less, and so there is N-fold less finality created per block vs normal pow.

Comparing normal PoW with a block time of 10 minutes vs parallel mining with a block time of 1 minute.

Normal PoW finality is +1 every 10 minutes.

With parallel mining, finality is +0.1 after 1 minute. then after 10 minutes, you start gaining +0.1 every minute.

So, with parallel mining you achieve your initial finality 10x sooner, but your initial finality is 10x less.
And in the long run, your finality is growing at the same rate as normal PoW, but always stays 0.9 lower.

Passing on the tx fee
=============

It is possible for there to be no block at a certain height B. So then, the miner of block B+N, they include the state root after processing block B-1.

So, if block B does exist, there needs to be some incentive for the miner of B+N to include that block in the history.

Including block B in the root hash of block B+N, it does add more heaviness to the chain with B+N

In order to incentivize the miner of block B+N to include block B when they calculate the root hash.

Contradiction
==========

Lets say 2 blocks are found at height B.

The version of B that is used, it gets decided at block B+N.
Block B+N needs to include the state hash for block B.

Block B+N+1, it needs to include the state hash for block B+1.

The state hash for block B+1, it depends on which version of block B we are going to use in the history.

Therefore, the state hash of block B+N+1, it can't be calculated unless they already know the state hash of block B+N.

Therefore, block production can't be done in parallel this way.

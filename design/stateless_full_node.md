Stateless Full Node
===================

Consensus state is the information that a blockchain maintains in a decentralized trustless way. For example, your account balance is part of the consensus state. No one can manipulate your balance, even if they are willing to spend a lot of money to do it.

The stateless full node strategy is where full nodes and mining pools do not need to store a copy of the consensus state in order to verify that blocks are valid.

Amoveo has been designed to use stateless full nodes since it launched in March 2018.

Kinds of nodes in a blockchain network
================

* light nodes. They download headers and verify pow. They can verify proofs of your account balance and sign txs. 

* stateless full node. They download and verify blocks, but only store the headers. Can be a mining pool.

* consensus state full node. They download and verify blocks, but only store headers and the consensus state. They can prove account balances to light nodes and generate unsigned txs for anyone.

* archival full nodes. They download and verify blocks, and they store the blocks.

Verifying a Block without a hard drive
============

The process of block verification in stateless full nodes.
The full node verifies the PoW on the headers.
Once a header is valid, then the full node downloads the block for that header.
The full node scans the merkle proofs from the block, it hashes the chunks of the merkle proof to verify that each merkle proof is valid, and builds up a small in-ram database of the part of consensus state needed to verify the txs in this block.
Finally, the full node can check that the txs in the block are valid. 

Verifying Blocks in Parallel
=============

One advantage of the stateless full node strategy is that the full node can verify blocks in any order. Since the full node isn't maintaining any database to verify the block, it can know a block is valid without remembering anything about the previous blocks.
So we can verify blocks in reverse order, or in parallel.

Amoveo currently verifies blocks in parallel by default, and there is a configuration option to verify blocks in reverse order. Verifying blocks in reverse order means that if a fork occurs, your node can immediately look at the blocks involved with that fork, you don't need to wait around for hours verifying history to get to the fork.
This greatly reduces how much of a safety margin we need for CPU ability for full nodes. We can use 50% or more of the CPU power to stay in sync.

The Negative Aspects
===========

The big drawback of the stateless full node strategy is that every block needs to include cryptographic proofs of all the consensus state needed for processing that block. For example, if you want to make a tx to spend some of your money, the block containing this tx needs to include a cryptographic proof of your balance. That way the full nodes can be sure that you have sufficient money to afford to spend the amount that you want to spend.

In the future we might find more efficient ways to cryptographically prove consensus state to the full nodes, but our current strategy is to use Merkle proofs. These Merkle proofs are large, they make a typical transaction about ten times larger than it would have been. So each transaction takes up 10x more space in a block than it would in Bitcoin. This means a 1 megabyte block using the stateless full node strategy can hold 10x fewer transaction than it could have with normal Bitcoin.

Parallel Hard Drives
==============

Writing to hard drives sequentially can be very fast today, even consumer products are around 1 gigabyte per second. These hard drives can be trivially parallelized in RAID to give whatever speed we need.

It is also possible to use parallelized databases with stateful full nodes, but it is very complicated. The txs need to be processed in parallel, so there are different threads that want to access the different hard drives to read/write pages of data, and if they want to look at different hard drives at the same time, they can.

No Random Harddrive reads/writes
=============

In most blockchains the bottleneck of transaction processing is in reading and writing to the hard drive. This is because as you process a block, you need to read and write little bits of data randomly scattered all over your hard drive. Reading and writing bits of data all over like this, it is around 3x slower than sequentially reading/writing, even if you use an optimal page size.
For example, in bitcoin when each transaction is processed, it consumes some unspent outputs, and creates some unspent outputs. So to process this transaction, the full node needs to search in its database for those outputs that were spent, and remove them. And the full node needs to insert the new unspent outputs into its database. Reading and writing these unspent outputs to maintain the database is very slow.

Calculating the Speed Limit of Stateless Full Nodes
==============

A transaction in the stateless full node design needs a merkle proof. The merkle proof's size, for a binary merkle tree with a cryptographic hash of 32 bytes, with 100 billion accounts in the system: 32*2*log2(100 billion) = 32*2*36.5 = 2336 bytes
On average we need about 3 merkle proofs per tx.
The transaction itself is around 400 bytes, so all together it is around 7.5 kilobytes per tx being processed.

Modern fiber optic cables can send 100 terabytes per second. So the bandwidth limit is 10 billion txs per second. Meaning every person on the planet could make a tx every second.

Bandwidth is not the bottleneck of blockchains, and so having larger blocks and needing more bandwidth is not an issue.

Comparison of consensus state full nodes
============

A modern solid state hard drive is around 3x slower for random read/writes in comparison to sequential, if you are reading/writing the optimal page size of 4 kilobytes.

If we are using a binary merkle tree, and we pack it optimally for 4 kilobytes, then that means each node of the database tree will have ~64 children. If there are 100 billion accounts in the tree, then reading/writing will mean accessing log64(100 billion), or around 6 pages.
On average we need to read/write 3 locations per tx. (3 location) * (6 pages) * (4 kilobytes per page) = 72 kilobytes per tx.
And since it is random read/writes, it is 3x slower than sequential. So this takes as much time as sequentially writing 216 kilobytes.
The full node with memory needs to read everything, process the block, and then write the new version of everything. It reads and writs in different steps, giving another factor of 2 of slowness. So it takes as much time as 432 kilobytes sequentially.

A stateless full node needs about 3 merkle proofs per tx. The size of the proof is log2(100 billion). So around 7.5 kilobytes per tx.

432/7.5 is about 60. So a stateless full node that stores all of the consensus state, is around 60 more efficient than a full node that stores the consensus state. Where efficiency is in terms of total time spent reading/writing to hard drives per tx.

Stateless full nodes that don't store the blocks can be far cheaper than archival nodes. Non-archival stateless full nodes never need to read or write to a hard drive.

Comparison of archival full nodes
============

Stateless full node blockchains, their txs are about 7.5 kilobytes each. In comparison to around 400 bytes for blockchains that store the consensus state. That means the blocks are around 40x bigger for stateless full nodes.

If we are storing 2 months of blocks, and the average person makes 2 txs per day, and there are 10 billion users, that means we are storing around 1 trillion txs.

So stateful full nodes, the archival nodes would need around 400 terabytes of hard drive space.
A blockchain with stateless full nodes, it would need 7500 terabytes of hard drive space per archival node.

The cost of archival nodes is significantly higher in the stateless design, but it is expected that archival nodes will be a minority of the network, so the total cost of a network using the stateless full node design can be lower.

Comparison of mining pools
============

In the stateless full node design, a mining pool can be a stateless full node.
But in the stateful full node design, a mining pool needs to be a consensus state full node, which is far more expensive.

The cost of verifying blocks without storing the blocks.

If we keep adding more users to the blockchain, then the total size of the consensus state will eventually get very large. For stateful full nodes, they need to have access to all of this consensus state to be able to verify blocks.
If there are 100 billion accounts, and each account has 64 bytes of merkle proof data, and 32 bytes of address, and a handful of other bytes. that is around 100 bytes per account. So we need 10 trillion bytes of consensus space, or around 10 terabytes. So a 10 terabyte SSD hard drive is mandatory, just to verify the blocks, they cost well over $1000 currently.
For speed reasons, it may be necessary to run multiple of these hard drives in RAID, which makes the cost even higher.

Stateless full nodes for mining in comparison need around 1 gigabyte of RAM to be able to verify the blocks, which costs around $10.

Comparison of consensus state full nodes
================

In the stateless full node strategy, a consensus state full node can store whatever fraction of the consensus state they are interested in. So this is a kind of sharding. We can divide the consensus state onto different nodes, and the memory requirement for any individual node can be limited.

If we don't use the stateless full node strategy, then every cosnensus state full node needs to store the entire consensus state, because that is the only way to verify the blocks. For a global blockchain, that means a 10 terabyte hard drive.

Verifying Txs in Parallel in stateless full nodes
============

The in-ram database of the consensus state that is used to verify the txs. We can have checkpoints at various points between the txs, and have a different version of the in-ram consensus state for each checkpoint.
This way, the regions seperated by these checkpoints, they can be processed in parallel.
After processing a region, the full node needs to check that the final consensus state for that region, it matches the checkpoint data at the end of that region.
Amoveo does not currently verify txs in parallel, but we do have plans to add support for this.

Verifying Smart Contracts in Parallel in stateless full nodes
==========

Verifying smart contracts in parallel is very similar to txs in parallel.
We need to split the smart contract execution onto more than one tx.
Between these txs, we need a checkpoint of the smart contract's state at that point in the execution.
When processing the block, after each chunk of the smart contract, the full node needs to verify that the smart contract's state matches the checkpoint.

Other tricks Amoveo uses so Smart Contracts are scalable
==========

It has been said that stateless full nodes will only make Ethereum 3x more scalable, but this design will allow Amoveo to scale far more than that. Amoveo's smart contract system is totally optimized for this design.

Amoveo's smart contract system is based on fraud proofs. The majority of smart contracts do not ever need to go on-chain, because if the participants agree on the outcome, they can settle for the correct result without needing the blockchain to enforce it. They are incentivized to resolve their contract without the blockchain, because using the blockchain to enforce the result is more costly to them. This significantly reduces CPU costs relative to other smart contract blockchains, like Ethereum.

Amoveo's smart contract system uses Merklized abstract syntax trees. That means that only the part of the contract that actually gets executed ever needs to go on-chain. This significantly reduces the CPU costs in comparison to other smart contract blockchains, like Ethereum.

Amoveo's smart contract transactions are always parallelizable. It isn't possible to cause them to become a single-threaded task, like can happen in other smart contract blockchains, like Ethereum or any blockchain using the EVM. This significantly reduces the CPU cost of Amoveo's smart contract system.


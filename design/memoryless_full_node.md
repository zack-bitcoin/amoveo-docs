Memoryless Full Node
===================

Consensus state is the information that a blockchain maintains in a decentralized trustless way. For example, your account balance is part of the consensus state. No one can manipulate your balance, even if they are willing to spend a lot of money to do it.

The memoryless full node strategy is where full nodes and mining pools do not need to store a copy of the consensus state in order to verify that blocks are valid.

Amoveo has been designed to use memoryless full nodes since it launched in March 2018.

Verifying a Block without a hard drive
============

The process of block verification in memoryless full nodes.
The full node verifies the PoW on the headers.
Once a header is valid, then the full node downloads the block for that header.
The full node scans the merkle proofs from the block, it hashes the chunks of the merkle proof to verify that each merkle proof is valid, and builds up a small in-ram database of the part of consensus state needed to verify the txs in this block.
Finally, the full node can check that the txs in the block are valid. 

Verifying Blocks in Parallel
=============

One advantage of the memoryless full node strategy is that the full node can verify blocks in any order. Since the full node isn't maintaining any database to verify the block, it can know a block is valid without remembering anything about the previous blocks.
So we can verify blocks in reverse order, or in parallel.

Amoveo currently verifies blocks in parallel by default, and there is a configuration option to verify blocks in reverse order.

The Negative Aspects
===========

The big drawback of this strategy is that every block needs to include crpytographic proofs of all the consensus state needed for processing that block. For example, if you want to make a tx to spend some of your money, the block containing this tx needs to include a cryptographic proof of your balance. That way the full nodes can be sure that you have sufficient money to afford to spend the amount that you want to spend.

In the future we might find more efficient ways to cryptographically prove consensus state to the full nodes, but our current strategy is to use Merkle proofs. These Merkle proofs are large, they make a typical transaction about ten times larger than it would have been. So each transaction takes up 10x more space in a block than it would in Bitcoin. This means a 1 megabyte block using the memoryless full node strategy can hold 10x fewer transaction than it could have with normal Bitcoin.

Big Blocks Can Be Fast, if sequential
=============

Memoryless full node blocks are bigger, but that isn't actually an issue.
Bandwidth is very cheap today, and it is only getting cheaper.
With memoryless full nodes, the blocks are only read through a single time. You don't need to store the blocks in RAM or manipulate the data. You just stream-download it right to your hard drive.

Writing to hard drives sequentially can be increadibly fast today, even consumer products are around 1 gigabyte per second.

No Random Harddrive reads/writes
=============

In most blockchains the bottleneck of transaction processing is in reading and writing to the hard drive. This is because as you process a block, you need to read and write little bits of data randomly scattered all over your hard drive. Reading and writing bits of data all over like this, it is around 3x slower than sequentially reading/writing, even if you use an optimal page size.
For example, in bitcoin when each transaction is processed, it consumes some unspent outputs, and creates some unspent outputs. So to process this transaction, the full node needs to search in its database for those outputs that were spent, and remove them. And the full node needs to insert the new unspent outputs into its database. Reading and writing these unspent outputs to maintain the database is very slow.
Bitcoin full nodes can buy faster hard drives to maintain the database, but eventually they hit the limit of hard drive technology, and this is the bottleneck for how quickly Bitcoin can process transactions.

Calculating the Speed Limit of Memoryless Full Nodes
==============

The limit is that hard drives can only have 1 gigabyte written to them per second.

A transaction in the memoryless full node design needs a merkle proof. The merkle proof's size, for a binary merkle tree with a cryptographic hash of 32 bytes, with 100 billion accounts in the system: 32*2*log2(100 billion) = 32*2*36.5 = 2336 bytes
On average we need about 3 merkle proofs per tx.
The transaction itself is around 400 bytes, so all together it is around 7.5 kilobytes per tx being processed.
1 gigabyte per second, and 7.5 kilobytes per tx, means we can do about 133000 txs per second. That is around 11.5 billion txs per day, meaning every human on earth could do around 1 tx per day.

Calculating the speed of Full Nodes with Memory
============

How slow are these random read/writes vs sequential?
A modern solid state hard drive is around 3x slower for random read/writes in comparison to sequential, if you are reading/writing the optimal page size of 4 kilobytes.

If we are using a binary merkle tree, and we pack it optimally for 4 kilobytes, then that means each node of the database tree will have ~64 children. If there are 100 billion accounts in the tree, then reading/writing will mean accessing log64(100 billion), or around 6 pages.
On average we need to read/write 3 locations per tx. (3 location) * (6 pages) * (4 kilobytes per page) = 72 kilobytes per tx.
And since it is random read/writes, it is 3x slower than sequential. So this takes as much time as sequentially writing 216 kilobytes.

216/7.5 is about 30. So a memoryless full node is around 30 times faster than a full node with memory.
So if there are around 8 billion humans, then the average person could only make around 1 tx per month.

Calculating size limit of full node with memory
============

If we keep adding more users to the blockchain, then the total size of the consensus state will eventually get very large. For full nodes with memory, they need to have access to all of this consensus state to be able to verify blocks.
If there are 100 billion accounts, and each account has 64 bytes of merkle proof data, and 32 bytes of address, and a handful of other bytes. that is around 100 bytes per account. So we need 10 trillion bytes of consensus space, or around 10 terabytes. So a 10 terabyte SSD hard drive is mandatory, just to verify the blocks, they cost well over $1000 currently.

Memoryless full nodes in comparison need around 1 gigabyte of RAM to be able to verify the blocks, which costs around $10.

Verifying Txs in Parallel
============

The in-ram database of the consensus state that is used to verify the txs. We can have checkpoints at various points between the txs, and have a different version of the in-ram consensus state for each checkpoint.
This way, the regions seperated by these checkpoints, they can be processed in parallel.
After processing a region, the full node needs to check that the final consensus state for that region, it matches the checkpoint data at the end of that region.
Amoveo does not currently verify txs in parallel, but we do have plans to add support for this.

Verifying Smart Contracts in Parallel
==========

Verifying smart contracts in parallel is very similar to txs in parallel.
We need to split the smart contract execution onto more than one tx.
Between these txs, we need a checkpoint of the smart contract's state at that point in the execution.
When processing the block, after each chunk of the smart contract, the full node needs to verify that the smart contract's state matches the checkpoint.


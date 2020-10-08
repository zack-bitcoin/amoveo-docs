Trees
=======

Consensus state is the data that every full node of the blockchain keeps an identical copy of.
The consensus state of a blockchain is the current blockchain protocol after syncing your node with the network. 

Amoveo stores it's consensus state in merkle trees.

There are 8 [Merkle trees](/basics/merkle.md).

* accounts
* oracles
* matched
* unmatched
* governance
* contracts
* sub_accounts
* markets
* trades



# accounts

This tree stores accounts by integer id. Each account has a merkel root written in it. It is for the oracle bets tree.
[more about accounts](accounts.md)

# oracles

These are the oracles that exist right now. They are stored by integer oracle id. Oracles never reuse the same id.
The hash of the text of the question is stored.
These are the results of oracles that have existed. They are stored by id.
This data is available to the VM.
The result is stored in 1 byte. Either it is 0 for false, 1 for true, or 2 if the questions was bad, or a 4 if the question hasn't been answered yet.
[read more about oracles here](oracle.md)

# matched

Every oracle has an order book. The order book is a linked list of orders. Each order has an amount, and the id of the owner.

the `matched` tree stores orders that have matched pairs. these are active bets inside the oracle.

# unmatched

`unmatched` is for those orders which are not yet matched. they are in an order book.

# governance

This tree stores by atom name. It contains many variables that define the consensus protocol. The oracles can be used to update these variables, to optimize Amoveo for changing conditions.

# contracts

This tree stores smart contracts. each smart contract has a source currency, and 2 or more subcurrencies.
When the contract ends, a virtual machine runs the smart contract along with evidence to decide how to divide the source value between the different subcurrencies.

# sub_accounts

the sub_accounts tree is used to remember how much subcurrency each person owns in each contract.

# markets

the markets tree is used for storing constant product automatic market makers that exist on-chain.
Anyone can make markets between any pair of currencies. Liquidity providers earn trading fees.

# trades

This merkle tree is for storing trade IDs from when users swap subcurrency together. That way each swap-offer can be published to the blockchain at most once.



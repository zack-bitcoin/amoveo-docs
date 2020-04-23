Sortition Chains
=========

This is a scaling plan, similar to sharding or side-chains.

Related documents:

[sortition chain theory.](./sortition_chains_theory.md)

[sortition chain attacks analyzed](./sortition_chains_defense.md)

[sortition chain implementation details.](./sortition_chains_implementation.md)

[sortition chain random number generator.](./sortition_chains_random.md)

[sortition history and acknowledgements](./sortition_chain_history.md)


What is a Sortition Chain?
=========

Sortition chains are a lottery-type sidechain.

A sortition chain is a kind of lottery.
The lottery tickets are spendable and divisible.
The database of lottery tickets is off-chain.
Eventually we draw the random number to determine who won the lottery.
The winner publishes the slice of the lottery ticket database that proves that they won.
No matter how many people are owning lottery tickets, the proof of who won can stay small.

Sortition chains are a tool that combine features of probabilistic payments with state channels. 

If you own $10 in a sortitoin chain that has $1000 total locked in it, that means you have a 1% chance to win $1000, and a 99% chance to win $0.

A person usually doesn't want to hold a contract that only has a 2% chance of having value. That is a lot of risk. But as long as there are other people willing to buy the contract at a good price, this works.

You can create sortition chains inside of existing sortition chains, allowing for exponential scalability.

Sortition Chain Operators
======

Each sortition chain has a operator. Updating the state of the sortition chain requires the operator to sign the new state root.

The commiter signs over the merkle root of the sortition ownership tree. They record this signed root on-chain in a sortition-block-tx.

Embedding smart contracts
========

The sortition merkle tree can divide up ownership according to probabilistic value space, as well as according to the outcome of turing complete contracts.

Additionally, when you sign a waiver to give up control of some of your value, this waiver can have an embedded smart contract. So the waiver is only valid if the smart contract returns "true". Similar to unlocking a bitcoin UTXO.



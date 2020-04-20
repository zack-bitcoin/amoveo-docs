Smart Contracts as Derivatives
==============


Why Smart Contracts Should Be Immutible
==============

* Scalability

In order to be scalable, we need to get rid of all shared mutible state. Shared mutible state needs to be synchronized, and the synchronization cost increases as the number of participants increases. It doesn't scale.

* Instant Finality

If the entire network needs to synchronize some data, that means we need to wait for a on-chain merkle root commitment. For example, if we want to add someone new to our smart contract, that would requiring waiting for an on-chain commitment, and possibly confirmations as well.

So, we can either share state, or allow mutability.
A smart contract needs to be shared between its participants, and a copy could eventually end up shared on-chain. So, Amoveo smart contracts need to be immutible.

We want smart contracts only outside the consensus state
==============

in the context of blockchains, "stateless" means that a full node should not need to store any state about this thing in order to verify blocks involving it.
So if we want "stateless" smart contracts, that means we do not store any information about the smart contract inside the consensus state space. The contract could be written in a block once, and that block can be stored in a slow hard drive. Because a full node does not need to look up that old contract in order to process any new contracts.

If we want to scale better than O(# of contracts), then it is necessary that all contracts are stateless.

Derivatives are Immutable-stateless smart contracts
==============

A _derivative_ is a contract where N people lock money into it. And eventually the contracts redistributes the money to the N participants based on the rules programmed into it. It has no internal state that changes over time. A derivative is a stateless smart contract, because it doesn't get stored in the on-chain consensus state for any amount of time. It is only published on-chain once to determine how the money it contains should be redistributed to the N participants.

Immutable Stateless Smart contracts are Derivatives
==============

If a smart contract is immutible, then we know there must be a number N for how many people are involved with the smart contract, and that it is impossible for new people to join.
If it was possible for new people to join, then the list of people who are involved would be state that has mutated, so it would not be a immutable contract.

If a smart contract is stateless, then we know it only gets published on-chain once, and distributes all the money that it contains. Otherwise it would depend on some on-chain state related to it that needs to be maintained over time.

The combination of those 2 properties:
1) a fixed number of participants N
2) only getting published on-chain once to get settled

This is a full definition of a "derivative".

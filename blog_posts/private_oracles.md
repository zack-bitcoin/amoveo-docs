Private Oracles
============

An oracle is a blockchain tool for importing real world data onto the blockchain.
So we can use that data to enforce the outcome of smart contracts.

For example, if you want to bet on a football game, there needs to be some kind of oracle so that the blockchain can know who won the game. [You can learn about Amoveo's oracle design here](oracle.md)

A private oracle is one where no one looking at the transactions on the blockchain can tell which of the oracles is being used to enforce your contract. It is necessary that the oracle is still private, even if your counter party does not cooperate in resolving the contract. Otherwise privacy is trivial.

A stronger version of privacy is called "deniability".

A deniable oracles allows making bets on any publicly available data, and no one can prove what it is that you are betting on. Even if your counterparty wants to reveal what you had bet on, they cannot. Similarly, you cannot prove to anyone what it was that your contract had bet on.

Why private oracles matter for smart contracts.
============

The most valuable smart contracts are financial contracts.

Any blockchain-enforced financial contract can be expressed as a rule as for how the funds in the contract should be distributed between it's owners.

We can put any such rule into a question asked of an oracle.
So, if we have private oracles, then we have a private version of all the financial contracts that are possible in blockchains.

Deniable encryption
===============

When we create an encrypted version of a value, then 3rd party observers can't tell what is in the text of the message. But, with standard encryption, it is possible for the recipient of the message to decrypt it and show it to third parties.

Often times, in business, we want our peers to protect our secrets for us. That is why we create legal non-disclosure agreements for example.

Deniable encryption is like the cryptographic version of a non-disclosure agreement. It gives you the ability to share a secret with a peer, and your peer cannot share this secret with anyone else.

For example, imagine you are selling Bibles in North Korea. If you send a deniable message to someone, confessing to selling bibles, it is impossible for them to prove to anyone else that you had sent this message.
Anyone can make a fake version of the message, and government officials have no way to know the difference between fake and real messages.

There are many different questions that have been asked to the oracle.
When you use a deniable oracle for your smart contract, that means that it isn't possible to prove to anyone which of the questions is the one that is used to determine the outcome of the contract.

What is a private oracle?
===============

In order for an oracle to be secure, there needs to at least be the potential that the text of the oracle could end up on-chain. So "private oracle" does not mean that the text is private.

In order for you to know how much money you can potentially gain from a contract, it is necessarily possible that you can prove to others how much money you could potentially gain. So "private oracle" does not mean that the amount of money in the smart contract is deniable.

Private oracles can disconnect the text of the oracle question from the contract that is enforced by that oracle. The disconnect between the oracle and the contract can be made deniable.
This way, anyone looking at the oracle text, they do not know how much if any money has been wagered on this oracle. And anyone looking at your contract, they have no idea which oracle is being bet on with this contract.

The rest of this document will be about the technologies that can be used to build a deniable oracle.

Hash functions
============

A hash function is a function that takes some data as an input, and the output is a fixed number of bytes. SHA256 for example is the hash function in bitcoin. It produces 256-bits of data as the output.

Hash functions are deterministic. That means if you give it the same input more than once, it produces idential output.

Hash functions are one-way functions. That means that given the output of a hash function, it is not possible to guess what the input was.

Important for deniability:
Given 256-bits of random data Y, it is impossible to prove that this is not the output of SHA256 for some data X that you know. You can't prove that you do not know something.

This enables us to build cryptographic databases where it is impossible to prove the existence or non-existence of certain elements.

You need to be careful about how you generate Y.
If a 3rd party can use a deterministic process to generate it, then deniability is broken.

Each participant generates lots of unsigned, unhashed randomness. Then it is XOR'd together.
Do use any seed to generate more bits.

The mechanism
==============

Alice wants to privately pay Bob to do a job who's result is publicly verifiable.

Alice generates text explaining under what conditions Bob should get paid. She puts an oracle on-chain, containing the hash of this text. The text is only revealed if it needs to be for enforcement.

Alice and bob build up a merkle tree.
This merkle tree database stays off-chain, but it's root is written in the smart contract, and merkle proofs from this tree can be provided to the contract as evidence.
The merkle tree contains all the oracles that we want to mix with more than once. The total number of oracles contained in the merkle tree should be a non-deterministic random number.
Along with each oracle stored in the merkle tree, it contains a bit, to say whether in this case Alice is betting on True, or False.
The merkle tree contains many dead ends.
The number of dead ends needs to be a minimum of #oracles we are mixing with, to avoid too much privacy leakage. It shouldn't be an exact number, it should be non-deterministic random.
These dead ends are true randomness, not generatable from any known deterministic process.

Along with each oracle in the merkle tree, we store a priority nonce.
For the oracle we are actually betting on, it should have the highest nonce of all.
So if there is a dispute that keeps escalating, eventually this is the oracle that enforces the outcome.

So the way the smart contract works, We are betting on an oracle, but from the block processor's perspective, they aren't sure which oracle.
Alice could report that they are using oracle with nonce #6, but later Bob reports that there is a different oracle with nonce #9 that they are actually using.
Eventually, if no one makes a report with a higher nonce for a long enough period of time, then we end up using the oracle that got reported with the highest nonce.

Making a report costs something. In the end, whoever wins the contract, their reporting costs get recuperated, and the loser pays for this too.

Why is this deniable?
============

At first glance, it seems like it could be deniable. If Alice or Bob wanted to prove that a certain oracle in the merkle tree had the very highest nonce, they could not.

But to be 100% deniable, we need to leak 0 bits of information about which oracle was used to secure the contract.
Even if one of the participants is trying to leak this information.

There are 2 situations that need to be indistinguishable:
1) Alice used a private oracle to bribe Bob, and now Alice wants to reveal that Bob accepted the bribe.
2) Alice lost a private bet with Bob, and Alice is a sore loser. She wants to frame Bob for having accepted a bribe. The bribe contract is different from the private bet contract.

If a the block processors have no way of knowing whether we are in situation (1) or (2), then the oracle is deniable.

Looking at case (1).
Alice could reveal everything she knows. The entire merkle tree.
But she cannot prove that she has revealed everything.
It appears that the highest nonce is the bribe contract.

Looking at case (2).
Alice could reveal a bunch of the merkle tree, but claim that some of the oracle entries are actually dead-ends. So it looks like the highest nonce is the bribe contract.

In either case, Alice can make a report to the smart contract, to activate a non-highest oracle. She would activate an oracle that says Alice wins, to force Bob to respond.
It is important that Bob responds correctly. Bob needs to use a strategy that works for case (1) and (2). If Bob changes his strategy for one of the cases, then it is not deniable.

Whatever nonce alice had revealed to the contract, Bob should reveal the lowest nonced oracle that both has a nonce higher than Alices oracle, and this one looks like it could result in Bob winning.

Efficiency/privacy trade-off
==============

Instead of revealing the lowest nonced oracle that is higher than Alices oracle and results in Bob winning, he could instead draw a random number X between 1 and 4, and report the Xth lowest oracle.
This would make things 2x times faster.
But it comes with the drawback that Alice could report the oracle just before the final one, so that you are forced to report the final oracle.

If we are in case (1), then there is a 100% chance you will select to reveal that oracle.
If we are in case (2), then there is only a 25% chance that you would have selected that oracle to reveal.

So, if you are willing to leak N bits about which oracle you are using, then in the worst case, the contract is 2^N fold faster.

If instead of randomly drawing a number 1-4, we could instead do a poisson distribution, and this makes it 2x more efficient. Because sometimes we can skip over big gaps.
So, leaking N bits makes it 2^(N+1) faster.

A problem is that all the info leaking is happening near the end of the list of oracles. If we leak more info near the beginning, then we can speed things up, without making the protocol less private.

We can choose bigger gaps for lower nonces, and smaller gaps for higher nonces.
So for example, lets say the highest nonce is 1000. if Alice reveals the oracle for nonce 2, we could skip ahead to nonce 200.
but if Alice reveals the oracle for nonce 900, then we should only continue to like 920.
And if Alice reveals for nonce 980 or higher, we should only increase by the minimum.
We need to mix a little randomness into all our strategies, so that a phase change in our strategy between different nonces doesn't leak too much info about which nonce is highest.

How can we be sure these compromises are reasonable?
============

Trying to show that cases (1) and (2) are reasonably indistinguishable, it is ultimately a statistical problem. We should use tools from statistics to be sure that Bob's strategy isn't measurably different between (1) and (2).


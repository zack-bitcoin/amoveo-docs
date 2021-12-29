Private Oracles
============

An oracle is a blockchain tool for importing real world data onto the blockchain. So we can use that data to enforce the outcome of smart contracts.

For example, if you want to bet on a football game, there needs to be some kind of oracle so that the blockchain can know who won the game. [You can learn about Amoveo's oracle design here](oracle.md)

Why private oracles matter for smart contracts.
============

The most valuable smart contracts are financial contracts.

Any blockchain-enforced financial contract can be expressed as a rule as for how the funds in the contract should be distributed between it's owners.
We can put any such rule into a question asked of an oracle.
So, if we have private oracles, then we have a private version of all the financial contracts that are possible in blockchains.

Why private oracles are important for business adoption of smart contracts.
===========

Businesses have private information that they need to guard in order to stay competitive.
If blockchain smart contracts are going to be used for business, then we need to protect all this information by default. It needs to be easy to use the blockchain tools, without accidentally revealing important secrets.

For example, you don't want to reveal information about the products and services your business is buying, or how much you are paying for these products and services.

Why privacy coins or mixers are not enough.
=================

Mixing services and privacy coins like zcash or monero can hide the ownership of funds.
But lets say you used privately owned funds to pay for something that is specifically related to your business. Like, you are paying for a new logo to be made.
If the contract talks about a logo for your business, and everyone can see how much money is locked up in the contract and for how long, this is revealing a lot of information about your business.

Mixing the coins is only one aspect of privacy.

Deniable encryption
===============

When we create an encrypted version of a value, then 3rd party observers can't tell what is in the text of the message. But, with standard encryption, it is possible for the recipient of the message to decrypt it and show it to third parties.

Often times, in business, we want our peers to protect our secrets for us. That is why we create legal non-disclosure agreements for example.

Deniable encryption is like the cryptographic version of a non-disclosure agreement. It gives you the ability to share a secret with a peer, and your peer cannot share this secret with anyone else.

For example, imagine you are selling Bibles in North Korea. If you send a deniable message to someone, confessing to selling bibles, it is impossible for them to prove to anyone else that you had sent this message.
Anyone can make a fake version of the message, and government officials have no way to know the difference between fake and real messages.


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
Given 256-bits of random data, it is impossible to prove that this is not the output of SHA256 for some data that you know. You can't prove that you do not know something.

Verkle trees with SNARKS
===========

Verkle trees are a kind of cryptographic database, they are similar to merkle trees, but they are based on alternatives to hash functions.
The important property of verkle trees is that we can snarkify a verkle proof.

Using the tree as a key-value store, we can prove that an value exists in the key-value store, without needing to reveal which key we had used to look up that value.

If we have many binary oracles, then each oracle is in one of 4 states: unresolved, bad-question, true, false
So, we can build up a verkle tree where the keys are the oracle ids, and the values are one of those 4 possible values.

A SNARK of a verkle proof for this database gives privacy. We reveal the result of the oracle to enforce the contract, but we do not reveal the oracle id, so 3rd party observers don't know which oracle question we are using.

The mechanism
==============

Alice wants to privately pay Bob to do a job who's result is publicly verifiable.

Alice generates text explaining under what conditions Bob should get paid. She puts an oracle on-chain, containing the hash of this text. The text is only revealed if it needs to be for enforcement.

Alice and Bob make a list of all the oracles that they want to mix with. So 3rd party observes can't know which oracle in this list is being used.
Alice and Bob generate a random number R between 1 and 2000.
Alice and Bob are making a verkle tree database.
For every integer between 0 and R exclusive, alice and bob store all of the oracle ids, along with that nonce. The nonce and oracle id are stored in different slots of the vector commitment, that way a zkSNARK can reveal the nonce without revealing the oracle id.
For nonce R they only store the one oracle that they are betting on.

For values between R and 2000, Alice and Bob need to insert lots of random data into the verkle tree. Otherwise the total size of the verkle tree could leak the secret value R, which would break security.

After the oracle resolves, it becomes possible to create the zkSNARK to make the contract settle.

The zkSNARK should have a verkle proof inside, to look up the oracle id and nonce. The oracle id stays private, and the nonce is revealed.
The oracle id inside the snark is used as part of a second verkle proof. This time it is looking up the result of the oracle from on-chain.
The final result of the oracle is revealed, to enforce the contract.

If Alice makes a zkSNARK that uses nonce N, then it is possible for Bob to make another zkSNARK for a nonce higher than N, and the contract will prefer whichever zkSNARK has a higher nonce.

It is impossible for Alice or Bob to prove which contract has the highest possible nonce, so they cant prove that the oracle referenced during settlement is the oracle they had intended to bet on, or if it is some other oracle that just happened to resolve the same way. So it is deniable.

Enforcement is secure. Alice or Bob can always always escalate to the highest possible nonce, so the correct oracle is used for enforcement.

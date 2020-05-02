Lightning Mempool Attack
==============

This attack was discovered against bitcoin LN.

Say we have a 2 step lightning path Alice -> Bob -> Charlie
With channel AB for Alice and Bob, and channel BC for bob and charlie.
We want to atomically connect an update between AB and BC, so that either the payment goes the entire path, or else it doesn't happen at all. This way Alice can pay Charlie.

The attack involves how bitcoin's mempool for zeroth confirmation txs works. If you try to publish a tx, mining pools will only accept it if it doesn't conflict with any tx already in the mempool. This helps to prevent double spending of zeroth confirmation txs.

So if Charlie publish a very low fee tx, revealing the secret in order to close BC in the state of the payment having executed, this tx could sit in the mempool for a while. And as long as it is in the mempool, it isn't possible to close BC in any other conflicting state.

But since it is only in mining pools mempools, and not written on the blockchain, Bob might not be able to find out the secret to close AB in the state of the payment having executed.

So this is a way to disconnect AB and BC, so the payment only goes half-way. Alice and Charlie can steal money from Bob.

In the context of sortition chains
===============

We already decided that if cooperation isn't happening with an atomic update, that the secret needs to get put on-chain with a proof-of-existence tx, and it needs to be put on-chain before an expiration set inside the contract.
So if someone attempts this attack, you just need to wait until the expiration.
At that point the low-fee tx becomes invalid, because it wasn't included soon enough
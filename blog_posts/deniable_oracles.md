Deniable Oracles
============

Deniable oracles is the idea of being able to make bets on any publicly available data, and no one can tell what you are betting on. Even if your counterparty wants to reveal what you had bet on, they cannot. Similarly, you cannot prove to anyone what it was that your contract had bet on.

Still, you have cryptoeconomic guarantees that your contract will be correctly enforced.

Oracle Basics
===========

Oracle Privacy
===========

Deniability in zkSNARKS
===========

The general strategy for making SNARKS deniable was explained to me by Justin Drake like this:

```
To produce a SNARK for a statement s targeted at a single party with pubkey pk it suffices to make a SNARK for the statement "s is true or I know a secret key that corresponds to pk".
```

How this looks in the context of a deniable oracle.
Both counterparties in the contract have secret keys that they can use to forfeit the contract.
Using this secret key, you can make the SNARK say that you lost, and you can include any data in place of the verkle proof. Including other verkle proofs of other parts of the database.

So, if a third party is looking at how the SNARK got resolved on-chain, and one of the counterparty's reveals all their secret values of the snark's witness to that third party, the third party still can't tell if the verkle proof is the actual data being used to resolve the contract, or if someone who knew the loser's secret key had embedded that data in the snark's witness.




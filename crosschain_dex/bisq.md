Bisq
==============

Bisq is a decentralized exchange based on 2-of-2 multisig addresses.

So the process is like this:

* Alice wants to spend Bitcoin to buy USD fiat currency.
* Bob wants to spend USD to buy Bitcoin from Alice.
* Alice locks the Bitcoin she wants to sell into a 2-of-2 multisig address with Bob, and a safety deposit, and Bob locks in some of his own Bitcoin as a security deposit.
* Bob sends the fiat currency to Alice.
* Alice and Bob send the BTC from the 2-of-2 multisig address to Bob, and Alice gets her safety deposit back.

The problem is that the 2-of-2 multisig is not secure. Bob could refuse to send the fiat to Alice, and refuse to let Alice withdraw from the 2-of-2 unless she gives some of the money to Bob.
Alice could refuse to unlock from the 2-of-2 after receiving her fiat currency unless Bob agrees to give some extra money to her.

If one of either Alice or Bob has more need to access their bitcoin sooner, they can end up needing to pay a premium to the other to withdraw their Bitcoin sooner.


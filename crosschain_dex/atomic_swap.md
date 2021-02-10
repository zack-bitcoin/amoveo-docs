Atomic Swap DEX
==============

An atomic swap is an application of payment channel technology. It is enforced using hashlocking.

[The bitcoin wiki explains how it works and the history of it's invention](https://en.bitcoin.it/wiki/Atomic_swap)

A hash function can be used to commit to a secret. If you have a secret, you can calculate the commitment like this: hash(commitment).

Blockchains can support locked payments that only get activated if you know the secret that has been committed to.

Hashlocking is when there are 2 or more payments each locked to the same commitment. So when that single secret gets revealed, it atomically causes the different payments to become unlocked.

Hashlocking has advantages:

* It is very cheap. The overhead cost is effectively zero.
* It is completely trustless. There is no one who can can cancel one of the two payments while letting the other occur.
* It is very fast, the entire process can occur in less than 10 blocks of the slower blockchain.

Hashlocking has disadvantages:

* It requires that both blockchains support locked payments using the same hash function.
* It requires specialized user interfaces to be sure that the locked payments on each side are using the same crypto, and that the amount of time that the money is locked for on each side is compatible.
* It is vulnerable to the free option problem.
* It is interactive. The participants have to be online at the same time and send messages back and forth to each other.
* It is not commitable. You can post fake offers, and when people try to accept them, you can refuse to cooperate and the swap is canceled.

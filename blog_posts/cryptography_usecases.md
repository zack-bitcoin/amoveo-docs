Cryptography Usecases
=============

mimble wimble
========

https://scalingbitcoin.org/papers/mimblewimble.txt

benefits:

* collapse history into less state, so it is cheaper to run the blockchain full node.
* addresses, balances, and transactions are all potentially private.

encode balances as pedersen commitments with an elliptic curve group.

A transaction both removes money from one location in the database, and inserts it in another.
If you add up all the points from the places in the database that are being spent from, it adds up to the same thing as all the places in the database that are being inserted into.
So you can collapse all the transactions in a block into a single elliptic curve point. You can collapse all the blocks in all the history of the blockchain into a single elliptic curve point.

The big limitation in mimble wimble is the range proofs.
The worry is that someone with a balance of 100 would try spending 1100 to one address, and -1000 to another address at the same time, because they still add up to 100.
So we need a range proof, or some way to be sure that none of the numbers are negative.

One potential way to use mimble wimble is to store decrypted numbers along with the elliptic curve points. This way we can verify that none of the numbers are negative.
This compromise destroys the privacy aspects of mimble wimble, but potentially preserves the scalability.

Cryptonote
==========

Used by the Monero cryptocurrency since 2017.

https://eprint.iacr.org/2015/1098.pdf

Benefits
* privacy in account balances
* privacy in the sender of transactions
* privacy in the receiver of transactions.


stealth addresses

With cryptonote, you have a private-view-key which can be used to tell if an address is owned by you, and if it is, you can see the balance in that address. The private-spend-key is a different number.


ring signatures

When you spend money in a cryptonote system, you can choose several other addresses besides the one you are spending from.
From looking at your transaction, it is impossible to tell which of the several addresses sent this transaction.
So your money is being mixed every time you send it.


ring confidential transactions

This is for hiding the quantities of money in each address.


Zcash
=======

uses zero knowledge proofs called zk-SNARKs.

https://z.cash/technology/zksnarks/

Used by the Zcash blockchain.

In each transaction:
* the sender is private.
* the receiver is private.
* the amount sent is private.


Less Explored Opportunities
=============

privacy in auctions
* second-price auction where the prices of all other bids are private, and all participants besides the winner are private.
* harberger taxes where the self-imposed tax rate is private. 

privacy in smart contracts.
Can we add partially homomorphic tools to the virtual machines that run the smart contracts?
Would that give smart contract designers more control?


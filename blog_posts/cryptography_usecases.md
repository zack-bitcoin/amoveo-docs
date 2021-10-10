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
So you can collapse all the transactions in a block into a single elliptic curve point, and you are still able to verify more blocks. You can collapse all the blocks in all the history of the blockchain into a single elliptic curve point. This is an incredible scalability potential. It means we wouldn't need a database at all, we could just store that one number in ram and we are able to verify all the transactions and blocks that happen.

The big limitation in mimble wimble is the range proofs.
The worry is that someone with a balance of 100 would try spending 1100 to one address, and -1000 to another address at the same time, because they still add up to 100.
So we need a range proof, or some way to be sure that none of the numbers are negative.

One potential way to use mimble wimble is to store decrypted numbers along with the elliptic curve points. This way we can verify that none of the numbers are negative.
This compromise destroys the privacy aspects of mimble wimble, but could potentially preserves the scalability.

Vector Commitments
===========

https://ethresear.ch/t/open-problem-ideal-vector-commitment/7421

Vector commitments are seen to have the potential to allow for something that is more scalable than a merkle tree.

Merkle trees take O(log2( number of elements in the database )) many reads and writes to update a single element in a database.

Vector commitments have the potential to be much faster, which would let us process transactions faster.

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


General purpose zk-SNARKs.
============

People are working on zero knowledge proof systems that allow for general computation.

Vitalik is great at explaining.
https://vitalik.ca/general/2021/01/26/snarks.html


Less Explored Opportunities
=============

privacy in auctions
* second-price auction where the prices of all other bids are private, and all participants besides the winner are private.
* harberger taxes where the self-imposed tax rate is private.
* combinatorial multi-round auctions where the bids that don't win in each round are private.


privacy in smart contracts.
Updating a blockchain is difficult, because you need the majority of users of that blockchain to cooperate in updating.
Smart contracts are a way to add abilities to a blockchain without anyone needing to update.
It is like a computer program that lives inside the blockchain consensus state.
These computer programs are written in a smart contract language, and they are processed by a virtual machine.
Can we add partially homomorphic tools to the virtual machine that runs the smart contracts?
Would that give smart contract designers the ability to build partially homomorphic tools without needing to update the blockchain source code?

cryptography for scalability.


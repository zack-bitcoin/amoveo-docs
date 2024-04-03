Review of BitcoinPoW
=========================

There have been other consensus mechanisms that pay users to make transactions.

Why would we have a transaction fee, if you can get paid for making transactions?

We have transaction fees to prevent spam. Too much spam can make it more expensive to run a full node.
If we pay people to make transactions, that is like paying for spam.

Imagine it was the case that having miners pay to own lots of UTXO was a good way to mine.
In that case, it would be even better if the miner just did a proof of burn that cost an equal amount as creating the UTXO. This would have the same economic impact on the miner, but without filling the full nodes with spam.

Requiring miners to make proof of burn or security deposits is PoS. So, "BitcoinPoW" is actually a PoS system. 
Proof of burn via tx fees to make UTXO is a kind of security deposit in this situation, because you would only do a proof of burn if you have some expectation that the fees and rewards you earn will exceed the money that you had burned.

BitcoinPoW gives miners a finite number of hashes per UTXO that they control per second. So, adding more hashrate does not increase the likelyhood that a certain miner will find a block. This means BitcoinPoW is not a PoW mechanism, nor is it PoW/PoS hybrid. It is a 100% PoS system.

This PoS mechanism has all the same shortcomings as any of PoS mechanism, with one other major extra flaw. in BitcoinPoW we are paying miners to produce spam, and make the blockchain unnecessarily expensive for full nodes to stay in sync. BitcoinPoW is strictly worse than a PoS protocol where you use a normal burn mechanism to earn stake for mining.

Naming a PoS protocol "Bitcoin PoW" is very misleading.
For the majority of potential investors, this name is something that is going to prevent them from understanding what this protocol is doing. Or even worse, it could pollute our language to the point that it prevents people from understanding what "PoS" and "PoW" even mean.
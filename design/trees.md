Trees
=======

Consensus state is the data that every full node of the blockchain keeps an identical copy of.
The consensus state of a blockchain is the current blockchain protocol after syncing your node with the network. 

Amoveo stores it's consensus state in merkle trees.

There are 8 [Merkle trees](/basics/merkle.md).

* accounts
* oracles
* matched
* unmatched
* contracts
* sub_accounts
* markets
* trades
* receipts



# accounts

This tree stores accounts by integer id. Each account has a merkel root written in it. It is for the oracle bets tree.
[more about accounts](accounts.md)

# oracles

These are the oracles that exist right now. They are stored by integer oracle id. Oracles never reuse the same id.
The hash of the text of the question is stored.
These are the results of oracles that have existed. They are stored by id.
This data is available to the VM.
The result is stored in 1 byte. Either it is 0 for false, 1 for true, or 2 if the questions was bad, or a 4 if the question hasn't been answered yet.
[read more about oracles here](oracle.md)

# matched

Every oracle has an order book. The order book is a linked list of orders. Each order has an amount, and the id of the owner.

the `matched` tree stores orders that have matched pairs. these are active bets inside the oracle.

# unmatched

`unmatched` is for those orders which are not yet matched. they are in an order book.

# contracts

This tree stores smart contracts. each smart contract has a source currency used as collateral, and 2 or more subcurrencies.
When you create a contract, you include the hash of some software code.
When the contract ends, a virtual machine runs the smart contract code along with evidence to decide how to divide the source collateral between the different subcurrencies.

# sub_accounts

the sub_accounts tree is used to remember how much subcurrency each account owns in each subcurrency.

# markets

the markets tree is used for storing constant product automatic market makers that exist on-chain.
Anyone can make markets between any pair of currencies. Anyone can trade in these markets.
Anyone can deposit value into a market to be a liquidity provider. Liquidity providers earn trading fees.

# trades

This merkle tree is for storing trade IDs from when users use the off-chain order book to swap subcurrency together. That way each swap-offer can be published to the blockchain at most once, without requiring that swap_tx increment the account nonce.
This is for replay-attack prevention of swap_tx.
We use account nonces to prevent replay of other txs, similar to Ethereum.
In Bitcoin replay-attacks are prevented by the system of unspent/spent txids.
The benefit of not incrementing the account nonce when proessing swap_tx is that you can publish many swap_tx offers, and if some of the offers get accepted, it doesn't cause the other offers to become invalidated.
Another benefit is that if you have many swap offers all programmed to the same nonce, you can cancel them all by making any other tx that would cause your nonce to increase, and thereby invalidate all those swap_txs.
Alternatively, you can program your swap offers to use a nonce much higher than your current account nonce, in which case you are free to make many txs without invalidating your swap_tx_offers. In this case, if you do want to invalidate your swap_tx_offers, you would need to send the money from your account into a different account that you control, so that there is insufficient balance for anyone to match your swapt_tx_offers.

# receipts



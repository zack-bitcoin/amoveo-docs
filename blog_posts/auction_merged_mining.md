Auction Merged Mining
==============

Merged mining is a protocol with these properties:
1) One blockchain, called the "child", can inherit pow security from another, called the "parent".
2) Any coalition of less than 99% of miners of the parent blockchain have no capacity to censor or influence the child blockchain.
3) increasing the number of txs in the child blockchain should have zero impact on the computation or memory requirements of the miners of the parent blockchain.

You can think of merged mining as a way to scale PoW to secure more than one blockchain at the same time.
Merged mining is not a sidechain, it does not let coins move from one blockchain to another.

The goal of this paper is to propose the first merged mining protocol, and explain it's advantages over existing alternatives.

## History

One of the first projects to attempt something like merged mining was Namecoin.
Namecoin allowed bitcoin miners to also run namecoin full nodes, and have the priviledge to produce a namecoin block if they find a bitcoin block.
Since only a minority of bitcoin miners run the protocol, it does not achieve (2).
Since the miners need to run a namecoin node to profit, it does not achieve (3).

More recently, there has been work on [blind merged mining](https://www.truthcoin.info/blog/blind-merged-mining/)
Blind merged mining was motivated to try and have a merged mining protocol that could achieve (3), and it does.
But, in blind merged mining, the main chain miners can cheaply orphan side-chain blocks, and they can cheaply destroy the side-chain this way.
An attacker only needs to give small bribes to the miners to make this happen, because of tragedy of the commons.
Each miner has centralized gain of the bribe, and a distributed cost of partially destroying the side-chain.
So blind merged mining does not achieve (2).

## Auction Merged Mining Protocol Proposal

Every child chain block produced should require spending some parent chain coins.

The parent chain has an order book of people who want to buy child money. When these orders are matched, they have the privilege to forge the next child chain block.

On the child chain there is an order book of people who want to sell the child coins to get their bitcoin out. In order to make an order in this book, you need to schedule the limit price ahead, and wait a 100 block bonding period for the order to get into the order book.
That way the cost of a takeover where the attacker censors anyone else from accessing the child order book so he can have control of 100% block production, this attack is 100x more expensive to execute in comparison to the cost to prevent an attack.

Every child block swaps the same amount of parent money. Only the amount of child money being swapped changes to make the different prices in the order book.

The trade is executed when whoever is next in line to buy child currency sends their parent currency to whoever is next in line to buy parent currency. In this tx they should include the hash of the child-block.

The fork choice rule for the child chain is to apply a weight of 1 to every child block. This way purchasers of child money are incentivize to reveal the child block as quickly as possible. If their block is orphaned, they lose their bitcoin but do not get pain any child currency. This is similar to the game theory for why bitcoin miners are incentivized to reveal their blocks.

## Theory

A common misconception about PoW is that it is "wasteful".
This misconception about how PoW works has inspired a lot of really bad ideas about inheriting PoW security into a side chain. The community has been looking for something other than hashrate to destroy, to re-create the imaginary waste that they associate to PoW.

PoW is a game that is converting value from volatile electricity form into durable cryptocurrency form.
PoW is an auction in probability space where people pay in electricity to buy cryptocurrency.
The winner of each batch of the auction gets the privilege of building the next block, and earning any tx fees in that block.

The proper way to inherit PoW is with an auction that converts the parent currency into the child currency.
The winner of each batch of the auction should get the privilege of building the next block in the child blockchain.


## Price oracle

We can look at the price in the auction to get a idea of the current price of the child currency/parent currency.

## Implications for the future of currency

If merged mining works, then maybe pow is scalable, but currencies are not.
That would lead to a very diverse financial future.
A Cambrian explosion of currencies.
In that case, maybe a lot of the altcoins could end up successful.





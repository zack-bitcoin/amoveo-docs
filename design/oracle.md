Oracle Explanation
==============

Amoveo's oracle is based on how Ethereum recovered from the DAO hack.
If these 3 conditions are met, we can do a hard fork to prevent money from getting stolen:

* enough money is at risk to make the update worth it.
* it is easy to verify that money is getting stolen.
* the money is locked up long enough for us to do the hard fork.

The goal of the Amoveo oracle mechanism is to cause these 3 conditions to be met.
How this is done is by letting people bet at 50-50 odds on which oracle result they think is honest.
People have an incentive to make honest oracle reports because they can double their money.


In depth
==========

For questions that are in the process of being answered, we store a market in the on-chain state, in an order book.

In order to limit how big this order book can become, we use these rules:
The first order in the book has a minimum size determined by the Amoveo governance mechanism.
Every order after that, it's minimum size is twice as big as the minimum of the previous.

There are 3 possible outcomes for an oracle:
True, False, Bad Question

The order book only allows bets at a price of 50-50. So if you win your bet, you double your money. If you lose your bet, you lose your money.
This way, the order book only needs to contain one kind of open order at a time.
The result of the oracle is determined by which side of the order book has open orders.
If one side has open orders for a long enough period of time, then that side wins.
The length of the delay until the oracle can finalize is determined by a governance variable.

Locking the money in the order book for a delay gives us time to react if the oracle looks like it might lie. We can do a soft update to prevent it from lying. Mining pools have an incentive to participate in this soft update to stay on the valuable side of the fork.

[to see a short cryptoeconomic explanation for why this oracle will work, look at the bottom of the white paper](../white_paper.md)

Oracles are stored in one of the consensus state merkle trees. [read more about these trees here](trees.md)

[motivations that lead to this oracle design](oracle_motivations.md)

[Explaining the oracle from a different perspective](oracle_simple.md)
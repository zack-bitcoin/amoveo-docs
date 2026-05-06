Can a futarchy be used as a mechanism to decide whether to mint coins on that blockchain?
=================================

Basic terms
=========

A futarchy is a market mechanism crafted so that the price of that mechanism reveal how a certain Decision impacts how well we achieve a Goal metric.

A smart contract is a binary event that people can bet on. Like "Trump was elected president in 2024".

A market is a tool that allows users to bet together on the outcome of a smart contract. Markets have a price where the most recent trade was matched. This price is a estimate of the probability of how the smart contract will resolve.

A conditional market is a market that is also connected to a second smart contract. This second contract is able to un-do the market. All trades in the market are undone, and everyone who made a bet, they just get their original money back.

ROI: a key metric to understand mint-futarchy is the return on investment. If the ROI is 2, that means we minted coins worth X dollars, and caused the market cap to increase by 2*X dollars.

futarchy
===========

The state of the art in futarchy tech works like this:
There are 2 condition markets set up so that at least one of them will always be undone.
Each market is set up to measure how well we have achieved our Goal metric.
Which market gets undone is based on how we make our Decision.

We want to know the space of situations where mint-futarchy works. Here are limits that need to be tested
=======

If it is possible for the person receiving newly minted coins to produce less than what they had committed to, and they still get paid.

 * by buying shares in the first market.
 * by buying shares in the second market.
 * by making conditional threats.
 
How high does the ROI need to be for the mechanism to work?

How big does the size of the mint need to be, relative to the market cap of the blockchain?

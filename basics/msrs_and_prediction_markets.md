Market Scoring Rules and Prediction Markets
=========================

A market is a tool that allows people to trade assets. For example, there can be a market betting on who will win a football game. Or there could be a market to trade dollars for BTC.

Prediction Markets
===========

A prediction market is a betting market where the price of that market reflects the probability that something will happen in the future. For example, if the betting market currently says you can pay $1 on your football team, for the chance to earn $9 if they win, then that means your team has about a 10% chance of winning.

The utility of a prediction market is encapsulated in the phrase "put your money where your mouth is".
People have a tendency to talk a lot about things that they don't really know about.
The requirement to back up their opinion with money allows us to cut through the politics, and figure out what they really believe.

There are lots of resources online to learn more about prediction markets, often called "the wisdom of the crowds". Prediction markets make more accurate predictions about the future than any other mechanism we have tried. A simple way to be sure of this is that prediction markets cause a financial incentive to aggregate information from every other source. So if some other source provided decent predictions, then the prediction market would include information from that source as well.

Market Makers
==============

Market makers are participants in a market that make bets in both directions, so that if other people want to bet, there is always someone available to bet against. For example, if Alice and Bob are playing football, and we have a market for betting on whether Alice or Bob will win, a market maker could provide a bet offer saying there is a 40% chance that Alice will win, and another bet offer saying that there is a 40% chance that Bob will win.
So if anyone else wants to bet in the market, they have the option of immediately betting against the market maker.

The market maker needs to adjust the price of it's bet offers.
Imagine if the market maker didn't adjust the price of it's bet offers. Eventually, Bob could win his football game. If the market maker was still betting at 40% odds that Alice would win, people could keep betting that Bob will win, and win money with zero risk.
The market maker would be bleeding infinite funds to everyone betting the Bob won.
So that is why the market maker needs to adjust the price of it's bet offers.

Market makers are important for prediction markets, because we can use the market maker to always have a price for every market, and that price is used to know what the current prediction is for that prediction market.

Market Scoring Rules
==============

The market maker needs some strategy to change the price of it's bet offers.
When this strategy is based only on the bets in the market, then the strategy is called a "Market Scoring Rule", often MSR.

There are different kinds of market scoring rules.
In the context of markets enforced by blockchain, the two most popular kinds of market scoring rules are Logarithmic Market Scoring Rules (LMSR) and Constant Product Market Scoring Rules (CP-MSR).
LMSR was made popular by Truthcoin, Bitcoin Hivemind, and Augur. CP-MSR was made popular by Uniswap.

Recently with the introduction of Uniswap V3 there has been research into markets with custom liquidity profiles. So that liquidity providers can choose the exact range of prices that they want to provide liquidity for.

What makes an MSR good or bad
============

We would like our MSR to only require some finite amount of funds to enforce. That for a market maker using this MSR, the losses should be bounded. This is a requirement for all blockchain MSRs, because an on-chain mechanism like a market maker can only have a finite amount of funds locked into it.

We would like it if our MSR had more liquidity for the same amount of money locked into it. That means a trader can make a bigger bet, and the price doesn't move as far. Having more liquidity means there is more profit incentive for knowledgeable people to make bets and make the price more accurate.

We would like it if creating the MSR costs less, but it is even more important that trading using the MSR should cost less, because we expect there to be many trades for every single market created. The cost of providing liquidity and of trading is based on how much consensus state space needs to be updated when processing the transaction.

The LMSR
================

The LMSR has one very big advantage against all the other MSRs: if there are many different markets created at the same time, it is possible to recycle the liquidity in all these markets, so each individual part has more liquidity than it would have bad on it's own.

For example, lets say we are betting on 2 different football games A and B. Using capital/lower case letters for whether the game is a win or a loss, there are 4 possible outcomes: AB, Ab, aB, or ab.

With LMSR, we could use a single market that allows for betting on any of these 4 outcomes individually. If you think "A" will be a win, and don't know how "B" will end, then you can bet on the combination of AB and Ab.

So this single market allows for people to bet on either "A" or "B", or the combination. The liquidity of this one market is being recycled for different kinds of bets.

And we can go further. A single LMSR market like this, it can have 2^100 different kinds of shares to allow us to bet on 100 different football games, recycling the liquidity 100 times over.

But, trading in this market would involve updating on the order of 2^100 numbers in consensus space, around 1 million numbers. So, recycling liquidity this way causes an exponential increase in the part of the trading fee that pays for updating consensus state. This heavily limits our ability to use the recycling feature.

LMSR with recycling is optimized for traders who want to have the most leverage. If you make a bet conditional on correctly predicting all 100 of the football games, this is very cheap. You are only buying one type of share, so only one number in consensus space needs to be updated.
Unfortunately, this seems to be the least popular kind of bet people would want to make.

A disadvantage of LMSR is that the liquidity provider is expected to take a loss, and they often lose all the liquidity that they had provided. The idea is that they are willing to take this loss in exchange for benefiting from the information that the prediction market provides.

Another disadvantage is that it is not possible to add or remove liquidity from an existing LMSR market. So liquidity providers need to predict ahead of time where their liquidity will be needed.

Here is a nice blog post about LMSR http://blog.oddhead.com/2006/10/30/implementing-hansons-market-maker/

The formula for LMSR with 2 share types is C = b * ln((e^(q1/b)) + (e^(q2/b))).
C and b are constants that are set when the market is first created, based on how much money the market starts out with.
q1 and q2 are how many shares of each type are currently owned by traders.

The CP-MSR
===============

The constant product market scoring rule is C = q1 * q2.
q1 is how many shares of the first type are in the market.
q2 is how many shares of the second type are in the market.
C is held constant when people trade in the market.
The ratio q1/q2 is held constant when people add or remove liquidity to the market.

A major advantage of constant product markets are that liquidity providers can profit.

Another major advantage of the constant product market is that liquidity providers can add or remove liquidity at any time. This makes each market more decentralized, because there can be lots of independent liquidity providers all executing their own investing strategies.

The ability to add and remove liquidity also means that liquidity providers can adapt to trading demand, and move their liquidity where it is needed.

The CP-MSR does not allow for recycling liquidity the way an LMSR does.

Custom liquidity functions in uniswap V3
==============

In Uniswap v3, the entire range of prices is chopped up into many little chunks, and liquidity providers can choose which of those chunks they want to deposit liquidity into.

The advantage of chunking the liquidity this way is that liquidity providers can put their liquidity in the price range where there is the most demand.
This is especially important in the case of pairs of stablecoins linked to the same asset. Like if we have 2 stablecoins linked to the price of USD, then that market will almost always be between the prices 0.99 and 1.01.
So liquidity providers would want to provide lots of liquidity between 0.99 and 1.01, and very little liquidity for all the other prices.

But, chunking liquidity this way has disadvantages. The chunks are different numbers in consensus space, so when multiple chunks are updated, this can end up changing a lot of numbers in consensus space, which can be expensive.
If a trader makes a big trade that causes the price to move across multiple chunks, then this trade is more expensive based on how many chunks were crossed.
If you cross 100 chunks, then this trade is 100x more expensive than normal.
This effect is even worse in the case of liquidity providers. If they want to add or remove liquidity to N chunks, this is N-times more expensive than adding or removing liquidity to a normal CP-MSR.

Custom liquidity functions with overlapping ranges MSR
===============

Another way to provide custom liquidity profile for an MSR is to allow liquidity providers to choose the range of prices that they want to provide liquidity to, and create markets with overlapping price ranges.

This makes it far cheaper for liquidity providers, because any range of prices costs the same amount to add or remove liquidity to.

This strategy has the drawback that if the current price is in the middle of multiple price ranges, a trader would need to make trades in all of these ranges to completely minimize the price slippage of their trade. This can be expensive because each additional range they are trading in, they need to pay to update an additional number in consensus state space.

But, the trader can do a compromise. They can trade in just some of the price ranges, and accept a little extra slippage, in exchange for having to update fewer values of consensus state space. Especially if you are only making a small trade, the slippage would be minimal, so you could get a good price even if you only use one of the available market ranges.

Liquidity providers have an incentive to put their liquidity into ranges that are more likely to be used by traders, creating good incentives for trading fees to remain low.


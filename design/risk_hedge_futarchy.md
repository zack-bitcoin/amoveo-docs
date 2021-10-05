Risk Hedging Futarchy
===========

Recent experiments in using futarchy have failed.
It looks like the traditional perspective on how futarchy works, based on prediction markets, it is not secure.
Attackers can cheaply manipulate it in most cases.
We need a new version of futarchy, based on hedging risk.

Prediction Market Futarchy
==============

The traditional perspective of futarchy, which I call "prediction market futarchy" is that we are paying for knowledgeable people to reveal the consequences of decisions that we could make.
It seems like futarchy just does not work this way, except in very limited cases.
If the probability of an event is very unlikely, then it is cheap to manipulate the implied consequence of that decision.

A simple example. We are  making a decision between D and d. and we want to optimize for the life expectancy.
For the example, D is a much more popular choice, and it seems like we are already set on deciding D. there is less than 1% chance that we will decide on d.

A futarchy market in this case has 4 possible share types.
You can bet that we will choose D, and it will increase or shorten the life expectancy.
You can bet that we will choose d, and it will shorten or increase the life expectancy.

But since D is already so much more likely to be chosen, >99% of the liquidity in the market is in the 2 possible share types D-long and D-short.
So this means someone who is willing to spend 1% of the amount of money in this market, they can buy  up d-short or d-long, and manipulate the futarchy price. They can make d look much worse or better than it actually is.

If the interest rate of money over the expected time period of this futarchy market is greater than (liquidity in d)/(liquidity in market), then people who try to correct the manipulation are actually losing more money than the cost to the manipulator. 
So futarchy has level 3 trust. https://github.com/zack-bitcoin/amoveo-docs/blob/master/basics/trust_theory.md
It is insecure.

So the traditional use-case of futarchy, it only works if we are making a decision where each possible outcome has similar likelihood. If there already exists some other system to make decisions besides futarchy, then futarchy is disabled and insecure.

Basically, traditional futarchy only works to the extent that we are already using it to make decisions. It is a kind of chicken and egg problem.

Risk Hedging Futarchy
============

There is an alternative perspective on futarchy that we should consider move our focus to. I call it, "risk hedging futarchy".
Futarchy can be thought of as a kind of insurance, where people are hedging their risks. Knowledgeable people are willing to hold all the risk for the consequences of society's decision.

Looking back at the market for d/D.
People who think decision D would have positive consequences for them personally, they can buy shares of d to hedge this risk. Once they have purchased enough insurance, they no longer care whether we decide on D or d, because they are totally hedged either way. Their expected profit is the same either way.

People who think decision d would be better for them personally, they can buy shares of D to hedge their risk.

To interpret the market prices as for which decision we should make, we should make whichever decision has the lower market price. If shares of D are worth more than shares of d, then we should go with plan d.

This perspective on futarchy, it is less about prediction markets, and more about moving risk to the people who are willing to hold it.

So, what are the practical applications of this alternative perspective on futarchy?

Prediction market futarchy tells us that we should focus on important decisions where the consequences of that decision isn't well agreed upon. Prediction market futarchy depends on some metric that we can all agree is the thing we want to optimize for. Life expectancy, or the price of a currency or something like that. Prediction market futarchy is a combinatorial market that compares the metric we optimize for and the decision we are making.

Risk hedging futarchy tells us that we should focus on decisions where the community that will be impacted by the consequences of that decision, this community is made up of people who are willing and able to hedge their risk. We need people on both sides of the debate to use the futarchy market to hedge their risks. Risk hedging does not have any metric that we are optimizing for. Every individual in the market is optimizing based on their own personal values.

This leads to a minority wins game, https://en.wikipedia.org/wiki/El_Farol_Bar_problem

Instead of using the market to hedge their risks, people will be trying to bet on the minority side, as that lets them double their investment.
Even if betting on the minority side increases their risk to this particular decision, it can still be net profitable, because doubling your investment is so significant.
In terms of miner extractable value, whoever makes the very last bet, they win free money without any risk.

We can remove the minority wins effect by using a commit-reveal mechanism, where if you fail to reveal, you lose your bet.
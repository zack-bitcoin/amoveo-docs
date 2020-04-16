Uniswap
=========

Having an on-chain market is a bad strategy. Miners can front-run.
It is really weird to use a blockchain if you aren't even going to make it secure. Blockchain technology is so expensive.
If people want to trade in a market that depends on trust, they might as well use a centralized one.
on-chain market's price can be manipulated by miners as well. So we can't use them as a reliable price signal.

You can use blockchain tech to enforce the security of a market without putting that market on-chain. Then it is actually trust-free.


subcurrencies are bad
==========

It only allows for markets between 2 sub-currencies, so it can only work for blockchains that use multiple subcurrencies, which is a broken design.
Much better to have a single currency, and use it to trade risk in whatever people care about.

If you break a currency up into smaller non-fungible subcurrencies, they are all more volatile than if you used a single currency.

And ultimately, there is very little market demand for hedging risk in various subcurrencies.
What people really want is to hedge risks for things like oil or cotton or orange juice. The kinds of risks that come up when they are trying to run a business that serves real customers.

mutible on-chain state
===========

Having on-chain subcurrencies forces you to go with a design that has on-chain mutible state. to store the account info about the subcurrencies.
Which prevents scalability.

Constant Product Market Maker
===========

Here is a paper explaining the constant product market maker https://web.stanford.edu/~guillean/papers/uniswap_analysis.pdf

lets plug into some examples.
If the market has 100-A coins, and 100 B coins.
I want to buy 20 B coins.
(100 - 20) * (100 + Cost) = 100 * 100
100 + Cost = 10000/80
Cost = 125 - 100
Cost = 25

So I would pay 25 A coins to buy 20 B coins.

Uniswap has no order book. So lets say I wanted to buy 1000 B coins, and I was willing to pay 5 A coins to get 4 B coins.

I would have to make an on-chain tx to buy 20 B coins.
Then wait for someone else to make the opposite trade so the price goes back.
Then I make an on-chain tx to buy 20 more B coins.
Then I wait for someone to make the opposite trade.

And this cycle would continue until each of use has done 50 on-chain txs.

So in this example, assuming I am willing to pay 20% above market price to buy B coins, it only takes 50 on-chain txs to make the purchase.

Now lets consider the case where I am not willing to over pay by such a large amount.
if I buy only 10 B coins per round.

(100 - 10)*(100 + cost) = 10000/
cost = (1000/9)-100
cost = 11.1

So in this case I am only over-paying by 11%. And it would take 100 on-chain txs to make the complete purchase.

In practice, traders are usually unwilling to pay even 1% fee.

So lets try to get a generalized formula out of this.
If the on-chain locked up liquidity is L.
And I am willing to over-pay by P.
and I want to buy B many coins.
the number of on-chain txs is T.

L*P ~= amount purchased per tx.
T = B/(amount purchased per tx)
T = B/(L*P)

So if you want to buy $10 000 of something in 1 tx, and you are only willing to over-pay by 1%, then uniswap would need around $1 000 000 locked up.

Having lots of money locked up in the contract is expensive by the interest rate. Especially since uniswap is using low market cap subcurrencies.

Uniswap's constant product market design either has massive lockup costs, which makes it expensive by the interest rate.
or it has prohibitively high trading fees, or it involves making an excessive number of txs on-chain.
or a combination of these failure modes.

Secure markets need single price batches
===============

https://youtu.be/mAtD0ba-hXU
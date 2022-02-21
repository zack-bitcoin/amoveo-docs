The market cap of a cryptocurrency
===================

There are 2 ways a cryptocurrency can sustain it's market cap. Either by currency getting burned, or by providing utility features.

Mining a cryptocurrency is a way for the current market cap to be pushed upwards, by making new tokens available. But mining cannot sustain a market cap. If a blockchain continues using mining when it's market cap is above the sustainable level, then value is being destroyed.

First we will look at how the market cap is influenced by the rate that currency is burned, and this will give us tools to analyze how utility features impact the sustainable market cap.

A formula for the market cap
=========================

(units).

c(t) = market cap at a point in time. (money)
c_0 = market cap at time 0.
c_i = c at t=infinity. the natural market cap. (money)
t = time. (time)
b = rate that value is burned + sum of the transaction fees. (money/time)
i = interest rate of economy. (1/time)
k = springiness of the market's return to the equilibrium price. (1/time)
m = rate of block rewards + sum of the transaction fees. (money/time)

considering the case where `m=0`.

Lets assume that there is some natural market cap for this currency, and that the further away it is from the market cap, the more rapidly it approaches the natural market cap. Assuming symmetry of scaling the total money involved, assuming symmetry of changing the time scale.
in that case c'(t) = k*(c_i - c(t)).
Solving this ordinary differential equation.
c(t) = A*e^(-k*t) + c_i.
c' = -k*(A*e(-k*t))

plugging in time zero.
c_0 = A + c_i
-> A = c_0 - c_i.
A is how far away you are from the ideal market cap, at time t=0.

We are considering the m=0 case.
Assuming the efficient market hypothesis, we know that c_i = b/i.
Putting it all together.

c(t) = (c_0 - b/i)*e^(-k*t) + (b/i)


what if `m!=0` ?
(let B = b/i, and A = c_0 - B).

c(t) = A*e^(-k*t) + B.
c'(t) = -k*A*e^(-k*t).
c' is how quickly the market cap is changing in the m=0 case.

If coins are also being created by mining, then the differential equation is different.
The increase in market cap because of new coins is balanced by the decrease from the current market cap being bigger than `(b/i)`.

c_m is the market cap at the equilibrium with mining.

c'(t) = 0 = m - k*(c_m - b/i)*e^(-k*infinity)
-> m = k*(c_m - b/i)
-> m/k = c_m - b/i
-> c_m = (b/i) + (m/k)


This time, instead of c_i being b/i, it is ((b/i) + (m/k)).
So this is the equilibrium market cap.
((rate that value is burned)/(interest rate)) +
((rate of block rewards)/(rate that market absorbs info))
The market cap is maximized if the burn rate and block reward are both high.

If the market cap is fixed, but coins are being burned at a rate of b, and created at a rate of m, then the value of coins is changing by `((b-m)/c_m)`.
So the value of coins is maximized by keeping the burn rate high, and the mining reward low.




More explanation for why c = b/i.
=========

* Burning coins is the same as distributing them to all other holders.
* Paying a mining fee is the same as a combination of burning some coins, and the miner converting electricity value into cryptocurrency value.
* People will keep buying or selling the currency until the expected profit of holding the currency is the same as the interest rate of the economy.


Plugging in for examples
==========

Lets plug in some numbers to get an example.
The interest rate of the economy seems to be around 1% in bitcoin terms. Looking at the interest of wrapped bitcoin loans on ethereum.
Transaction fees per day are around $275k.
Current market cap is 7.26*10^9

If we were at the equilibrium price, then the market cap should be ((b/i) + (m/k))
b = 365.24 * $275k = $100375k = $1.004*10^8
i = 0.01
m = b + (365.24 * 6.25 * 144 * $38k) = $1.26*10^10

= $ 1.00*10^10 + (1.26*10^10 / k)

So bitcoin should be at least $10 billion.


Next looking at ETH.
It looks like the rate for lending ETH is around 0.1%.
eth daily fees are 1163 eth.
eth price today is $2625.


It looks like people are being paid 9.4% to lend their ETH. The interest rate of the economy seems to be around 3%.
ETH fees are around $15 per tx. There are around 1 million txs per day.

```
fee per tx * txs per day * days per year =
$15 * 1 000 000 * 365.24 = 5 480 000 000
```

so B is $5.48 billion

```
MC = B / (0.03 + 0.094)
= 5.48 billion / 0.124
= 44.2 billion
```
So the ETH market cap should be around $44.2 billion.

A global payments currency
==============

Imagine a blockchain went global, and was used for all the payments we are doing.
Debit card txs currently cost $0.21 + %0.05 of amount transacted.
A blockchain alternative would only charge a fee per tx, it doesn't matter how much money is being transfered. So lets go with $0.21 per tx.
Assuming the average person makes around 2 transactions per day, that there are 8 billion people.

```
B = (8 billion * 2 * 0.21)
= $3.36 billion
```

and lets assume a global interest rate on liquid assets of 1%.

```
MC = B / I
= 3.36 billion / 0.01
= $336 billion
```

So a cryptocurrency used exclusively for payments, and having global adoption, it should be worth around $336 billion.

This is disappointing because $336 billion is not nearly enough liquidity to satisfy global payments and store of value needs.

As scalability technology gets better, the situation keeps getting worse. Cryptocurrencies will compete to undercut each other in the cost of a tx, and so the steady state market cap of cryptocurrencies will keep getting lower.

Additionally, the long-term historical interest rate has always been increasing. New technology allows the economy to grow faster, which gives us access to even more technology in an exponential trend. So the interest rate is going to keep getting higher, which will cause the steady state value of a payments based cryptocurrency to keep going lower.

A global Harberger tax currency
================


Our current financial system uses things like mortgage backed debt to give access to more currency. We can do something similar with cryptocurrency using the Harberger tax system, where the taxes paid all get burned.

Lets plug the harberger tax system into our equation and see how valuable this kind of cryptocurrency could be.

Assuming the economy has an interest rate of 1%, we can charge a 1% harberger tax, so then the owner of land would keep half the productive rents from their land, and pay half into the harberger tax system.

[learn more about harberger land](use-cases-and-ideas/harberger_land.md)

The total value of real estate is around $200 trillion

```
MC = ($200 trillion * 0.01) / (0.01)
= $200 trillion
```

So a cryptocurrency that is used to control all the real estate on the planet and pay harberger taxes on that real estate, it should have a worth of around $200 trillion, which is comparable to how much currency actually exists.
This would give us enough liquidity to satisfy our paymets and store of value needs.

A harberger cryptocurrency would keep growing in value over time, because as new technology is invented, we are able to generate more value from the same amount of land. Importantly, the harberger system is not losing value from an increasing interest rate, because the tax rate can be connected to the interest rate.


Market cap from utility
==============

Some currencies have features that make that currency useful. They let you exchange risk, or create prediction markets, or participate in an online community.

The way to think of utility is that a person who is holding some of the cryptocurrency, they have the option to make some fixed returns off of that cryptocurrency.

If the currency + utility is giving bigger returns than the current interest rate, people will keep buying the currency and using the utility features. If the currency + utility is giving smaller returns than the interest rate, people will keep selling the currency to get other investments.

So if we consider the value of the currency without any utility features, it is providing returns worse than the current interest rate. Someone holding the currency and not participating in utility features would be losing money against other available investments.

So the market cap of the currency would be continually shrinking in comparison to a currency that did not have those utility features.

(market cap today) = (market cap in the future) + (how much returns you can get from utility features)








We want to have a good stablecoin.
It is impossible to have a stablecoin that is expected to increase in value against VEO.
So we want VEO to not be bleeding value vs the interest rate.

The market cap of VEO will settle at a value so that the expected returns of holding VEO + using the utility features as much as possible is the same as the interest rate.
So the expected returns of holding VEO is (interest rate) - (returns of using utility features).

So, if we add more utility features to Amoveo, then the stablecoin mechanism keeps getting worse.
And we can fix this problem by charging a rent to use the utility features, and burning the rent.
Having a good stablecoin will make all the utility features even more useful, compounding the benefits of this strategy





is the rent lower than the premium would have been?

premium is the difference between the expected future price of veo, and the stablecoin.

rent is the expected utility provided by the smart contract.

Market cap of a cryptocurrency
===================

Using economics, we can know what the market cap of a cryptocurrency should be, if they weren't being influenced by speculators.
Cryptocurrencies with market caps higher than this should tend to shrink in value, and cryptocurrencies with market caps lower than this should tend to increase in value.

MC = market cap of this cryptocurrency.
I = interest rate of the economy.
B = rate at which currency gets burned + rate at which miners are paid tx fees.
R = how much you would need to pay someone to be exposed to the risk of holding this currency.

```MC = B / (I + R)```

Proof
=========

Now to derive this formula

* Burning coins is the same as distributing them to all other holders.
* Paying a mining fee is the same as a combination of burning some coins, and the miner converting electricity value into cryptocurrency value.
* People will keep buying or selling the currency until the expected profit of holding the currency is the same as the interest rate of the economy.

```MC = (B - R*MC)/I```

Next lets solve for the market cap.
```
MC + R*MC/I = B/I
MC*(1+R/I) = B/I
MC*(I+R) = B
MC = B / (I+R)
```

Plugging in for examples
==========

Lets plug in some numbers to get an example.
The interest rate of the economy seems to be around 3% currently, and a google search shows that people are being paid 0.9% to lend their bitcoin.
The average tx fee is around $12 currently, and there are about 280 000 txs per day.

```
fee per tx * txs per day * days per year =
12$ * 280 000 * 365.24 = 1 230 000 000
```
So B is 1.23 billion

```
MC = B / (0.03 + 0.009)
= 1.23 billion / (0.039)
= $31.5 billion
```
So the bitcoin market cap should be around 31.5 billion dollars.

Next looking at ETH.
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

The total value of real estate is around $200 trillion

```
MC = ($200 trillion * 0.01) / (0.01)
= $200 trillion
```

So a cryptocurrency that is used to control all the real estate on the planet and pay harberger taxes on that real estate, it should have a worth of around $200 trillion, which is comparable to how much currency actually exists.
This would give us enough liquidity to satisfy our paymets and store of value needs.

A harberger cryptocurrency would keep growing in value over time, because as new technology is invented, we are able to generate more value from the same amount of land. Importantly, the harberger system is not losing value from an increasing interest rate, because the tax rate can be connected to the interest rate.

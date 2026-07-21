Amoveo White Paper
=============

Amoveo's plan on how to provide services and turn a profit for holders of VEO.

Traditional land registries have lots of shortcomings that [blockchains can solve.](./blog_posts/why_blockchain_land.md)
It is clear that a blockchain land registry will soon come into existence to serve the many parts of the world that are currently unserved by traditional land registries. It is the goal of Amoveo to be the best land registry available, so that many regions decide to use Amoveo as their land registry.

How much would a blockchain land registry be worth?
================

A blockchain land registry gives land owners the ability to own land with some leverage. The leverage means that instead of paying the full cost of the land up front when you buy it, you can pay some of the cost as an ongoing fee, in the form of the Harberger tax. When taxes are paid, the tax gets distributed to all holders of VEO. The expectation of receiving taxes is what gives VEO its value.

This leverage works like a mortgage contract, but instead of a bank owning a fraction of your property, it is like the holders of VEO own a fraction of your property.
The market cap of VEO ends up being `(rate of tax payments)/(market interest rate)`. But, we know that the rate of tax payments is `~(value of land)*(market interest rate)/2`, Here we are assuming that the average owner has about 2x leverage.

So then, by simplifying the expression, the market cap of VEO will be `(value of land in the registry)/2`.

VEO grows when either the amount of land it controls increases, or when the land that it controls increases in value.

The total value of all real estate on earth is about $200 trillion. So, a blockchain registry that managed X% of the real estate would be worth approximately $X trillion.

Cryptographic database of land
===============

A cryptographic database made such that it is impossible for 2 different land parcels to overlap. 

Amoveo's database uses verkle proofs instead of merkle proofs. This is a kind of zk tech that allows the proofs to be approximately 4x shorter. The verkle proofs make it possible to concisely prove what land you own.

Amoveo was the first blockchain to use a verkle tree, starting in 2023.

Harberger Auction
===============

Harberger taxes are a kind of continuous auction for allocating resources efficiently.

It has nice properties:
* whoever can produce the most value from controlling a resource, they are the ones who should have control.
* If the owner of a resource changes, the previous owner is compensated according to how much that resource is worth to them.
* Everyone who currently controls a resource, they are incentivized to honestly report the value of that resource to them.

Harberger taxes are a kind of game we play to incentivize land owners to honestly reveal the price of their land. Each land owner declares the price of their land. They pay taxes proportional to the price. Anyone can buy the land from them for that price.

If the land owner chooses too high of a price, then the taxes are higher than necessary. If the land owner chooses too low of a price, then the land can be purchased from them for too low of a price. So, the land owner is incentivized to declare the price honestly.

This means a land owner cannot refuse to sell their land.
All land ownership systems need to have some kind of eminent domain rule, to confiscate land from people when it is inefficient for them to own it. 

Land Value Tax
===============

According to the Georgist theory of economics, land needs to be taxed the correct amount to be useful for humanity.
If the tax on land is too high, then the land ends up abandoned. The tax is more than how much you can earn by using the land.
If the tax on land is too low, then that causes land crisis. Speculators buy land, not to use it, but rather in the hopes that the price will rise and they can sell it for more in the future.

In most parts of the economy, speculators are good. Onion speculators buy the extra onions during a glut, and sell them back to the market when there is a shortage.
For land, speculators are only bad. We can't create new land, so speculators are only able to reduce the supply of land, they can never increase it.
The land value tax is defined to prevent speculative investment.
If the land were to increase in value without any new improvements built on top, then the land value tax would increase just enough so that the price of the land does not change.

If Georgist theory of land is correct, and the blockchain does a better job of approximating the land value tax in comparison to legacy land registries, then the land that is inside of the blockchain registry will produce value more quickly than land that is outside of the land registry.

What about land owners who don't want leverage?
================

The leverage is voluntary.
When you purchase your land, you can decide to not have leverage by simultaniously purchasing enough VEO such that the tax you pay on your land is equal to the tax you get paid as a VEO owner.
By choosing how much VEO they hold, every land owner can choose exactly the amount of leverage they have.
This is similar to how in fiat money systems, banks can make mortgage contracts with property owners to optimize the leverage on an individual basis.

Flash loans
===============

A flash loan is a kind of loan of a cryptographic asset, and the loan is paid back in the same transaction that created it. So, it is a zero-second loan that has zero risk.
Amoveo gives infinite flash loans to anyone who wants them. No matter what asset you need, you can borrow it in any amount. As long as you pay it back in the same transaction.

So for example, if 10 people all made offers to buy 1 hectare each, for $10 each. And there is someone with a 10 hectare plot who wants to sell it for $90. Then, anyone can make a transaction to buy the 10 hectares for $90, and sell them for $100, to make $10 in profit. Even if your starting balance was 0.

A flash loan is a kind of transaction that connects multiple operations into a single atomic unit. For example, if you and 2 friends want to buy land side-by-side, and you want to be certain that you don't end up in a situation where only 1 or 2 of you buys the land, and the 3rd person's purchase fails, and they end up living further away.  You can put all 3 purchase operations into a single flash-loan transaction, so either all 3 purchases succeed, or none of them do.

Learn more
==============

The [technical specification of the land database](./design/land_registry.md).
The [Amoveo full node software.](https://github.com/zack-bitcoin/amoveo)
The [Amoveo wallet.](https://github.com/zack-bitcoin/light-node-amoveo)

Other Amoveo Features
=============

As cryptocurrency technology advances, there are certain features that become industry standards. Amoveo has many features that are not directly important for land registry purposes, but are still necessary so that Amoveo is up to date with the modern technology.

* [Stateless full nodes.](https://hackmd.io/@Luckify/HJvbhv_mWe) 
* Turing complete smart contracts.
* Turing complete state channels.
* Decentralized exchange for swapping between VEO and any other cryptocurrency.
* Harberger auction enforced employment contracts. To employ humans.
* [Decentralized trustless oracles.](./design/oracle.md)
* Uniswap style constant product markets.
* Prediction markets.
* [Futarchy.](./design/futarchy.md)
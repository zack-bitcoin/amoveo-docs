Overview - 3 January 2022
============

The purpose of this essay is to back up, and get the big picture perspective of Amoveo's business strategy. Where we see ourselves on the road to success. 

The goal of Amoveo is to make the next world reserve currency. 

We want the cheapest and most secure financial contracts. This way people can be exposed to whatever financial risk they want, without needing to leave the Amoveo network. We built an oracle that compromises on speed, in order to be as affordable and secure as possible.

Inefficient Marketcap
==========

For the contracts to work well, there needs to be a lot of liquidity. The market cap needs to be high enough to comfortably collateralize all the contracts that everyone wants. There are a lot of competing theories as to why a market cap grows to the level it does. 
We made a model that shows the market cap of the currency is proportional to the rate at which value inside the network is being destroyed. 

If this is true, it is a big opportunity. It means everyone else is using self-defeating strategies to grow.

* Using PoW mining to grow means the network is constantly bleeding value to miners.

* Using locked up coins to grow means limiting the same liquidity that we need in order to succeed.

* Using directed investment to expand a network isn't sustainable, because it isn't the network effect that made the market cap grow. The money burned on advertising is why it is growing, so the network is bleeding value to advertisers instead of miners. Economically speaking, it is less efficient than PoW for growing the network, because of bundling and vertical integration of the publicity market.

* burning fees to grow pushes an unnecessary cost on users.

All of the current strategies are ultimately pushing the cost of growth onto the users. Either inflation that taxes holders, or fees that tax users.

If there was a way to grow the marketcap without punishing users, that would be better.

Sustainable Marketcap
=============

The only way to sustainably grow is to connect the blockchain to some external system that is going to burn value anyway, and we can recycle that burned value to give Amoveo a sustainable market cap.

So we investigated some larger parts of the economy to identify if there is any burned value that we can potentially recycle.
What we ended up settling on is the real estate market.
The markets for the transfer of ownership of land and buildings.

There are problems that make it difficult to design a fair market for land.
Land isn't fungible, so a lot of basic assumptions we use for normal markets, they don't work for land.

Sometimes people have plans that require buying a combination of plots of land.
Whoever sells the last plot could realize that the entire plan depends on this sale, and they can overcharge.

There has been research in game theory to try and find a fair market mechanism for trading non-fungible resources, especially in the context of auctioning of the radio spectrum. https://en.wikipedia.org/wiki/Spectrum_auction

What we have found is that a lot of the problems of the real estate market are significantly improved by adding a tax to the value of the land and building. The tax can be made decentralized by using the harberger system. Each person declares the value of their own land, and needs to pay tax on that amount. Anyone else can buy the land for it's declared value.

This land-tax is value being burned, in order to prevent other value from being wasted inside an inefficient market mechanism.
We can recycle the tax to be used to sustain Amoveo's market cap.

Harberger Registry
============

Amoveo's market cap ends up being on the order of 1/2 the value of all the real estate who's ownership is enforced based on the Amoveo land registry.

A database to divide a globe into plots of land was a challenging problem, from a geometry perspective.
The merkle proofs for land plots needs to be set up so that you are also proving it is impossible that anyone else owns the same land as you.
The location of the land needs to determine the path you follow in the tree to look up your land plot.

We solved the math https://github.com/zack-bitcoin/harberger_global

Before implementing the database, we wanted to be sure of whether this needs to be in a binary merkle tree, or if a more efficient verkle tree would be possible.

Verkle Research
==========

Verkle trees are also needed for Amoveo, because Amovoe is a stateless blockchain. Merkle proofs make its transactions too big, we cannot fit many transactions in a block currently.
Upgrading to verkle proofs is necessary so that transaction fees can stay competitive as Amoveo scales.

So I did a bunch of small projects to understand how zkSNARKS, pedersen commits, bullet proofs, and other cryptographic tools work. https://github.com/zack-bitcoin/homomorphic-tools

These tools were combined into a working verkle tree in erlang, using secp256k1 for the pedersen vector commitments. https://github.com/zack-bitcoin/verkle

The tree is being upgraded to:

* use C for the bottlenecked parts, to be faster.
* use jubjub curve from Zcash, to be faster and enable zksnarks.

SNARKable database implications
==============

Once our database is SNARKable, that gives us the opportunity to make the oracle even more effecient. Less expensive, more users friendly, faster.

If the database is snarkable, we can put verkle proofs inside of a snark.
In the context of oracles, this allows for contracts that use the result of an oracle to enforce the outcome of the contract, but 3rd party observers don't know which oracle the contract had used.

More than that, it looks like deniable smart contracts are also possible https://github.com/zack-bitcoin/amoveo-docs/blob/master/blog_posts/private_oracles.md
This can make our oracle much cheaper and much more user friendly to use, because if the connection between your smart contract and it's oracle is deniable, then an attacker doesn't know which oracle they should be trying to manipulate.

It also gives our users a kind of privacy that isn't available anywhere else. The ability to have a private contract over any pubicly available information, and not even you or your counterparty can prove what it is that you are betting on.


Road map
===========

* verkle trees.

* deniable smart contracts.

* land registry.


4th year summary
================

It is the 4 year anniversary of Amoveo's first block. This is a summary of what we did this year, followed by some plans for what will be done in the following year.

Full Node
============

We had 3 hard updates. 

* now you can withdraw your winnings from an oracle, without needing to take your key out of cold storage.

* we updated the smart contract transaction type so that it is always possible to run the transactions in a block in parallel. You never need to wait for the output of one transaction to be able to process another.

* transaction types related to smart contracts can all be included in the same block together. This makes smart contracts more user friendly, you don't need to wait for the next block to be able to use them.

Light Node
=============

* We created a DEX (decentralized exchange) smart contract that allows you to make offers to sell your VEO to buy altcoins.
You can see it in the light node, the "crosschain DEX, sell veo" tab http://46.101.81.5:8080/wallet/wallet.html

* We created a version of the DEX (decentralized exchange) where you can use an altcoin to buy VEO. This is the first Amoveo smart contract where the state of the contract gets updated. The person who accepts your offer, they need to provide their altcoin address where they want to get paid. They need to give this address to the smart contract.

For this buy-veo DEX, we have a tab in the light node wallet as the user interface. It is the "crosschain DEX, buy veo" tab http://46.101.81.5:8080/wallet/wallet.html

* Now we have a web interface where you can test out writing Amoveo smart contract code, and it runs in your browser so you can see the results. http://46.101.81.5:8080/chalang.html It has examples you can test out.

* We created a tab in the light node for making binary bets on whatever topic you want. You can offer to bet on a sporting event, and anyone could accept your offer. it is in the "bet" tab on this page: http://46.101.81.5:8080/wallet/wallet.html

* We made a tool that used both the sell-veo and buy-veo smart contracts so that we can trustlessly exchange any altcoin for any other altcoin. it is in the "crosschain DEX" tab http://46.101.81.5:8080/wallet/wallet.html
This shows how smart contracts in Amoveo can be composible, without sacrificing the ability to run all the transactions in parallel.

* To test out the smart contract VM, we made a video game, where there are hundreds of smart contract animals competing for a limited resource. https://github.com/zack-bitcoin/life_game


The big pivot
=========

* We have been studying money, and what it is that makes a large stable market cap. https://github.com/zack-bitcoin/amoveo-docs/blob/master/basics/market_cap.md

We can to the surprising conclusion that efficient/affordable smart contracts are not what give the currency it's value.
In hindsight, it is much clearer.
The biggest cost of doing a smart contract is the volatility risk to the collateral. People will prefer a less efficient system, if it has a less volatile currency.

This meant that a basic assumption of Amoveo's business plan is broken, and so we needed to do a big pivot.
Luckily, the same market-cap research that showed us our old plan would not work, it also gave us hints as to what kind of strategy could work.
In order to sustain a high market cap, we need to consistently destroy value, and we want to do it without harming the users.

We looked through the space of financial contracts to try and find some contract that regularly burns lots of value.
What we eventually settled on is real estate.
Real estate is non-fungible. Each piece of land is unique. This means a lot of mechanisms that we use to make markets efficient, they do not work for real estate.
Real estate markets necessarily burn a lot of value, even if you use all known optimizations.


Spherical Geometry
===========

Part of the problem of a blockchain land registry is in making a database for the blockchain to record the land in.

We want:
* determinism, so every full node calculates the same thing.
* to have short merkle proofs, to support statelessness, so it can be scalable.
* a short format to record locations.
* it to be easy to divide up land using arbitrary lines, or connect it together.
* to potentially include all land on earth.
* to be easy to calculate the area of a land plot.
* It needs to be impossible for 2 different accounts to be able to prove that they both own the same location on the planet at the same time. So a merkle proof that you own land, is also a proof that no one else owns it.

So we took a deep look at spherical geometry, and found the math we need https://github.com/zack-bitcoin/harberger_global


Verkle Trees
=============

In order to keep the merkle tree proofs short enough for the land registry, we looked into an alternative called "verkle trees".
Instead of hash functions, verkle trees use pedersen commitments.

Besides the land registry, we also need verkle trees for Amoveo because Amoveo is a stateless blockchain, and verkle trees are around a 10x scalability improvement for this kind of blockchain.

Stateless blockchains do not require their full nodes to maintain any of the consensus state. So you don't need a hard drive, and you need very little ram. It allows Amoveo to be very scalable.
The current limitation with stateless blockchains is that each transaction needs to include all the merkle proofs with it that are necessary to verify that transaction.
Merkle proofs take up >90% of Amoveo blocks currently.

Verkle proofs are far shorter than Merkle proofs, and so we will be able to fit around 10x more transactions into each block.

https://github.com/zack-bitcoin/verkle

We wrote the first version of the database using secp256k1, which is the elliptic curve used in bitcoin signatures.
Then we rewrote it to use the Jubjub curve, which was invented by the Zcash team.
Jubjub is much faster, and unlike secp256k1, we can put Jubjub proofs into zkSNARKS.
The core Jubjub operations were written in C, so that this implementation of the verkle tree is fast.


Oracle Privacy
==========

Verkle trees open up more possibilities as well.
We can put verkle proofs inside of zkSNARKS.
Here is where we did research into zkSNARK tech https://github.com/zack-bitcoin/homomorphic-tools

Merkelized abstract syntax trees are a way to bring some privacy to smart contracts, because you do not need to publish unexecuted portions of the smart contract.
But merkle tree privacy can't be deniable.
A merkle proof necessarily reveals the data that you are proving.
So if you try to make a proof that you won the bet, you also end up revealing what it is that you were betting on.

Verkle proofs and verkleized abstract syntax trees don't have this shortcoming.
With a verkle proof, you can prove that you won the bet, without needing to reveal what it is that you were betting on.
The loser of the bet cannot prove what it is that you were betting on.

You can read more about deniable oracles in Amoveo here: https://github.com/zack-bitcoin/amoveo-docs/blob/master/blog_posts/private_oracles.md


Deniability comes with many benefits.

* Contracts that use oracles will resolve faster in the worst case, because an attacker doesn't know which oracle your contract is connected to, so they don't know which oracle to delay to delay your contract.

* Oracles will be less expensive. Since the attacker doesn't know which oracle you are using, they don't know which one to put money into to delay your contract. So we don't need as much base liquidity in an oracle to be able to prevent spam.

* People can bet on secret things.


Where are we going next?
================

The Amoveo DEX is the cheapest way to trade cryptocurrencies, but it still isn't getting much user activity.
Probably the user interface and lack of liquidity are the limitations.
So, we are going to improve the UX, and add liquidity.

We are going to do a hard update to move all of Amoveo's consensus state into verkle tree databases.

We are going to make a smart contract for deniable betting.

We are going to add a verkle tree database to register land, and add a few transaction types to buy/sell land.


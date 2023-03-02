5th year summary
================

It is the 5th year anniversary of Amoveo's first block. This is a summary of what happened this year, and some plans for what will be done in the following year.

Futarchy does not work
===============

https://github.com/zack-bitcoin/amoveo-docs/blob/master/blog_posts/futarchys_failure.md

Applying basic cryptoeconomic analysis to futarchy and prediction markets showed that these tools are not secure against manipulation. For almost all of the use cases we had been interested in, it does not work.

This struck a strong blow against Amoveo, as futarchy was a core value of our community, and the assumption that it would work was built into the governance mechanism.

Because of this, we are removing the governance mechanism from Amoveo.

Previously we had been a futarchy guided community, where if someone could make a futarchy to show why a strategy is better for Amoveo, then we would use that strategy.
Now the plan for Amoveo is more like a 2 phase strategy. In phase 1, the developer Zack is going to guide development, until Amoveo gets popular. Once it is popular, then decision making will slow down to almost nothing, as we prioritize stability over adding features.

Deniable oracles probably are not possible
==================

Initially our verkle research had prioritized adding deniability to the oracle. Eventually, it was found that this isn't possible.
We didn't drop the verkle plan, but now it is only a scalability tool.

Because zk-proofs aren't needed, we switched from using the bandersnatch curve to the ed25519 curve. ed25519 is better because it is simpler, faster, and better understood.

There is no centralized exchange where you can trade VEO
==================

HitBTC shut down. They were the only centralized exchange for trading VEO.
Luckily we have a working DEX, so it is still possible to buy and sell VEO.
There is a channel in discord for where you can find people to trade with.

The lack of central exchange means that it is now difficult to know what the current price of VEO is.

Coin Hours tech
=================

We spent a couple months of research on a technology called "coin-hours", which holds the potential to completely revolutionize the internet, by allowing for micro-payments on every API.

Micro-payments have long been a goal of cryptocurrency. The idea is that there are many situations where humans would benefit from being able to pay each other for things, but the size of the payments we are making are so small, that it isn't worth the cost of using any existing payment infrastructure.
For example, a small payment to someone hosting the video that you are streaming.

The problem is that cryptocurrency isn't scalable enough. Our plans to scale this far have all failed so far.
Payment channels don't add scalability. Layer 2 tech doesn't take us far enough.

Coin-hours are an alternative to cryptocurrency which can be used for the micro-payment usecases where cryptocurrency is not scalable enough.

How does it work?

If you own VEO, then for every hour you are holding that VEO, you earn one coin-hour.
If you don't use your coin-hours within a 48-hour period, they expire and you lose them.
You use your coin-hours to have access to websites or api.
Every website has it's own centralized database of coin-hours.
So if you up all your coin-hours on one website, you still haven't used any on the other websites.

We built out tools to use coin-hours for Amoveo, and this twitter clone that is an example for how to use the new tools: https://github.com/zack-bitcoin/social_amoveo
The twitter clone is currently too slow to be usable, but it serves as an example.

Coin hours for email spam prevention.
In the twitter clone, if you send a DM to someone, it locks up a deposit of coin-hours.
The recipient can unlock your coin-hours by either responding to you, or clicking a button.
This way, if you try to spam people, they can punish you by destroying your deposit of coin-hours.

Coin hours for DDOS prevention.
In the twitter clone, using the API costs coin-hours proportional to the amount of resources you are using on the server. If you use more disk space, or more CPU cycles, this costs more. This prevents DDOS.

Coin hours for provable disk space.
Before coin-hours, it was always possible that a server could run out of space for it's hard drive, and its website would fail.
In the twitter clone, you can connect the disk space used to the market cap of VEO, so that it is provably impossible for all of the hard drive space to get filled up.

Coin hours as an alternative to upvotes.
Upvotes are a bad system for deciding which content to show to users. The upvote system is cheatable, because ultimately, an upvote doesn't cost anything to make. Attackers can make many accounts to spam upvotes on their own content.
Coin hours are a better alternative, because they actually cost something, so it is providing a meaningful signal.

Coin hours as an alternative to blocking/down-voting.
Using blocking or down-votes to decide which content to show less of to users isn't a good strategy. Blocking/down-votes are cheatable, because ultimately they don't cost anything to make. Censors can easily get content they don't like removed.


Verkle design
=================

We went with ed25519 as the curve, because we don't need zk-proofs and ed25519 is well understood and very fast.

We made the controversial decision not to use ristretto. Ristretto is a strategy for using a prime order subgroup inside of ed25519. It makes it much easier to verify that your cryptographic code is secure. https://ristretto.group/why_ristretto.html

The strategy we are using instead is to manually clear the cofactors. We never need to prove that a point is on the prime-order subgroup, so this is a fast strategy for us.

The reason we don't want ristretto is that decompressing points is too slow, and it isn't even parallelizable. Even if we left the points decompressed, we would still need to verify that they are valid ristretto points, which is also slow.

Harberger global plans
==================

The math for cutting up a globe into plots of land without any floating point is ready. https://github.com/zack-bitcoin/harberger_global

The verkle tree library is ready. https://github.com/zack-bitcoin/verkle
The core elliptic curve part is written in C, so it is pretty fast.

We are setting up the hard fork to activate the verkle tree for Amoveo, for storing the existing consensus state. https://github.com/zack-bitcoin/amoveo/tree/verkle

Once we have a working verkle tree to store all the existing consensus state, then we are going to make the specialized version of the verkle tree that is for storing plots of land.


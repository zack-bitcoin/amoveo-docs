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
There are 2 condition markets. At least one of them will always be undone.
Each market measures how well we have achieved our Goal metric.
Which market gets undone is based on how we make our Decision.


Futarchy as Science
==========

this topic is Distbit's special interest. Trying to figure out what kinds of prediction markets have good signals.
There are actually a lot of ways to make prediction markets give bad signals. He made some documents about it. It seems like we will keep finding more ways that prediction markets can be made to give bad signals.

It is impossible for the blockchain to internally realize that a certain futarchy market is a bad signal.
My expectation is that in the future there is going to be a new kind of knowledge professional. Akin to scientists of today. 
It is like, if you have a paper copy of a scientific study, and you want to use the knowledge from that study, you need a scientist to read the study and tell you if it is valid or if it applies for your situation.
The scientist is not just someone who performs science, they also interpret science that other people have done, and you can't use science without an interpreter. Otherwise you will fall victim to P-hacking tricks, or something else like that.

Futarchy mechanisms also need an interpreter. Someone who understands all the ways that these mechanisms can fail. They can tell us if a given mechanism has a good signal or not.

So, we can't put futarchy into an automatic system.
We can make futarchy mechanisms that advise us to build a hard update, but we need a human in the mix to interpret the futarchy mechanism, and potentially ignore it. 

A more concrete example.
Imagine there is a government who can influence the price of VEO by changing it's legal rules. Like, if they made an oppressive tax for VEO holders.
So then, this country could threaten us. They could tell us that they will implement the tax, conditional on how a futarchy decision resolves.

There could be a futarchy market like "Should we inflate the money supply 1% and donate it to the IRS?"

Our mechanism is designed to measure whether VEO will be worth more if we do this or not.

The US gov could threaten a tax change if the market doesn't resolve how they want.

The market would correctly measure that paying the bribe is less bad for the market cap in comparison to not paying the bribe.
Because our futarchy mechanism only looks at one binary choice at a time, it can't project the long-term consequence of repeatedly paying the danegeld. 

So, instead of looking at futarchy as a way for the protocol to pay people, it is better to think of futarchy as an alternative to science. It is a way to make evidence of something.

If I merged a hard update that printed new veo, that is potentially a breach of trust against the users. So, I would need to provide solid evidence for why such a decision was made. A futarchy market could potentially be a part of this evidence.


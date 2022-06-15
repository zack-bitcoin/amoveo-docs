Coin Hours
==============

If you hold coins on a blockchain, then you are generating coin hours for yourself.
Coin hours have an expiration date, often of 1 week.
So if you don't use some coinhours in that week, then they get burned.

Im making a twitter clone that uses Amoveo to show these techniques in practice. https://github.com/zack-bitcoin/social_amoveo

Why would I want to use coin hours for my website?
===============

Coin hours allow you to use cryptoeconomic techniques in normal websites. So certain problems that used to be impossible, become trivial. Coin hours are especially useful in problems related to spam.

Coin-hours maintain all the convenience of a centralized website. The owner of the website can print coin-hours for themselves. No one is making any transactions on any blockchain. You don't have to wait for any confirmations. And no one is paying any cryptocurrency.

example. Using coin hours in email
================

I configure my inbox so that you need to lock 1000 veo-hours to the message for it to show up in my inbox.
When I see the message, if I mark it as spam, then your 1000 veo-hours get deleted. if I don't mark it as spam, then the veo-hours are returned to you.

If you would need to own like 6 veo to be able to send me a message.

example. Using coin hours in social media
=================

imagine your hard drive is only 100 gigabytes.
So there is a limit on how many messages and comments people can fit in the website.
You could charge coin-hours for every hour that their message or comment is hosted on the website.
Since there is a finite number of veo, you can set it up so it would cost more than 100% of the veo to be able to overflow the 100 gigabyte limit.

example. using coin hours for costly api
===============

A problem with websites currently is that they are only able to use very fast algorithms.
If they want to provide a service that is a little slow, it is impossible. because providing that service becomes a vulnerability. if a spammer spams that service, it can take down the website.

With coin hours, you can charge an amount of coin-hours proportional to the cost of the computation.
So this makes it possible to do things like, loop through all the upvotes from all of the accounts that you follow every time you update your feed.
This would probably be impossible for twitter.

Why can't these problems be solved without crypto-economics?
===================

you know that button that say "verify you are not a robot".
Or else they have you click on parts of a picture that have stop lights in them.
It is because spam is such an issue.

spam shows it's face in many ways in different services.

If you host good data, people spam to get access to the newer version of the data.
If you host comments, people make fake accounts to use the comments to spam referral links or whatever they are selling.
if you host direct messages or email, people will spam advertisements at each other in the messages.
If you host a web search, then the spammers will do search engine optimization, so their spam is at the top of all the common searches.

This is one of the hard problems in programming, because whatever solutions programmers come up with, the spammers can creatively come up with ways to spam harder.
There is this harmful feedback, where the more you block the spam, the more valuable it is to be able to spam, and the more effort that the spammers are willing to put in.

Previous efforts have always been focused on trying to filter out good content from the spam. but that is impossible.
The difference between good content and spam is subjective. The same content can be neither or both.
They are incorrectly trying to look at it as a computer science problem, but it is not.

It is because this is an economics problem. 
There is a tragedy of the commons going on.
Tragedy of the commons happens any time there is a resource where using that resource gives individual benefit, but causes a collective cost.

The website is a shared resource.
People have individual benefit from using that resource, but the costs of them using it is collectivized, in the form of a slower service, or more spam.

Economists already know many ways to solve tragedy of the commons.
One way is that users need to pay something in proportion to the amount of the service that they are using. 
Paying in cryptocurrency directly is not scalable, because that is way too many transactions.
Paying in coin-hours is scalable. it is 100% off-chain.

Calculating coin hours
==============

If you started with C1 coin-hours, and V coins. Then B blocks of time passed. What is your new balance of coin hours?

We want to give you 1 coin-hour for every block that you hold a coin. but after every block, we also delete 0.1% of your coin-hour balance. That way coin-hours have an expiration of about a week.
But we don't want to iterate this calculation for every block. We want a closed form to calculate the solution directly.

Here is the formula I got.

F = 999/1000
FN = F^B
C2 = (C1 * FN) + (V * (1 - FN) / (1 - F))

The stuff we sum up is a finite geometric series.
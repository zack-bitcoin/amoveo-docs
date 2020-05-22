sortition chains
=============

sortition chains was an idea for sidechains.
The inovation was using lottery style randomness so that the amount of information shrinks. only the winning lottery ticket matters, so only the winning ticket needs to come back onto the main chain.

The issue we ran into.
It needed some validator. And that validator could work with someone making a payment to execute double-spend attacks, or they can force you to hold lottery risk.

Another issue was data availability attacks. If updates were made to the sortition chain, and only one person has a copy of the data you need to be able to spend your money, then he can charge you a lot of money for that data.
If no one has a copy, then the validator could have done any sort of update without anyone knowing what changed.


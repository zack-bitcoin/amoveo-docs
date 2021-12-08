Faster Verkle Proofs
============

Here is a trick to generate verkle proofs like 3x faster. You need to store around 2 megabytes of data to do this.

Here is some background around the math https://dankradfeist.de/ethereum/2021/06/18/pcs-multiproofs.html

The bottleneck of generating the proof is in calculating the `g(t)` value from this paper. to calculate this, we need to do a lot of polynomial divisions where one of the values is equal to zero.

Specifically, we have a polynomial P(x), and we want to calculate the polynomial P(x) / (x - M) where M is one of the 256 elements in our domain.

The difficulty with this computation is that x and M have the same value for one point in the domain, and then we are dividing by zero and it is undefined.

Dankrad found a solution. He recommends pre-computing A and A' polynomials to make it faster.
We are continuing this same strategy, pre-computing more values involving A and A' to make the computation even faster.

In finite fields, division is a lot slower than addition or multiplication.
You need to calculate the inverse of a number, and that is very slow. Like 128 times slower than addition or multiplication.
There is a trick called montgomery batch inversion that lets you invert lots of numbers at once, and it only costs as much as inverting a single number, and 2 multiplications for every extra number you are inverting.

Looking at Dankrads strategy for calculating P(x) / (x - M), there are 254 inverses that need to be calculated. So we can make a single montgomery inverse batch to quickly calculate all 254 of the inverses.
But, notice that these 254 numbers being inverted, there are only 256 valid sets of these 254 numbers. One for each element in the domain.
So we can pre-calculate the 256 batches of 254 numbers, and when they are needed, just read them from the database instead of re-calculating them.

32 bytes * 256 batches * 254 numbers is around 2 megabytes of data.
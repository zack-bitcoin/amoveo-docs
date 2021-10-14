Private Oracles
============

zero-knowledge set-membership strategies
https://zkproof.org/2020/02/27/zkp-set-membership/

overview of accumulator tech Ozcelik, Medury, Broaddus, Skjellum 2021
https://www.scitepress.org/Papers/2021/103378/103378.pdf

A simple RSA accumulator construction
consists of the following expression for addition:
acc(n) = acc(n-1)^X mod N

acc(n) is accumulator value at step N.
acc(n-1) is the previous value.
x is the element being added.
and N = pq where p and q are considered
to be strong prime numbers whose Sophie Germain
prime numbers p` = (p−1)/2 and q` = (q−1)/2
 are the accumulator trapdoor. One drawback of an
 RSA accumulator is that it is collision-free only when accumulat-
ing prime numbers. A prime representative generator
is required to accumulate composite numbers without
collision

In the language of this paper, we want an accumulator that is Additive, and Positive.
That means we can dynamically add new elements, but we cannot remove them.
And it means we can prove that an element is in the set, but we cannot remove elements.

This paper says that if there is no trusted administrator, that the zero knowledge membership proofs are necessary log(N) long. At least it isn't worse than the merkle proof would have been.

This paper says only the merkle tree design can support privacy without a trusted administrator. Hopefully they are wrong about that? or maybe we need to drop the RSA plan.

wikipedia overview of history of cryptographic accumulators
https://en.wikipedia.org/wiki/Accumulator_(cryptography)

RSA accumulator, simple blog post explanation
https://blog.goodaudience.com/deep-dive-on-rsa-accumulators-230bc84144d9

other blog post explanation https://www.gakonst.com/deep-dive-rsa-accumulators

RSA accumulators first introduced Benaloh and Mare 1994
https://link.springer.com/content/pdf/10.1007%2F3-540-48285-7_24.pdf

upgrades for RSA accumulators. Baric and Pfitzmann 1997
https://www.scitepress.org/Papers/2021/103378/103378.pdf
introduces collision resistance.
Collision resistance probably isn't important for Amoveo's oracle, because we can assign IDs to oracles in the order that they were created.

private RSA accumulators Camenisch and Lysyanskaya 2002
https://cs.brown.edu/people/alysyans/papers/camlys02.pdf
* adds the ability to delete members from the set (we don't need this)
* adds the ability to make zero-knowledge proofs of membership.

batching techniques for accumulators, with applications to stateless blockchain, Boneh, Bunz, and Fisch 
https://eprint.iacr.org/2018/1188.pdf

page 14 has an algorithm to prove non-membership of elements.
there is also an algorithm for proving multiple non-memberships.

maybe bilinear map accumulators would be better:
http://cs.brown.edu/research/pubs/theses/ugrad/2013/tremel.pdf
or maybe they are worse because they don't have dynamic updates: https://crypto.stackexchange.com/questions/77395/what-is-the-bilinear-map-accumulator-disadvantage


Potential tool. oracle result cache.
=================

Block headers need 2 new numbers. They are for 2 rsa accumulators.

Every time an oracle resolves, we insert the final state into these accumulators.

The first accumulator gets reset to empty every ten thousandth oracle, starting on oracle five thousand.

the second is reset to empty on every ten thousandth oracle, starting on oracle ten thousands.

So at any time, it is possible to make RSA proofs for the 5000 oracles that settled most recently.

Hopefully it is also possible to make private RSA proofs.

Potentially we can store other cache like this.
Recently settled contracts.

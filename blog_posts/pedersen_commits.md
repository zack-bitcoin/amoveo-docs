Pedersen Commits
============

Motivation
============

Pedersen commitments can be used as an alternative to merkle trees. This makes proofs shorter.

If a merkle tree is storing N elements, then the proofs are log2(N) long. And we are storing 2 hashes per level.

With Pedersen commitments we can store thousands of elements per node so it is something like log2048(N). Much shorter proofs.

Pedersen Commits Basics
=============

Pedersen Commits are defined in the Elgamal cryptosystem. So you can build them over different fields. Originally the field modulo P was used, but today we will be using elliptic curves, because the numbers we need to store can be shorter.

in Elgamal you use a group G, with 2 operations.
(+) The ability to add 2 group elements together to get another group element. In our case, we are using elliptic curve addition.
(*) The ability to multiply a group element by a scalar, which is the same thing as adding that element to itself that many times. For us, this is elliptic curve multiplication by a scalar.

In Elgamal your group needs at least one generator point H1.

encryption of message M in elgamal, using a random blinding factor R.
In this case H2 is the receiver's public key, and `H2 = H1^X`, where X is the recipient's private key.

```
encrypt(M, R) ->
  C1 = R*H1,
  C2 = M+(H2*R),
  {C1, C2}.
```

X is their private key.

```
decrypt(C1, C2) ->
  U1 = X*C1,
  (U1^-1)+C2
```

Pedersen Commits in Elgamal
================

To make elgamal work for pedersen commitments, we want the private key to be unknowable.
So instead of selecting H2 = H1*X for a known X, we just choose H1 and H2 as different generator points where no such X is known.

To make a commitment to variable V, with a blinding factor R.

```
commit(V, R) -> 
  V*H1 + R*H2.
```

The commitment can be verified by anyone who knows R.

```
verify(Commitment, V, R) ->
  Commitment ==
  commit(V, R).
```

Pedersen Multi-Commits
===============

If you want the ability to commit to N different values, then you need at least N different generators for the group: [H1, H2, ... , HN].

If the values that you want to commit to are: [V1, V2, ... , VN], then the commitment looks like this
```
  Commitment = H1*V1 + H2*V2 + ... + HN*VN.
```

If you want a proof that V2 is inside of the commitment. 
```
  Proof = H1*V1 + H3*V3 + H4*V4 + ... + HN*VN.
```
notice that H2*V2 is not included in the proof.
If you store N intermediate values, then these proofs can be calculated in O(log2(N)) time. Maintaining the intermediate values costs O(log2(N)) time per update. calculation and updating can be sped up a lot by batching operations.

Calculating and maintaing proofs for merkle tree also costs O(log2(N)), so we haven't slowed down.

You can verify the proof of V2 in location 2 like this:
```
  Commitment == H2*V2 + Proof.
```

Pedersen Tree
=============

If we have exactly 128 generators for the group, where the discrete log between the generators is unknown, then we can store exactly 128 things in this pedersen commit.

We could store 128 pedersen commit roots from 128 other pedersen commits, and by recursing this way we can store an entire tree this way.

For the database, the cost of storing each pedersen commit of the tree is 256 other commits. This allows the database to generate a proof for any of the 128 elements in this tree using only log2(128)=7 elliptic curve additions.


Pedersen accumulator
============

a pedersen multi-commit to data [V1, V2, V2] using generators [G1, G2, G3], it is like 
V1*G1 + V2*G2 + V3*G3

but, what if one of the variables in V is equal to zero?

 0 * G1 = infinity. the infinity point on the elliptic curve, which acts as a zero for the group.

(infinity point) + X = X for all values of X.

So we would have calculated the same multi-commit with data [V1, V2, V3, 0] and [G1, G2, G3, G4] with any new generator point G4.

The Pedersen accumulator, it can learn new generators and gain the capacity to store more variables.

Every address for every account could have a requirement that it also determines a basis point in the group. So generating an address also involves generating a new generator point.
If every account has it's own generator point, then we can store all the accounts in a single layer. We can prove the value of any account's state with a single elliptic point. We can prove the value of any combination of account's states with a single elliptic point.

So this would be the absolute perfect tool, if it works.

Links to learn more
=============

If we use pedersen commitments to store vectors, those vectors proofs are compressible, which opens the possibility of constant-order proofs. https://dankradfeist.de/ethereum/2021/07/27/inner-product-arguments.html

Using vector commitments to build a database for a blockchain: https://dankradfeist.de/ethereum/2021/06/18/verkle-trie-for-eth1.html and a video about the same: https://www.youtube.com/watch?v=RGJOQHzg3UQ

a reference implementation of these kinds of vector commitments in a tree https://github.com/ethereum/research/blob/master/verkle_trie/verkle_trie.py

Basics of pedersen commits, and their relationship to the Elgamal cryptosystem.
https://research.nccgroup.com/2021/06/15/on-the-use-of-pedersen-commitments-for-confidential-payments/


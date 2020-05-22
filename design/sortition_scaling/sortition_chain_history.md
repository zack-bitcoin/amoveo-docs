Sortition Chain History
=========

[sortition chains home](./sortition_chains.md)

Thank you to [Satoshi Nakamoto for showing that blockchains are possible](https://bitcoin.org/bitcoin.pdf).

Thank you to [Vitalik Buterin](https://twitter.com/VitalikButerin) and other early Ethereum founders for showing how bitcoin scripts are not powerful enough to do all the things we want, that we need smart contracts on blockchains.

Thank you to [Paul Sztorc](https://twitter.com/Truthcoin) for figuring out that financial derivatives are the kinds of smart contracts that we most need to put onto blockchains, other kinds of smart contracts don't really matter in comparison to how important derivatives will be.
Financial derivatives don't depend on shared state, this lack of shared state means that financial derivatives can be much more scalable than other kinds of contracts. Sortition chains don't allow for shared state. We could only do the sortition chain design because we knew that we don't need shared state, because of Paul Sztorc's work.
He wrote a couple articles on this topic http://www.truthcoin.info/blog/contracts-oracles-sidechains/ and http://www.truthcoin.info/blog/wise-contracts/

Thank you to Vitalik Buterin for writing about probabilistic payments in this blog post https://blog.ethereum.org/2014/09/17/scalability-part-1-building-top/ This inspired me to look deeper into probabilistic value scaling possibilities, and lead me to research lottery type scaling.

Thank you to [Fernando Nieto](https://twitter.com/fnietom) for his work on channel factories in bitcoin.
Channel factories is the origin of the idea of using a lottery for scaling.
Fernando solved a lot of the design issues that come up when trying to use a lottery for scaling.
Fernando taught me why a lot of different RNG protocols are unsuitable for sortition chains.

Thank you to [Mikerah](https://twitter.com/badcryptobitch) for valuable discussions in designing sortition chains.
She helped to confirm limitations in alternative scaling plans like plasma and optimistic rollup. This confirmed that sortition chains are worth the effort of inventing.
She pointed out some plasma chain research that was useful for designing sortition chains.
She recommended that I look into [Joseph Bonneau](http://jbonneau.com/presentations.html)'s work on RNG for lotteries.
She recommended looking into the truebit strategy for doing fraud proofs.

Thank you to Vitalik Buterin for explaining about the plasma chain research results in this video https://youtu.be/uzfiAirrZR4 and to [George Konstantopoulos](https://twitter.com/gakonst) for explaining in this paper https://www.gakonst.com/plasmacash.pdf and to other Ethereum plasma researchers that helped discover these possibilities.
Sortition chains use this strategy to prove ownership of a winning lottery ticket in an off-chain lottery.

Thank you to Joseph Bonneau and others for this paper https://eprint.iacr.org/2015/1015.pdf which solved much of the random number generator problem for sortition chains. In particular, section 6.1 of that paper.

Thank you to the truebit team for coming up with a general way of doing fraud proofs https://truebit.io/ . Their solution allows us to verify any off chain computation of N steps using only log(N) steps on-chain. We use this strategy to verify the correctness of values produced from the on-chain RNG generator.




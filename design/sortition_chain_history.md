Sortition Chain History
=========

Thank you to Satoshi for showing that blockchains are possible.

Thank you to Vitalik and other early Ethereum founders for showing how bitcoin scripts are not powerful enough to do all the things we want, that we need smart contracts on blockchains.

Thank you to [Paul Sztorc](https://twitter.com/Truthcoin) for figuring out that financial derivatives are the kinds of smart contracts that we most need to put onto blockchains, other kinds of smart contracts don't really matter in comparison to how important derivatives will be.
Financial derivatives don't depend on shared state, this lack of shared state means that financial derivatives can be much more scalable than other kinds of contracts. Sortition chains don't allow for shared state. We could only do the sortition chain design because we knew that we don't need shared state, because of Paul Sztorc's work.

Thank you to [Fernando Nieto](https://twitter.com/fnietom) for teaching me why a lot of different RNG protocols are unsuitable for sortition chains.
And for his work on channel factories in bitcoin.
Channel factories is the origin of the idea of using a lottery for scaling.
Fernando solved a lot of the design issues that come up when trying to use a lottery for scaling.

Thank you to [Mikerah](https://twitter.com/badcryptobitch) for valuable discussions in designing sortition chains.
She helped to confirm limitations in alternative scaling plans. This way we could be sure that sortition chains are worth the effort of building.
She pointed out some plasma chain research that was useful for designing sortition chains.
She recommended that I look into [Joseph Bonneau](http://jbonneau.com/presentations.html)'s work.

Thank you to Joseph Bonneau and others for this paper https://eprint.iacr.org/2015/1015.pdf which solved much of the random number generator problem for sortition chains. In particular, section 6.1 of that paper.

Thank you to the truebit team for coming up with a general way of doing fraud proofs https://truebit.io/ . Their solution allows us to verify any off chain computation of N steps using only log(N) steps on-chain. We use this strategy to verify the correctness of values produced from the on-chain RNG generator.

Thank you to Vitalik for explaining about the plasma chain research results in this video https://youtu.be/uzfiAirrZR4 and to George Konstantopoulos for explaining in this paper https://www.gakonst.com/plasmacash.pdf and to other Ethereum plasma researchers that helped discover these possibilities.
Sortition chains use this strategy to prove ownership of a winning lottery ticket in an off-chain lottery.



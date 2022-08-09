How much data do we need to store on the main chain to enable 1 tx on the side chain?

According to BitcoinHivemind, the most best bitcoin sidechain project, each sidechain needs something like 32 bytes per 1000 blocks, no matter how many txs are in that sidechain.

According to the ethereum developers, you need something like 24 bytes of data on the main chain, for every tx on any of their sidechains, called "rollups".

Bitcoin sidechains
===========

The fundamental sidechain problem is not technical, but instead a misunderstanding of Bitcoin by autistic developers. Sidechains do not need explicit cryptographic proofs in the base-chain. All they need is a publicly observable, auditable, and deterministic outcome in parallel.

For example:
If we are all watching a football game. We all watched every play of the game, and witnessed the final result. Just because we cannot cryptographically prove each play of the game, and we cannot cryptographically prove the final score, does not mean we cannot all come to consensus on the final result.

If the ESPN Blockchain comes out tomorrow and reports the wrong game result (that we all witnessed with our own two eyes), we are going to stop following the ESPN Blockchain. We will follow the Fox Sports Blockchain instead.

No one is going to stake their coins on a chain, that reports incorrect results.

Now people will make the counterargument that not everyone can sit in the stadium to verify every game that is being played on a sidechain, therefore cryptographic proofs are needed to avoid sybil attacks in reporting game results.

What these people fail to realize is that is already the case with base-chain Bitcoin. 99.999% of Bitcoin users do not run full nodes. 99.999% of Bitcoin users do not witness the Bitcoin game at the stadium it is being played in. 99.999% of Bitcoin users are trusting off-chain cryptography, or intermediaries to watch the Bitcoin game for them. Yet the Bitcoin network and consensus has proven to remain secure. That is because there are enough seats in the Bitcoin stadium to propagate the truth via Web of Trust and avoid sybil attacks.

Therefore, we can conclude that explicit cryptographic proof in the base-chain is not needed for sidechain security. All that is needed is the ability for people to witness the sidechain if they so choose. No new assumptions are being made.
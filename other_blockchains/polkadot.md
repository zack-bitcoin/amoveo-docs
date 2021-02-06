Review of Polkadot
===============

Polkadot is a proof of stake cryptocurrency project.

The white paper is here https://raw.githubusercontent.com/polkadot-io/polkadot-white-paper/master/PolkaDotPaper.pdf

A more up-to-date, but less detailed description of the tech is here: https://polkadot.network/technology/

Lets start with the more up-to-date description.

Consensus Roles
===========

Nominators - Nominators are using a voting system to choose validators. [Voting cannot be a secure mechanism in blockchains, and should never be used.](../design/voting_in_blockchains.md)

Validators - The validators are staking DOTS to have the responsibility to add txs to update the consensus state. [Proof of stake will always be more expensive for the users than PoW](proof_of_stake.md). This cost can come in the form of higher fees, more frequent attacks, or more severe attacks.

Collators/Fisherman - It appears that polkadot is using fraud proof for security, similar to the Optimistic Rollup idea. This means finality is very slow, but it is a valid way to increase scalability.

Governance Roles
==============

Council Members - These people are elected by vote. Voting cannot be secure for blockchains, so the process of forming the council is insecure. They have the power to propose and veto "referenda", which means that they are voting to make decisions. Voting is insecure, so the process that the council is using to make decisions is insecure. An attacker could manipulate who is on the council to cheat the network. An attacker could manipulate the decisions of this council to cheat the network.

Technical Committee - A group of teams of people who are building polkadot. They can propose "emergency referenda", which are like normal referenda, but happen faster. Emergency referenda are also something being voted on, so an attack can manipulate these emergency referenda to cheat the network.

Next looking at the white paper
===========

Skipping to section 4 where it starts talking about Polkadot's design. Again it has the same 4 roles: collator, fisherman, nominator, and validator.

Validators
=========

Validators have a security bond, part of this bond might not be owned by the validator, instead it is owned by nominators. So polkadot is using a delegated proof of stake system.

Validators make blocks.

Nominators
============

Nominators choose a validator and put their money into that validators bond.
They get punished or rewarded the same as the validator they have staked against.
It is delegated proof of stake.

Delegated proof of stake is even less secure than normal proof of stake, because the price of bribes is much lower. If a validator only owns 10% of their bond, then the price of bribing them is only 10% what it would have been in normal proof of stake.

Collators
=======

They run a full node for one of the sidechains.
They create sidechain blocks and zero-knowledge proofs of their integrity to the validators to be signed.

The paper fails to explain what kind of zero knowledge proofs would be used, or what is even being proved.

I get the feeling that the words "zero-knowlege proof" don't actually mean anything to the author of this paper, and they are just saying these words to give a mystical sense of authority.

There is no explanation on how we avoid soft fork attacks of the sidechains.
If the collators decide to censor data, their blocks are still valid, and the zero-knowledge proofs are still valid, so the main chain validators would accept those blocks.
Soft fork attacks can change the consensus rules in any way, including stealing the funds.

So the main chain validators are not giving security to the sidechain.

Fisherman
===========

Zero knowledge proofs are a kind of validity proof, meaning that whatever they prove is immediately knowable to the verifier.
This is in opposed to fraud proofs, which are a slower kind of proof that can take a week or more to be knowable to the verifier.
Fraud proofs are based on a game theoretic mechanism where anyone who is able to give evidence that fraud has occured, they can collect a reward.
If enough time passes, and no one provides evidence of fraud, then we assume that fraud must not have occured.
At that point the verifier can finally be certain of the result.

Based on the description of collators, you might think that polkadot is based on fast-finality validity proofs. But now in this section we switch to talking about fraud proofs.

Fishermen are part of a fraud proof system. They provide evidence that fraud has occured.

Fisherman show that validators signed over bad data, or signed over conflicting data.

Fisherman are required to give a security deposit which is taken from them if they make invalid evidence of fraud to spam the network.

Consensus
===========

Now looking at section 5, Consensus.

It is using tendermint for the core blockchain, a kind of PoS.

It says sidechain blocks are only valid if all the data is available.
But it isn't possible to securely prove whether or not data is available, because of the speaker-listener fault equivalence problem [as explained well by Vitalik](https://vitalik.ca/general/2017/07/16/triangle_of_harm.html)

Additionally, data which was once available can later become unavailable, which makes it impossible to verify the history of polkadot independently.

Protocol
===========

Now skipping ahead to section 6, Protocol in Depth.

80% of all DOT will be staked in validator bonds at all times.
I am guessing they make this claim because of the false impression that having a larger amount of money at stake means it is more secure.
Proof of stake systems are vulnerable to tragedy of the commons, so the actual security is strictly less than the median stake's validator's bond size. Having a larger total amount of DOT at stake doesn't make it more secure.

If the total staked is less than 80%, then the minimal bond size to be a validator keeps reducing until enough becomes staked.
They don't give any explanation why reducing the minimum bond should cause more DOT to get staked. In practice this is almost certainly false.

in 6.2.3 it says that Validators can be punished for inactivity during the consensus process.
But the only people who know if a validator was inactive are the other validators.
This means any majority of the validators can claim that the minority was inactive, and take complete control of the consensus. Blocking new validators from being able to join.

in 6.4 it says that if any validators disagree over including a sidechain block, that the validators then do a vote to decide who is cheating, and that cheater is punished.
This is another mechanism by which any majority of the validators can punish the minority or lock them out. Giving themselves permanent control over Polkadot.

Conclusion
=========

In Polkadot, the mainchain has multiple vulnerabilities that can cause it to break and the funds in the sidechains to get stolen.
If the main chain functions correctly and does not get attacked, it is still not providing security to the sidechains. The funds in the sidechains are vulnerable to soft fork attacks.

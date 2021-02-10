ChainFlip
===========

ChainFlip white paper https://chainflip.io/ChainflipWhitepaperV1.1.pdf

ChainFlip is secured by staked vault nodes.
That means there are teams of specialized reporters who have locked value into vaults, and they vote on whether transactions have occured or not.

[Voting in blockchains is a bad strategy](../design/voting_in_blockchains.md)

Voting is especially bad in this case because of tragedy of the commons.
The cost to bribe voters to steal the money being swapped is very cheap.
If a vault has N participants, each with M stake, you only need to pay M/N in bribes to each participant for them to be willing to participate in an attack to steal the money being swapped in ChainFlip.

If you are trusting a team of people to not rob you when you use ChainFlip, then that means you need to pay them enough trading fees so that they have an expectation that the long term profits from fees outweighs the short term profits of robbing you now. These fees mean that ChainFlip is much more expensive to use than alternative DEX designs.
This cost can either come in the form of higher fees, or more frequent attacks that steal the money being swapped in the DEX.

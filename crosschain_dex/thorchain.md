Thorchain
============

[Looking at the thorchain docs](https://docs.thorchain.org/) in the section "introduction".

Thorchain is an ethereum sidechain. When ethereum tokens are locked into vaults inside ethereum, it becomes possible to make witness transactions on Thorchain to use those tokens inside of Thorchain.

So Thorchain does not have any BTC, instead it has wrapped BTC from Ethereum. Wrapped BTC have a team of custodians who you are trusting to actually own the BTC to back the value of these wrapped BTC, and you are trusting them to exchange real BTC for the wrapped BTC.

To withdraw your tokens back to Ethereum you are trusting the TSS process, a kind of multisig split up between several computers. All of these computers are controlled by the Bifrost validators. The Bifrost validators can cooperate to steal all the money in Thorchain.
https://medium.com/thorchain/the-bifr%C3%B6st-protocol-bridging-chains-safely-9097c7dde7bf

In order to convince the Bifrost validators to not steal the money, they need to receive enough fees so that the long-term expected profit from fees exceeds the short term expected profit from stealing the funds.
[There is a general principle linking security and cost. Less secure mechanisms are necessarily more expensive to use. The fees paid to Bifrost validators is where this cost is going in Thorchain](../design/consensus_efficiency.md)

But, Bifrost validators don't have long-term security in their position, because thorchain nodes have the power to vote to change who are the Bifrost validators.

The Bifrost validators are selected by an insecure voting protocol decided by a 67% majority of thorchain node validators.

[voting cannot be a secure mechanism in blockchains](../design/voting_in_blockchains.md)
Voting is particularly insecure because it is vulnerable to tragedy of the commons. If someone offers to bribe voters, the benefit to a validator for accepting this bribe is individual to that validator. But the cost of accepting this bribe is distributed to all of the validators. When a mechanism has individual benefit and collective cost, then it is suffering tragedy of the commons. Because of this, the cost to bribe a validator to make decisions that harm the network, this bribe is very cheap. Only a small fraction of the stake owned by that validator.

Anyone can become a Thorchain node validator by bidding the most in the regular auction.
Additionally, during each auction period, up to 1/3rd of the thorchain nodes can be fired by the other 2/3rds of thorchain nodes.
This is a kind of voting protocol, and adds an additional vulnerability to the system.

In order for thorchain nodes to be incentivized to not attack the network, they need to be receiving enough fees so that the long-term expected profit from fees exceeds the short term expected profit of stealing the coins locked in thorchain.

These fees and costs caused by insecure voting mechanisms mean that Thorchain will either be so much more expensive than the alternatives, that it wont be used. Or else it will suffer from attacks that steal all the value.


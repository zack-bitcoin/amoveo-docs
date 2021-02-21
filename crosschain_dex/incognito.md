Incognito
============

[crosschain reviews home](/crosschain_dex)

For Incognito there are teams of "trustless custodians" who lock up Eth in the Ethereum blockchain. https://we.incognito.org/t/trustless-custodians-a-decentralized-approach-to-cryptocurrency-custodianship/84

If you want to move bitcoin into Incognito, you need to pay some custodians to hold your bitcoin. In return they give you wrapped bitcoin inside of incognito.
Paying custodians to hold your bitcoin makes this sytem more expensive than it needs to be.

Turning your wrapped bitcoin back into normal bitcoin is a process called "unshielding". https://we.incognito.org/t/shielding-cryptocurrencies-turning-any-cryptocurrency-into-a-privacy-coin/83
Part of the unshielding process is that incognito validators need to look at the bitcoin blockchain to verify if you have received your bitcoin.
If >2/3rds of the validators vote that the custodian is refusing to give you your bitcoin back, then you can take some of the stake away from the custodian.

So even though the custodian is trustless, you are still trusting that the Incognito validators will vote honestly. Additionally, the custodian is trusting that the validators will not vote to confiscate his collateral at the wrong times.

In order for the validators to not be incentivized to steal the funds, the validators need to be receiving enough fees so that the long-term expected profit of fees exceeds the short term profit of stealing the collateral from the custodians or stealing the wrapped bitcoin from the traders. The cost of these fees makes incognito prohibitively expensive.

Anyone can become an Incognito validator by locking up 1750 PRV tokens. https://incognitodoc.gitbook.io/workspace/incognito-validator

Auto Liquidation + insecure oracle
===========

The security of the custodians is dependent on the fact that the collateral for each custodian is bigger than the amount of wrapped BTC that custodian is entrusted to hold.
Maintaining that the collateral is worth more than the BTC is enforced by the auto-liquidation mechanism described in this page https://we.incognito.org/t/trustless-custodians-a-decentralized-approach-to-cryptocurrency-custodianship/84
If the value of collateral drops below 125% of the value of the BTC entrusted to those custodians, then they are forceably liquidated, and the collateral is paid out to people holdingn wrapped BTC inside of incognito.
For Incognito to know that the value of the collateral has dropped below 125%, there needs to be a oracle reporting the price of that collateral.
This oracle is controlled by the centralized team of incognito developers. https://we.incognito.org/t/questions-about-incognito-tech/4662

So the incognito developers can steal the the collateral from the custodians.
In order for the developers to be incentivized not to steal this collateral, they need to receive enough fees so that the long term expected profit of fees exceeds the short term expected profit of stealing the collateral.
The cost of these fees makes the system prohibitively expensive.


Incognito V4
============

I was asked to review the design of version 4 of incognito, explained here https://we.incognito.org/t/incognito-s-trustless-non-custodians-bridge-v4/9605

V3 had 2 sets of people with capacity to steal the money, so users needed to pay enough fees to each the validators, and the developers to convince them not to steal.
V4 only has one set of people with the capacity to steal. The validators. 

I think it is dishonest to use words like "trustless" or "no custodians" when there is a multisig of trusted beacon validators who can refuse to unlock your coins.

A multisig is a kind of voting protocol. It doesn't make sense to use voting protocols for customer funds like this https://github.com/zack-bitcoin/amoveo-docs/blob/master//design/voting_in_blockchains.md

Given that a DEX can be free, it makes me think that a design that involves paying people to not rob you, like in Incognito V4, it is a cost prohibitive design.

There is a fundamental connection between security and the cost to use a service. Less secure services are necessarily more expensive. https://github.com/zack-bitcoin/amoveo-docs/blob/master/basics/trust_theory.md
Both Incognito v3 and v4 are level 4 trust, because there is a way for attackers to profitably destroy user's value. Level 4 is the least secure class of mechanisms. The opposite of trustless.

Level 1 trust is the class of mechanisms where there is no one with the capacity to destroy funds. Level 1 is the only level where you can use the word "trustless".

A trustless DEX has no locked funds.
It isn't paying APY yield to anyone.
APY yield is an unnecessary cost on the system.
Increasing APY yield means increasing the cost on your users.


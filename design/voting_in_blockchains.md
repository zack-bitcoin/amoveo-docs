Voting does not work
==========

* what do we mean by "voting"?
* there is no stable equilibrium in voting mechanisms
* the nash equilibrium of voting is rational ignorance
* it impossible to prevent selling votes
* P+epsilon attack means an attacker can cause us to vote for something we hate, and the attacker doesn't even have to pay us to do it.
* Arrow's impossibility theorem


Voting
=========

voting is a protocol for making decisions. It has a pool of more than 1 people who each have some influence over a decision that is being made.

In a betting protocol, one of the choices is "true", and you get rewarded for betting on the true outcome and punished for betting on the false outcome.

If there is no true-option, or if (there is no reward for selecting the true-outcome and punishment for selecting the false outcome), then it is a voting protocol, and it is not a betting protocol.

The coin increasing in value because of good decisions and decreasing in value because of bad decisions is not enough of a reward.
Because of tragedy of the commons, these effects cancel out. 
If the attack will succeed and destroy the value of your coins either way, you might as well join and get paid a bribe.

So the reward has to be increasing the portion of coins you own inside the system, and the punishment has to be decreasing the portion of coins you own in the system.

no stable equilibrium
==========
https://vitalik.ca/general/2019/04/03/collusion.html


nash equilibrium of rational ignorance
=========
The individual cost of being an informed voter is high. The individual benefit of being an informed voter is almost zero. So the rational voter does not waste time becoming an informed voter. The ration voter votes from the position of ignorance.

impossible to stop them from selling their votes
========
Votes are sold cheaply: basics/market_failure.md

Under Nakamoto security it is not possible to prevent people from proving how they voted. If they can prove how they voted, then it is also possible for an attacker to use a smart contract to commit to paying a bribes to influence voters.
Under Nakamoto consensus it needs to be possible for the miners to calculate the consensus state of the blockchain after including the next transactions.
The miners need the ability to either include or not include any valid txs. Otherwise someone could prevent mining by refusing to share a tx.
So, the miners can calculate the next block's state after censoring any of the txs from that block.
Under nakamoto consensus everyone needs to be able ot mine, so everyone can calculate the next block's state after censoring any of the txs.
Since votes are txs, that means we can calculate the consensus state after removing any votes from the pool of votes.
By looking at the result of the election after censoring various votes, we can calculate each individual's vote.

P+epsilon, attacker doesn't even have to spend money to take control of the result.
========
The P+epsilon attack is where an attacker commits to paying a bribe, but the attacker only has to pay if the attack fails.
The nash equilibrium is for the attack to succeed, and so the attacker don't have to pay any bribes.
You can learn more here:
https://blog.ethereum.org/2015/01/28/p-epsilon-attack/

Arrow's Impossibility Theorem
======
It is mathematically impossible to come up with a type of voting that has all the properties we need.
https://en.wikipedia.org/wiki/Arrow%27s_impossibility_theorem

Links to other writing on this topic
========

http://hackingdistributed.com/2018/07/02/on-chain-vote-buying/
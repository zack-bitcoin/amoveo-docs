The Defense of Proof of Work
============

Lately a lot of people have been making arguments that PoW is vulnerable to certain kinds of attacks. The goal of this document is to explain the various attacks, and to try and understand the conditions under which they will or will not succeed.

Thanks to Elliot Olds for helping to explain to me the various attacks against PoW currently being discussed in the Ethereum community. Elliot can explain complicated topics clearly and concisely, he keeps himself up-to-date with current research in crypto, you can follow him on Twitter https://twitter.com/elliot_olds

Credible commitment to attack.
========

The credible commitment to attack (CCA) idea is that if a powerful person or institution could meet these conditions:

1) They have a credible strategy to spend resources to destroy a PoW blockchain.
2) They have enough resources to afford this attack.
3) They can convincingly commit to using their resources to do the attack.

In this situation, users of the PoW currency would all want to get their money out before the attack occurs. So the price of that PoW currency will fall, the block rewards will fall in price, the mining equipment will fall in price, and so it becomes very cheap to pull off the attack.

When analyzing arguments that include the CCA, be cautious of circular reasoning.
Many people who try to explain why PoW will fail, they start with the assumption that PoW can be attacked, and then use the CCA reasoning to show that the attack is affordable, and circularly use that affordability to say that PoW can be attacked.

A proper argument that PoW can be attacked, it needs to first show (1), (2), and (3), only then is it possible to use CCA to show that the attack is cheap.

Buy equipment attack
=================

Government does a soft fork to censor all tx types. No money can move.
They achieve this by purchasing or manufacturing mining equipment.

In an economic equilibrium, the most efficient miners are spending 1/2 the cost on hardware,and 1/2 the cost on electricity. There are lots of variables in the design of mining hardware, so they can optimize for the ratio of ingredients used for mining. If the marginal cost of one of the ingredients is lower, then they can build hardware that optimizes for that price ratio.

Mining equipment is an illiquid market, this will cause the price of mining equipment to increase substantially. If the price of mining equipment doubles, then existing miners can sell their equipment, and earn more money than they would have expected to gain had they been mining for the entire life expectency of that equipment. And they are earning this money all at once, without the risk of electricity or cryptocurrency changing price. So they save the time-value of their money, and are immediately prepared to re-invest.

This is an example of the cobra effect https://en.wikipedia.org/wiki/Cobra_effect
If governments start over-paying for the creation of mining equipment, then those governments are fully financing the cost of new mining equipment to be manufactured.
So the government that attempts this attack, it is paying to have new ASICS with a different mining algorithm manufactured.

If a government is buying all the equipment, they need to host it somewhere. This location will be vulnerable to sabatoge. If there is a blackout, then the miners get shut off.

The location hosting miners, it needs to be operated by officials. Those officials are vulnerable to corruption. They can steal the equipment, or allow it to catch fire. They can participate in markets to profit from allowing their mining pool to fail.

Confiscate Equipment Attack
===========

Government does a soft fork to censor all tx types. No money can move.
They achieve this by confiscating mining equipment.
This is the kind of attack people typically imagine a country like China would try to pull off, since a large portion of hashpower is located in China.

When equipment is confiscated, there is a large incentive for the officials who do the confiscation to steal some of the equipment for themselves.

If equipment starts getting confiscated, there is an incentive for miners to hide their location, and become less of a target.

A campaign to confiscate mining equipment can be compared to the war on drugs. Much less than half of illegal drugs end up confiscated.

If a government is confiscating all the equipment, they need to host it somewhere. This location will be vulnerable to sabatoge. If there is a blackout, then the miners get shut off.

The location hosting miners, it needs to be operated by officials. Those officials are vulnerable to corruption. They can steal the equipment, or allow it to catch fire. They can participate in markets to profit from allowing their mining pool to fail.



Evil Mining Pool Attack
==========

Government does a soft fork to censor all tx types. No money can move.
They achieve this by hosting a mining pool and paying double rewards.

Usually this attack is paired with a circular argument based on the credible commitment to attack idea.
Start with the assumption that this attack will be successful, the utility of the cryptocurrency would decrease, so the mining rewards would decrease in value, and it would become cheaper and cheaper to pay double the block rewards to sustain the attack.

Circular arguments are a logical fallacy, so lets try to analyze what would really happen if this attack was attempted.

If all the txs are being censored, then that means the supply of new txs is zero, and the demand hasn't fallen as much. If the supply goes down and demand does not, then the price that people are willing to pay to publish a tx increases. The mempool will fill up with txs that pay higher and higher fees.

If someone thinks that there is a 50% chance that the attack will succeed, then they are willing to pay 50% of the value of their cryptocurrency as a fee in order to move their currency to a centralized exchange where it can be sold.

Each tx fee only needs to be paid once, but to continue the censorship the attacker's mining pool needs to pay a reward bigger than these tx fees for every single block.
So if the censorship attack continues for 1 week of 10-minute blocks, then the attacker is paying on the order of 1000x more to sustain the attack in comparison to how much value they are destroying.

Corrupt officials have an incentive to buy the underpriced IOUs on centralized exchanges, and then to allow the censorship attack to fail. So that they can convert the cheap IOUs into full value cryptocurrency.

Corrupt legislators have an incentive to buy the underpriced IOUs on centralized exchanges, and then change the law to end the censorship attack. So they can convert the cheap IOUs into into full value cryptocurrency.

Even though there is lots of money to be made by causing the attack to fail, there is a tragedy of the commons problem. No miner is incentivized to mine on a non-censored fork, because their blocks will immediately orphaned.
This tragedy of the commons can be solved by the existence of centralized markets to bet on when the censorship attack will fail.

A centralized market could allow betting that at a particular block height the censorship will fail.
This market will have some price connected to the probability that the attack will fail at that block height.

This market would be a way for holders of cryptocurrency who want to insure themselves against the possibility that their currency will be destroyed.
This market would also act as a way for corrupt officials to profit from causing the attack to fail.
This market would also act as a way to bribe legislators to change the law to end the attack.

Let C = how much the attack is paying for each empty block.

let B = potential miner rewards if they made an unorphaned block full of high fee txs.

let P = probability that the block is orphaned.

If C/B is around 1, then the attack is unsustainably costly. The attacker is paying thousands of times more than the value they are destroying. To be affordable, C/B needs to be a very small number, like 0.01 or less.

The incentive to mine on a block with txs instead of participating in censorship:

```B(1-P) - CP```

which simplifies to
```B-(C+B)P```

If this is positive, then they are incentivized to mine the block with txs inside. We can divide everything by B.

```1-((C/B)+1)P>0```

solving for P
```P < 1/((C/B)+1)```

plugging in the value of C/B that allows the attack to be affordable
```P < 1/1.001```
simplifies to
```P < 0.999```

So, if the probability that the attack succeeds ever falls below ~99.9%, it would become cost effective for miners to mine on the block that includes txs. The miners could use the market to purchase insurance to hedge the risk that the block does get orphaned. This solves the tragedy of the commons. Miners are incentivized to end the attack. 

If the probability that the attack will continue is >~99.9%, that means sabateurs or corrupt officials can multiply their money 1000x by causing the attack to fail. Legislature can multiply their money 1000x by changing the law to end the censorship attack.

So the existence of a counter-coordinating market, it ends the attack in all cases. Either it acts as insurance so that miners are incentivized to end the attack, or else it acts as an intense bribe to cause the attack to end.






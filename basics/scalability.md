Scalability
=============

A lot of people talk about scalability in blockchains, but it seems to me that there are lots of contradictory definitions of scalability floating around. The purpose of this document is to concretely define what "scalability" could mean, and to dispell some myths about what scalability cannot be.

A bit of background
=============

Back in 2015 Vitalik came up with the idea that he called the "scaling trilemma".
At the time, many people were proposing alternative blockchain designs that could process many more txs per second than bitcoin. These designs all tended to sacrifice other properties of the blockchain that users found essential. So, the purpose of the scaling trilemma idea is to point out that we shouldn't be sacrificing other important properties to acheive more transactions per second.

Today there exists a popular scaling strategy called "layer 2" or L2 rollups.
The idea is that the core blockchain stores headers for side-chains, and the transactions move onto these side-chains. The main chain provides security for all the side-chains, and the side-chains are able to contain many transactions without over burdening the main chain.

There are 2 classes of L2s: optimistic and ZK.
The difference is in how withdrawing money back to the main chain works. With optimistic rollups, there is a delay during which anyone can provide evidence to show that your withdraw tx is invalid. With ZK rollups, there is a cryptographic proof that the withdraw is valid, so you don't have to wait.

Economies of scale 
=============

Usually, when you do things on a larger scale, they get cheaper. a 48-pack of soda costs less per beverage than a single can.
This is true for computers as well. Renting a server with 2x the hardware costs less than 2x as much.
If you double the RAM in your hardware, then you end up having more than twice as much memory available. Because you only need to run one copy of the OS.
Similarly, if you buy twice as much bandwidth, this costs less than twice as much.

There is no limit to economies of scale with computers. The bigger your application, the cheaper it is per cpu cycle. If a single board isnt big enough, your can use clusters of computers that cooperate, and you still benefit from economies of scale.

Given that computers get cheaper when they are bigger, it seems natural that blockchains would get cheaper to use as they become bigger and more popular.

In practice, modern blockchains have limits for how many transactions per second they can process, and if you push the limits, fees end up getting higher, and quality of service gets lower. It takes longer for a transaction to get included. This creates the impression that modern blockchains have not yet achieved scalability.

This contradiction is happening not because of tech limitations, but rather from our poor theoretic understanding of blockchains that leads us astray. If we had proper theoretic foundations for blockchain tech, we would find that economies of scale make the system cheaper to use as it grows bigger.


False scalability: loss leader.
=============

Many people hold the mistaken impression that scalability means being able to achieve a large number of transactions per second, or having very low transaction fees.
But, achieving goals like that is not enough, if you need to be a loss leader to do it.
You can have lots of txs on the chain, and it seems popular, but the network is losing money on each tx, so it isn't sustainable, and eventually the system collapses.
By having a big block reward the transactions can be subsidized so fees stay low.
The cost of the system is shared to all holders, as the currency is being inflated. Instead of charging users tx fees, this kind of system is charging holders a wealth tax in the form of inflation.

This flavor of "scalability" has exactly the opposite of the incentives that you would want.
Investors in the system are subsidizing people who spam the system.

False scalability: lots of chains.
=============

There is this idea that a network is scalable as long as every individual node has finite requirements, and you can increase the transactions per second by increasing the number of nodes.
The problem with this version of scalability is that the amount of work per tx can be much higher than a normal blockchain like bitcoin. All the little blockchains need to talk to each other and come to agreements. This extra communication comes with extra costs.
Also, by keeping every individual node small, the system is unable to benefit from economies of scale.

False scalability: lots of full nodes.
============

There is a myth that a blockchain network is more decentralized if there are more full nodes processing the blocks.
As [Paul Sztorc explained](https://www.truthcoin.info/blog/measuring-decentralization/) decentralization isn't about having lots of full nodes.
Decentralization means it is cheap to launch just one more full node.
Because if the network is attacked, it only needs one full node to survive for the entire network to survive.
So, the cost of defending against an attack is proportional to the cost of launching just one more full node.

Because of many people reading Vitalik's "scaling trilemma" idea, and having this mistaken impression of what decentralization means, people end up thinking that any scaling strategy that prevents us from having tens of thousands of full nodes is a failure. This is part of the reason that the Ethereum community gives so much attention to L2 strategies.
By moving all the work to a L2, the main chain can stay super cheap, allowing Ethereum to have tens of thousands of full nodes.

Of course, having tens of thousands of full nodes is exactly the opposite of scalable. Every transaction is being processed tens of thousands of times unnecessarily. Someone is paying for the transactions to be processed so many extra times, and the cost is not being paid from the transaction fee.

Currently, it costs about $5 a month to run a bitcoin full node. Given that there are $2 trillion being secured by the bitcoin network, it seems like users would be willing to spend a lot more than $5 a month to save bitcoin from destruction, in the event of an attack.

On miner centralization
=============

Besides being attacked, a network can lose it's decentralization if one mining pool has too much of an advantage in comparison to the others, and too many miners join that one pool, resulting in the one pool consistently having >50% of the hashrate.

So, for a system to be scalable, it is important that the biggest pools don't have too much of a relative advantage over the smaller pools, even as the number of transactions per second is increased.

Mathematically, we calculate relative advantage of mining pools by comparing the fraction of their money that gets wasted. You can calculate how much of a given pool's money is wasted like this:
`(Total cost of running the mining pool, not including hashpower of miners) / (total value of block rewards and tx fees found)`
If this number is equal to 0.05 for example, that means the mining pool is consuming 5% of the block rewards it finds, before paying any of the workers.

If a small pool is wasting 5%, and a big pool only wastes 1%, then that means miners will earn 4% more by mining in the big pool.

For a blockchain to be scalable, it needs to be the case that increasing the transactions per second does not make the smaller pools relatively worse off in comparison to the bigger pools.

Does bitcoin have miner centralization scalability issues?
============

Imagine we doubled the size of bitcoin blocks, and the number of transactions, while keeping transaction fees and block rewards per transaction the same size.

So, both the big mining pool and the small mining pool end up being paid 2x as much.
And, they both need to pay a little less than 2x a much for their hardware and bandwidth to run the pool. (because fixed costs like the OS don't change.)

```
big pool     ($5)/($10000) -> ($9)/($20000) : 0.005 -> 0.0045
small pool   ($5)/($1000)  -> ($9)/($2000) : 0.05 -> 0.045

So, the relative advantage before was 0.05 - 0.005 = 0.045
and the relative advantage after is   0.045 - 0.0045 = 0.0405
```

Since 0.0405 is less than 0.045, that means the network is more decentralized after doubling in size.

So, normal bitcoin can already be scaled without causing miner centralization issues.
This implies that we don't need any L2 to be scalable. The system requirements of mining pools grow more slowly than the rewards. The system is already resistant to miner centralization scalability issues.

L2 are useful because they allow experiments to occur off of the main chain, where any damage from a failed experiment can be more contained. It is a sandbox, much like smart contracts.

It seems like L2 are not helpful for acheiving scalability goals.


What is scalability?
=============

A scalable blockchain achieves these goals:
1) the network does as little work as possible to process a transaction. 
2) the size of fee paid for a transaction is equal to the work that the network did to process that transaction. 
3) As the number of transactions per second increases, the amount of work that the network does per transaction does not increase.
4) as the number of transactions per second increases, the relative advantage that big pools have over small pools does not get worse.

If 2 different blockchains acheve all these goals, we can use goal (1) to say that one blockchain is more scalable than the other if it has lower fees per tx.



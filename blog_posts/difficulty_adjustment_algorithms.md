Difficulty Adjustment Algorithms
======================

Why do we need DAA? Blockchains need to produce blocks at a regular pace.
- we don't want too much space for transactions, as that makes out history grow too fast, and it can exceed the computational requirements of a full node.
- we don't want too little space for transactions, because the blockchain wont be able to serve all the users.
- we don't want too fast of blocks, because mining pools wont have time to propagate their work before starting the next block.
- we don't want destructive oscillations in the difficulty, because this causes our block rewards and transaction fees to be repurposed to give security to other blockchains.
- we don't want slow blocks, because it will take too long to get confirmations.

Satoshi's DAA
====================

Satoshi created the first DAA when he launched Bitcoin.
Satoshi's DAA runs only once every 2016 blocks.
We check how long it took to mine those 2016 blocks. We know how many hashes it would take to mine this many blocks, so, we can claculate how many hashes per second the network is currently calculating. From this, we can calculate how many hashes will be mined in the next 2 weeks. The difficulty is choosen so that we will find 2016 blocks in the next 2 weeks.

Ethereum Classic DAA
==================

G = genesis block difficulty
DT = how many seconds it took to mine block N.

Diff[N] = max(G, Diff[N-1]*( 1 + (max(-99, (1 - DT)/10)/1028)))

Bitcoin Cash DAA - ASERT
===================

Bitcoin Cash switched their DAA several times after forking off from bitcoin. They seem to be satisfied with their current algorithm, called ASERT.

They use deterministic tools to approximate this formula:

exponent = (time_delta - ideal_block_time * (height_delta + 1)) / halflife
next_target = anchor_target * 2^(exponent)

where:

* anchor block is the block where Bcash split from Bitcoin.
* anchor_target is the unsigned 256 bit integer equivalent of the nBits value in the header of the anchor block.
* time_delta is the difference, in signed integer seconds, between the timestamp in the header of the current block and the timestamp in the parent of the anchor block.
* ideal_block_time is a constant: 600 seconds, the targeted average time between blocks.
* height_delta is the difference in block height between the current block and the anchor block.
* halflife is a constant parameter sometimes referred to as
* ‘tau’, with a value of 172800 (seconds) on mainnet.
* next_target is the integer value of the target computed for the block after the current block.

Amoveo DAA
=================

Amoveo's DAA started as a copy of Bitcoins, but it had to be changed several times. The current algorithm has been working well for years, under a variety of conditions. Amoveo uses deterministic tools to approximate this.

Every block has a header. Full nodes and light nodes both need to download and verify all of the block headers.

For every header N, has a difficulty. This is the expected number of hashes you need to compute to mine this header. Diff[N]

For every header N, we calculate and store a value EWAH[N].
The EWAH is the Estimated Weighted Average Hashrate. It is an approximation of how fast we think the network was producing hashes, at the time that block was found.
We can calculate the EWAH of a header like this:

T = how much time passed between header N-1 and header N according to the timestamps on those headers.
```
Hashrate0 = Diff[N] / T
EWAH[N] = 20/((1/Hashrate0) + (19/EWAH[N-1]))
```

We use these EWAH values to calculate what the difficulty should be at each block height.
```
Estimate = Diff[N-1] / EWAH[N-1]

if (Estimate > (Diff[N-1] * 3 / 2)) {
   Diff[N] = Diff[N-1] * 3 / 2 / Estimate
} else if (Estimate < (Diff[N-1] * 3 / 4)){
   Diff[N] = Diff[N-1] * 3 / 4 / Estimate
} else {
   Diff[N] = Diff[N-1]
}
```

Theory behind Amoveo DAA
=================

http://hyperphysics.phy-astr.gsu.edu/hbase/oscda.html

If we model the difficulty of a blockchain as a harmonic oscillator, it becomes easier to see some of the kinds of problems that DAA can have.
If the DAA doesn't cause a friction type effect in the oscillator, then energy in the system is conserved. Oscillations can grow wildly.

Most DAA have certain frequencies that they are most vulnerable to. As the oscillations get worse, the vulnerable frequency gets slower. Because it takes longer for the blockchain to escape from the high-difficulty side of the oscillations.
If 2 blockchains are oscillating at the same frequency, then the miners start hopping back and forth between them. This usually causes mutually destructive interactions, and can result in the weaker of the two blockchains halting it's block production, once the cost of finding a block becomes much bigger than the reward for finding a block.
These oscillations can be beneficial for the larger or more stable blockchain. They can subsidize the security budget by buying cheap hashpower from the minority chain when its price is lower.

In physical oscillators, they keep moving because energy is conserved. The energy keeps transforming from kinetic to potential
In blockchain difficulty oscillators, something is conserved as well. When we are at the correct difficulty, the miners are changing strategy quickly. And when we are at the incorrect difficulty, there are incentives to bring us back to balance.

How do engineers deal with oscillations? They damp them, with friction. They apply a force in the opposite direction of motion. To calculate this force, it isn't enough to know where the harmonic oscillator is currently located. You need to know it's velocity as well.
With a normal harmonic oscillator, the position tells you the forces.
The damped harmonic oscillator, you need to know the position and the velocity (the derivative of position) to calculate the force.
For a blockchain difficulty damped harmonic oscillator, it isn't enough to know the current hashrate. You need to know hashrate and how hashrate is changing (the derivative of hashrate).

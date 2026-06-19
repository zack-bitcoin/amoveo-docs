

The purpose of this document is to make a rough design of what the harberger verkle tree will look like.

Global coordinates.
=============

They are three 16-bit signed integers.

They encode x-y-z coordinates of a grid centered at the planet's center. Z points in the direction of North, X in the direction of the latitude=0 longitude=0 point, which is in the Atlantic, on the equator, south of london. The Y points to the point at 0,90E, which is in the Indian Ocean, south of the bay of Bengal.

If you draw a line, starting at the center of the planet, and passing through your X-Y-Z coordinate, this line will intersect the surface of the planet at a point. That is the point we are encoding.

For example: [0,0,1] is the point at the north pole.

Great circles.
==============

Lines on a globe are called "great circles". The space of great circles on a globe is the same as the space of 2D planes that cut through the origin in 3D space.

Given a point on the surface of the globe, you can draw a line from the center of the planet through that point. Then, you can make a plane which is perpendicular to this line, such that the center of the planet is on this plane. This plane intersects with the surface of the globe in a great circle. This great circle is the line being encoded. So, the 3 coordinates for a point can also be used to encode a great circle.

For example: [1,0,0] is the point at the north pole, and it encodes the line that is on the equator.

Each great circle can be written in two ways. For example [1,2,-5] is the same circle as [-1,-2,5]. These are encoding for the clockwise and counterclockwise versions of the circle. In the land registry, this would cut a land plot on the same line, but, it makes a difference as for which side of the plot ends up on the left branch vs right branch of the binary tree in the consensus state.

Binary tree based on great circles
====================

The land plots are organized into a binary tree. Each time the tree branches on a great circle. The great circle is dividing the land. One side of the land is managed by the right branch of the tree, and the other side of the land is managed by the left branch.

Ethereum's merkle tree is organized based on the address of the account. If a bit of that address is a 1 or a 0, that determines whether that data ends up stored in the right or left branch of the tree. This means that it is impossible to store 2 different accounts under the same address.

The land verkle tree is instead organized based on physical location of land with respect to the great circles we have drawn on the planet. This means it is impossible to store 2 different land plots that overlap on the globe.

Since the only way to make a new land plot is by dividing old land plots, this tree doesn't have empty slots the way Ethereum's merkle tree does.

Vectorizing the binary tree
=====================

Each vector commitment is to 256 values.

The first 127 values are great circles on earth, the next 128 are verkle roots of branchs of the verkle tree, and the 256th commitment is unused.

So, each stem of the verkle tree is a small chunk of the binary tree, holding up to 128 nodes.

Even though the binary tree is full, the verkle tree is not. Sometimes a verkle stem holds less than 128 elements, because it hasn't been filled up yet.

Verkle efficiency
==================

Since this is using the same verkle tech as Amoveo's existing tree, it is important that the two verkle trees can share a bullet proof. That way, this second tree will not make Amoveo any slower.

Size of a verkle proof of land.
If there are 2^30 (about 1 billion) land plots, then we would require at least 30 steps in the binary tree, and 5 steps in the verkle tree.
Each step in the binary tree costs 128 bits. Each step in the verkle tree costs 512 bits.
(128 * 30) + (512 * 5) = 6400 bits, or 800 bytes.

If different transactions in the same block are using similar parts of the globe, then the overlapping parts of the verkle tree are only proved once.

Consensus state
================

Land plots 

* address of who owns this land. 256-bits
* the price of the land. 48-bits
* balance in veo. used to pay the continuous tax. 48-bits
* height. the last block height when the tax was subtracted from the blance. 32-bits
* distance between furthest two corners, including children. (used for calculating taxes)
* area, including all children. (used for calculating taxes)
* a list of points in it's children. The children are plots that border this plot and have the same owner, and are configured to be purchased as a set.

384+(48*N) bits.

Every time a land plot is accessed, the tax is paid.

Child land plot

* point in the parent it is linked to.

48 bits.

Stem in binary tree

* 48-bit great circle, used to divide the land between sides of the tree.
* 48-bit value of land in this part of the tree, measured in VEO
* 32-bit counter of number of land plots in this part of the tree (maybe we shouldn't include this.)

128 bits total

Transaction type
==========

Land transactions need these parts:

* account of creator
* nonce
* list of land operations 
* signature

After doing all of the operations, all account balances need to be non-negative, and the land balances need to be above the minimums.

kinds of land operations
===================

* price
  -if you own land, this is how you change the price of your land. Anyone can buy the land from you for its price. You pay a tax based on the price of the land, and how deep you are in the binary tree.
  - a location on the globe inside of your land encoded as 3 16-bit signed integers.
  - new_price

* tax
  -this is how you deposit money into your land plot. The money stored with the land plot is used to pay the continuous tax. If the land gets sold, this money is returned to you. There is a minimum amount of money required, based on the tax rate that the owner selected. 
  - amount to deposit/withdraw
  - a location inside your land.

* transfer
  -if you want to change which account owns your land. Money in the land is also transfered.
  - address of new owner.
  - a location inside the land.

* buy
  -used to buy land for the creator of this tx. 
  - a point inside of the region you are buying.
  - a new price after the purchase

* signed_buy
  -used to buy land for someone else. 
  - the max price the purchaser is willing pay per square meter.
  - great circles surrounding the area that they want to purchase in.
  - max and min number of square meters they will buy.
  - block height when this offer becomes invalid. expiration date.
  - new price after the purchase.
  - purchaser's signature 
  - a point inside of the region being purchased. (unsigned)

* split
  -as a land owner, you can split your land into parts, and put different prices on the different parts. The cost of a land-split is higher if your land is deeper in the land tree, so that we can incentivize keeping the tree balanced.
  - location inside of your land 
  - great circle used to divide the land
  - prices for the 2 new plots.

* join
  -if you own land plots that are side by side in the binary tree, you can combine them into a single land plot. This is the reverse of 'split'. you receive a reward that is proportional to the cost of a split at this depth.
  - a location inside one of the land plots.
  - price of the new land plot

* link
  -if you own land plots that are physically adjacent, and you don't want to sell one without selling both, then they can be linked. The new price is the sum of the old prices. The new balance is the sum of the old balances. This is also used to change which of your linked plots is the parent.
  - a point in the master land plot.
  - a list of points in child land plots that you want to link.

* unlink
  -the reverse of link.
  - a point in the master land plot.
  - a point in each child that is getting unlinked.
  - price of the child land plot
  - balance of the child land plot

* organize
  -Each land plot can be identified by the lines that surround it. So, the blockchain can verify that a reorganized binary tree results in everyone owning the same land. The resulting binary tree needs to be more balanced and less deep.
  -Linked land plots can be combined. The new price is the sum of the old prices.
  -individual land plots can be split in two, as long as the two new land plots are linked. 
  - binary data encoding the new structure for part of the tree.

((1, 2), (3, 4)), 4 leafs. adding the depths of each leaf makes 8.
(1, (2, (3, 4))), 4 leafs. adding the depths of each leaf makes 9.
The sum of depths is lower in the first example, so the first example is more organized.


If an account has a plot with children before a reorganization, and after the reorganization the plot and children all had different borders, how can the blockchain be sure that the new plot and children are identical?
Convert the plots into cycles of points, if you walk around them clockwise.
If two cycles share a pair of points in reverse order, then they can be combine into one long cycle. this is the same as putting two bordering land plots together into one big one.
If the new plot and children are identical, then the cycle of points will end up being identical.

If every owner's cycles are the same before and afer the update, then the update preserved everyone's properties.

One way this could fail is if after doing an organization, land owners are all incentivized to make transactions to optimize their tax strategy.
To prevent this kind of failure, we need to put rules on how the organizer chooses the parent lot in a group of linked lots. The organizer should be obligated to choose the parent such that the tax rate of the group is minimized. 

Off-chain data and flash loans.
================

Like, if there are 10 people who each want to buy a hectare for price X, and an owner who wants to sell 10 hectares as a single unit for price 10X. This is a way to make all 10 sales into a single transaction. Either all the land gets sold, or none of it does. This way, the seller doesn't have any risk of ending up holding just some of their land.

This also makes it possible to express complicated price gradients off-chain.
Your on-chain land might be worth a flat 10k. But, one corner of the land is worth 8k, and the rest is worth very little.
You could make an offer to buy the valuable corner for 8k from yourself, and then a prospective buyer could do a flash loan to buy the land for 10k and sell your corner of it back to you for 8k, and it only cost them 2k.

So, the complicated stuff about one corner of the land being worth more than the rest stays off-chain, but you still get all the benefits as if the data was inside the consensus state.


Attacks considered
=======================

What if an attacker divides their land up into such small parts, that the transaction for buying up the land is so big that it can't fit into a block?

The attacker needs to pay a fee for every time they split the land up. Defenders who buy the land and recombine it get paid this fee as a reward, because they are making the tree more organized.


Land Tax
====================

The ideal land tax is the land value tax, popularized by Henry George. Design decisions should always be made to try and better approximate the land value tax. This means we try to tax only the value of the land, and not the improvements on top.
To approximate the land value tax, we make a model to predict the land value, and we charge a higher tax on the portion of a plot's value that is below the prediction, and a lower tax on the portion of the value that is above the prediction.

But, we need to use a Harberger mechanism to set the prices. So that means the tax always needs to be increasing as the price increases. This is why we have a non-zero tax on the portion of the value that is above the prediction.

There is a minimum tax per land plot, to reflect the cost of having an entry in the database. This makes it costly to create plots that are excessively tiny.

We don't want it to be cheap to have long thin threads of land.
So, we need to charge a higher tax for plots that are long and thin.

The binary land tree holds some info at every node. Each node knows how many land plots are below it, and the total value of the land plots below it.
We can use this array of numbers to help approximate the land value tax.


P = predicted price of land plot according to a model of land value.
Q = price of land plot choosen by owner. (must be above a minimum price)
A = area.
D = distance of furthest 2 corners.
C1, C2 = constants choosen to set the tax rate.
H = How many fold less tax to pay on improvements, so the harberger mechanism works. (probably about 10)
B = How deep is it in the binary land tree?

Tax paid per block = (C2/(2^B)) + C1*min(Q, (P + (Q - P)/H)) * (D^2 + A)/(2A)

Global tax paid is at least C2 + C1*(price of world)

How to find the predicted price of land.
The verkle proof of the binary land tree tells us the total value, number of plots, and total area at each node of the tree.
If the verkle proof has n steps.
V[i], A[i].

P = A * (sum from i=1 -> n of V[i]/A[i]) / log2(total number of land plots in the system)

For linked lots, the tax is based on whichever property is the master.


Data Flow
=================

The blockchain includes a verkle proof. The results of verifying the verkle proof is a binary tree of land, that isn't completely filled in.

This binary tree gets edited while we verify the transactions.
Then, the final version of the binary tree gets batch-written to the verkle tree.



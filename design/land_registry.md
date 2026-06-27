
The purpose of this document is to make a rough design of what the cryptographic land registry will look like.


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

Each great circle can be written in two ways. For example [1,2,-5] is the same circle as [-1,-2,5]. These are encoding for the clockwise and counterclockwise versions of the circle. In the land registry, this would cut a land parcel on the same line, but, it makes a difference as for which side of the parcel ends up on the left branch vs right branch of the binary tree in the consensus state.

Binary land tree based on great circles
====================

The parcels are organized into a binary tree. Each time the tree branches on a great circle. The great circle is dividing the land. One side of the land is managed by the right branch of the tree, and the other side of the land is managed by the left branch.

Ethereum's merkle tree is organized based on the address of the account. If a bit of that address is a 1 or a 0, that determines whether that data ends up stored in the right or left branch of the tree. This means that it is impossible to store 2 different accounts under the same address.

The land verkle tree is instead organized based on physical location of land with respect to the great circles we have drawn on the planet. This means it is impossible to store 2 different parcels that overlap on the globe.

Vectorizing the binary land tree
=====================

Each vector commitment is to 256 values.

The first 127 values are great circles on earth, the next 128 are verkle roots of branchs of the verkle tree, and the 256th commitment is unused.

So, each stem of the verkle tree is a small chunk of the binary land tree, holding up to 128 nodes.

Verkle efficiency
==================

Since this is using the same verkle tech as Amoveo's existing tree, it is important that the two verkle trees can share a bullet proof. That way, this second tree will not make Amoveo any slower.

Size of a verkle proof of land.
If there are 2^30 (about 1 billion) parcels, then we would require at least 30 steps in the binary tree, and 5 steps in the verkle tree.
Each step in the binary tree costs 128 bits. Each step in the verkle tree costs 256 bits.
(96 * 30) + (256 * 5) = 4160 bits, or 520 bytes.

If different transactions in the same block are using similar parts of the globe, then the overlapping parts of the verkle tree are only proved once.

If we had instead used a binary merkle tree with a 256-bit hash for the same info, the proof would need (30*512) bits, or 1920 bytes.

The verkle tree is as small as a binary merkle tree with 69-bit hash would be.

Parcels
============

A valid parcel is made by drawing great circles on the world to cut it up. The act of cutting with lines always results in convex parcels.
Each parcel needs to have at least one representable point inside of it, otherwise it is too small, and that makes it invalid.

Titles
=============

Parcels can be linked together into titles.
Land titles, when sold, need to be purchased in their entirety. 
This way you can be sure that someone wont buy just 1/2 of your house, even if your house is split between two parcels.

A valid land title can have at most 8 corners.
If D is the distance between the furthest 2 corners of a land title, then it must be the case that `(D^2)/20 < Area`

For example, if the title is a rectangle that is 100 meters long diagonally, then it's area must be bigger than 500 meters^2, so it must be at least 5 meters wide.

Every time a title is accessed, the tax is paid.

Consensus state
================

Thinking of the binary land tree as our level of abstraction, there are 3 kinds of things we need to add to the consensus state: parent parcels, child parcels, and stems

parent parcels

Each title has one parcel that acts as the "parent". It stores most of the information related to the title, and pointers to the other parcels that make up the title. Every time a title is accessed, the tax is paid.

* address of who owns this land. 256-bits
* the price of the land. 48-bits
* balance in veo. used to pay the continuous tax. 48-bits
* height. the last block height when the tax was subtracted from the blance. 32-bits
* area 64-bits
* a list of points in it's children. The children are parcels that are connected to the parent and have the same owner, and are configured to be purchased as a set. 

448+(48*N) bits.


Child parcel

* point in the parent it is linked to.

48 bits.

Stem in binary tree

* 48-bit great circle, used to divide the land between sides of the tree.
* 48-bit value of land in this part of the tree, measured in VEO

96 bits total

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

An operation is only valid if it leaves all land titles valid. If an operation would leave a land title with 9 corners, then that operation is invalid.

* price
  -if you own land, this is how you change the price of your land. Anyone can buy the land from you for its price. You pay a tax based on the price of the land, and how deep you are in the binary tree.
  - a location on the globe inside of your land encoded as 3 18-bit signed integers.
  - new_price

* tax
  -this is how you deposit money into your title. The money stored with the title is used to pay the continuous tax. If the land gets sold, this money is returned to you. There is a minimum amount of money required, based on the tax rate that the owner selected. 
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
  -as a land owner, you can split a parcel into 2 new parcels, and put different prices on the different parts. The cost of a land-split is higher if your land is deeper in the land tree, so that we can incentivize keeping the tree balanced. 
  - location inside of your land 
  - great circle used to divide the land
  - prices for the 2 new titles.

* join
  -if you own parcels that are side by side in the binary tree, you can combine them into a single parcel. This is the reverse of 'split'. you receive a reward that is proportional to the cost of a split at this depth. 
  - a location inside one of the parcels.
  - price of the new title.

* link
  -if you own parcels that are physically adjacent, and you don't want to sell one without selling both, then they can be linked. The new price is the sum of the old prices. The new balance is the sum of the old balances. This is also used to change which of your linked parcels is the parent. 
  - a point in the parent parcel.
  - a list of points in child parcels that you want to link.

* unlink
  -the reverse of link. the resulting shapes need to be self-connected. 
  - a point in the parent parcel.
  - a point in each child that is getting unlinked.
  - price of the new title.
  - balance of the new title.

* organize
  -Each parcel can be identified by the lines that surround it. So, the blockchain can verify that a reorganized binary tree results in everyone owning the same land. The resulting binary tree needs to be more balanced and less deep. It is not permitted to make very parcels that don't have any internal points.
  -Linked parcels can be combined.
  -individual parcels can be split in two, the two new parcels are linked. 
  - binary data encoding the new structure for part of the tree.
  - how much money the creator of the tx gets paid as a reward for organizing.

((1, 2), (3, 4)), 4 leafs. adding the depths of each leaf makes 8.
(1, (2, (3, 4))), 4 leafs. adding the depths of each leaf makes 9.
The sum of depths is lower in the first example, so the first example is more organized.


If an account has a title before a reorganization, and after the reorganization the parcels in the title all had different borders, how can the blockchain be sure that the new title is identical?
Convert the parcels into cycles of points, if you walk around them clockwise.
If two cycles share a pair of points in reverse order, then they can be combine into one long cycle. this is the same as putting two bordering parcels together into one big one.
If the title is identical, then the cycle of points will end up being identical.

If every owner's cycles are the same before and afer the update, then the update preserved everyone's titles.

One way this could fail is if after doing an organization, land owners are all incentivized to make transactions to optimize their tax strategy. That is why we need to compute the tax individually for each parcel. So that owners can't change their tax rate by switching which parcel is the parent.

The organizer should choose which parcel to be the parent based on which parcel in the title is biggest.

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
To approximate the land value tax, we make a model to predict the land value, and we charge a higher tax on the portion of a title's value that is below the prediction, and a lower tax on the portion of the value that is above the prediction.

But, we need to use a Harberger mechanism to set the prices. So that means the tax always needs to be increasing as the price increases. This is why we have a non-zero tax on the portion of the value that is above the prediction.

There is a minimum tax per title, to reflect the cost of having an entry in the database. This makes it costly to create titles that are excessively tiny.

The binary land tree holds some info at every node. Each node knows how many land parcels are below it, and the total value of the titles below it.
We can use this array of numbers to help approximate the land value tax.


P = predicted price of title according to a model of land value.
Q = price of title choosen by owner. (must start at more than a certain limit per title)
A = area.
D = distance of furthest 2 corners in a title.
C1 = constant choosen to set the tax rate.
H = How many fold less tax to pay on improvements, (we need to pay at least some tax on improvements, so that the harberger mechanism works. This value should probably be about 10.)

Tax paid by a single title, per block = `(C1 * min(Q, (P + (Q - P)/H))`

Global tax paid is at least `(C1 * (price of world))` per block.

How to find the predicted price of land.
The verkle proof of the binary land tree tells us the total value, and total area at each node of the tree.
If the verkle proof has n steps.
V[i], A[i].

`P = A * (sum from i=1 -> n of V[i]/A[i]) / log2(total number of parcels in the system)`

This sum is re-computed for every parcel in the title, to find the total tax of that title.


C1 is for tuning the taxes. If C1 is too high, then there will be too many abandoned properties. If C1 is too low, then there will be absentee landlords aka speculators.

Data Flow
=================

The blockchain includes a verkle proof. The results of verifying the verkle proof is a binary tree of land, that isn't completely filled in.

This binary tree gets edited while we verify the transactions.
Then, the final version of the binary tree gets batch-written to the verkle tree.



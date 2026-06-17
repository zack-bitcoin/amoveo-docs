

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
(128*30) + (512*5) = 6400 bits, or 800 bytes.

If different transactions in the same block are using similar parts of the globe, then the overlapping parts of the verkle tree are only proved once.

Consensus state
================

Land plots 

* address of who owns this land.
* the total price of the land.
* balance in veo. used to pay the continuous tax.
* height. the last block height when the tax was subtracted from the blance.
* list of points that are in plots that border this plot. If the same address also owns those other plots, then these plots need to be purchased as a set.

Stem in binary tree

* 3 16-bit numbers encoding a great circle
* 48-bit value of land in this part of the tree
* 32-bit counter of number of land plots in this part of the tree

Transaction type
==========

Land transactions need these parts:

* account of creator
* nonce
* list of land operations
* signature

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
  -used to buy land. This tx can be included in a multi-tx, it needs to be signed by the purchaser. This way flash loans can be used to make land trading more capital efficient.
  - the max price the purchaser is willing pay per square meter.
  - great circles surrounding the area that they want to purchase in.
  - max and min number of square meters they will buy.
  - block height when this offer becomes invalid. expiration date.
  - new price after the purchase.
  - signature 
  - a point inside of the region you are buying. (unsigned)

* split
  -as a land owner, you can split your land into parts, and put different prices on the different parts. The cost of a land-split is higher if your land is deeper in the land tree, so that we can incentivize keeping the tree balanced.
  - location inside of your land 
  - great circle used to divide the land
  - prices for the 2 new plots.

* join
  -if you own land plots that are side by side in the binary tree, you can combine them into a single land plot. This is the reverse of land_split_tx
  - a location inside one of the land plots.
  - price of the new land plot

* link
  -if you own land plots that are physically adjacent, and you don't want to sell one without selling both, then they can be linked.
  - a point in the first land plot.
  - a point in the second land plot.

* unlink
  -the reverse of link.
  - a point in the first land plot.
  - a point in the second land plot.

* organize
  -Each land plot can be identified by the lines that surround it. So, the blockchain can verify that a reorganized binary tree results in everyone owning the same land. The resulting binary tree needs to be more balanced and less deep.
  -Linked land plots can be combined. The new price is the sum of the old prices.
  -individual land plots can be split in two, as long as the two new land plots are linked. They are each worth 1/2 the old price.
  - the part of the tree that needs to be reorganized.
  - binary data encoding the new structure for this part of the binary tree.

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

+ that is why when two properties are adjacent in the binary tree, they cannot be owned by the same account. Except as an in-between step during a flash loan.

What if an attacker divides their land up so small, that the transaction for buying the land is too expensive?

+ there is a cost to creating a new land plot. The cost is high enough, that the attacker ends up spending far more than their victim.


Land Tax
====================

The ideal land tax is the land value tax, popularized by Henry George. Design decisions should always be made to try and better approximate the land value tax.

There is a minimum tax per land plot, to reflect the cost of having an entry in the database.

The binary land tree holds some info at every node. Each node knows how many land plots are below it, and the total value of the land plots below it.
We can use this array of numbers to help approximate the land value tax.

The price of a piece of land can tell us a lot about what the land tax should be.



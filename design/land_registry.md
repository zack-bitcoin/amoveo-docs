

The purpose of this document is to make a rough design of what the harberger verkle tree will look like.

Great circles.
==============

They are three 16-bit signed integers.

These 3 16-bit signed integers encode x-y-z coordinates of a grid centered at the planet's center. Z points in the direction of North, X in the direction of the latitude=0 longitude=0 point, which is in the Atlantic, on the equator, south of london. The Y points to the point at 0,90E, which is in the Indian Ocean, south of the bay of Bengal.

If you draw a line, starting at the center of the planet, and passing through your X-Y-Z coordinate, this line will intersect the surface of the planet at two points. If we make a plane perpendicular to this line, and the plane intersects the middle of the planet, that plane cuts out a great circle on the planets surface. The X-Y-Z coordinates are encoding this great circle.

Each great circle can be written in two ways. For example [1,2,-5] is the same circle as [-1,-2,5]. These are encoding for the left and right handed versions of the circle. It is like, clockwise vs counterclockwise. In the land registry, this would cut a land plot on the same line, but, it makes a difference as for which side of the plot ends up on the left branch vs right branch of the tree.

Binary tree based on great circles
====================

The land plots are organized into a binary tree. Each time the tree branches on a great circle. The great circle is dividing the land. One side of the land is managed by the right branch of the tree, and the other side of the land is managed by the left branch.

Ethereum's merkle tree is organized based on the address of the account. If a bit of that address is a 1 or a 0, that determines whether that data ends up stored in the right or left branch of the tree. This means that it is impossible to store 2 different accounts under the same address.

This land verkle tree is instead organized based on physical location of land with respect to the great circles we have drawn on the planet. This means it is impossible to store 2 different land plots that overlap in physical space.

Since the only way to make a new land plot is by dividing old land plots, this tree is always "full". It doesn't have empty slots the way Ethereum's merkle tree does.

Vectorizing the binary tree
=====================

Each vector commitment is to 256 values.

The first 127 values are great circles on earth, the next 128 are verkle roots of branchs of the verkle tree, and the 256th commitment is to the total amount of money in this part of the verkle tree.

So, each stem of the verkle tree is a small chunk of the binary tree.

Even though the binary tree is full, the verkle tree is not. Sometimes a verkle stem holds less than 128 elements, because it hasn't been filled up yet.

Verkle efficiency
==================

Since this is using the same verkle tech as Amoveo's existing tree, it is important that the two verkle trees can share a bullet proof. That way, this second tree will not make Amoveo any slower.

Size of a verkle proof of land.
If there are 2^30 (about 1 billion) land plots, then we would require at least 30 steps in the binary tree, and 5 steps in the verkle tree.
Each step in the binary tree costs 48 bits. Each step in the verkle tree costs 512 bits.
(48*30) + (512*5) = 4000. 4 kilobytes.

If different transactions in the same block are using similar parts of the globe, then the overlapping parts of the verkle tree are only proved once.

Consensus state
================

The land plot consensus state data.

* address of who owns this land.
* the total price of the land.
* balance in veo. used to pay the continuous tax.
* height. the last block height when the tax was subtracted from the blance.

Transaction Types
===================


* land_price_tx
  -if you own land, this is how you change the price of your land. Anyone can buy the land from you for its price. You pay a tax based on the price of the land.
  - new_price

* land_tax_tx
  -this is how you deposit money into your land plot. The money stored with the land plot is used to pay the continuous tax. If the land gets sold, this money is returned to you. There is a minimum amount of money required, based on the tax rate that the owner selected. 
  - amount to deposit/withdraw

* land_buy_tx
  -used to buy land. This tx can be included in a multi-tx, it needs to be individually signed by the purchaser. This way flash loans can be used to make land trading more capital efficient.
  - the max price you are will pay per square meter.
  - great circles surrounding the area that you want to purchase in.
  - max and min number of square meters you will buy.
  - block height when this tx becomes invalid.

* land_split_tx
  -as a land owner, you can split your land into parts, and put different prices on the different parts.
  -great circle used to divide the land
  -prices for the 2 new plots.

* land_join_tx
  -if you own land plots that are side by side in the binary tree, you can combine them into a single land plot. This is the reverse of land_split_tx
  -price of the new land plot
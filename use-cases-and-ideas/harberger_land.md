Harberger Land Registry
===========

[Harberger land is an important feature so that the currency can have a stable large market cap of collateral available for contracts](basics/market_cap.md)

How to add new land to the system
===========

Adding your land to the registry is kind of like getting a reverse mortgage.
You are giving part of your land to the harberger system, so you need to get paid for this value you are adding to the system.

We can ask futarchy if giving new coins to someone in exchange for them adding their land to the system is going to increase the market cap.
If it would increase the market cap, then we do a hard update to pay them.

How to subdivide land
===========

These combinatorial markets suffer the problem that it is very computationally difficult to calculate what the price of trading should be.
So the harberger version probably will have the same limitation.
Gnosis innovated around this kind of auction. Their strategy was to let users propose prices, and have a rule to know which proposal is nearer to ideal.

The harberger version would have lots of people make bids, and there is a tx type where you could propose swapping out ownership of some land, and the blockchain would check if more taxes are being paid before or after the change of ownership.
So this tx type that is changing who owns which land, it could involve subdividing or combining plots.

Changing the tax rate
============

The main element I am not sure how to solve is how to change the tax rate fairly.

R = (The value of the land)/(the productive capacity of the land);
(percentage of land you own) = (R) / (R+T);

So changing the tax rate is equivalent to confiscating a portion of the land, or confiscating a portion of the currency.

It also isn't clear if a single global tax rate is best, or if it should vary by region.

If we just assume the laffer curve exists, then maybe we can let futarchy optimize to maximize the value of the currency.
So it will choose a tax rate that optimizes profits.

We could probably do futarchy for regions of the world, and impose regional tax variation to optimize tax revenue.

Maybe maximizing profit is too high of taxes.
We could try to target the tax rate where the laffer curve is 1/2, so taxes would be something like 1/3rd as much as what would optimize revenue.

Or maybe it is necessary to charge something less, to undercut competing land registry systems?
maybe maximizing revenue is important, because if there is a competition between land registries, the one with more profit has more value to use for competing.

Database of land
============

See code of the global database here: https://github.com/zack-bitcoin/harberger_global/

We need a deterministic version of spherical trigonometry. So I went with the gnomonic projection, because we are interested in great circles, and this projection maps great circles to lines on a plane. Dealing with lines on a plane makes the math we are interested in fast and simple. We can use the rationals.

The gnomonic projection makes it easy to calculate things like, the intersections of lines, or the line that joins two points. Because it is the same as rational geometry.
It also makes it easy to calculate the area of a partch of land.

Great circles are made when you intersect a sphere with a plane through the center of that circle. We are interested in great circles because they are the shortest distance between 2 points on a sphere. So, the borders of every land plot are great circles.

If we wanted global harberger land taxes, what would the database look like for assigning land ownership?
There is a point-line projective duality we can take advantage of. Every point on the sphere has an opposite point on the other side, and between the 2 opposite points is a line. like how the equator is a line between the north and south poles.
So if we have some coordinates to talk about a point on the sphere, those same coordinates can specify the line.
Instead of worrying about the points at the corners of a particular property, we should pay more attention to the lines that connect those points.
Every line is a great-circle that cuts the world in half.
These great circles are a good basis for the database, because as we walk down the merkle tree, each step can be a great circle that cuts the world in half, so that we are certain each of the 2 branches do not overlap at all.
Each location on the sphere can only be in 1 location in the merkle tree.

The equator gets mapped to the north and south pole, and is (0,0,1)
great circles that pass through the north and south poles, on lines of latitude, they coorespond to points on the equator, and in the projective plane they may to points that are very far from the origin. something like (9999999,0,1) or (0,99999999,1).

points at 45 degree latitude (so, in the northern hemisphere) correspond to great circles that pass through 45 degrees at their most northern location, and 135 degrees at most southern. So, locations like (1, 0, 1) or (0, 1, 1) or (-1, 0, 1) or (sqrt(2), -sqrt(2), 1)

In this format you might think that we can only refer to pairs of anti-podal points, so the points at 45 degrees latitude are the same as points at 135 degrees latitude. But, we can encode whether we are talking about the north or south hemisphere by making the 3rd coordinate of the point either negative or positive.
how many layers does the database need.
earth's radius is 6371 kilometers.
the surface area is 4*pi*r*r = 5.1*10^8 square kilometers. or 5.1*10^14 square meters.

each great circle is a binary split. so to divide down to 1 square meter, we need 48.8 steps of merkle proof.

If we use a merkle tree, then each step of the proof is 256*2 bytes of hash of children, and maybe 16 bytes to specify the great circle. = 528 bytes.
so a proof is around 50*528 bytes, about 25 kilobytes.

If we use a verkle tree, then it can be far shorter.

And that is the worst case scenario where we divided up the entire planet into square meter chunks. Assuming some people want to own more than 1 square meter, we can have shorter proofs.

Estimating the value of the cryptocurrency from the value of the land and the tax rate
======================

Starting from the tax free case.
The interest rate is I.
land produces F value per year.
So then, the land is worth price P=F/I. Because people will keep buying up the price of land until the profit from holding that land is the same as the background interest rate.

What if we charge a tax of T based on the value of the land?
So people will keep buying up the price P of the land until:  P = (F - (T*P))/I
-> PI + (T*P - F) = 0
->P(I+T) - F = 0
->P = F/(I+T)

So if the land in total is worth $12k. and the tax rate is 1/2 of the interest rate, then the price of the land would drop to around $8k.
if the tax rate is doule the interest rate, then the price of the land would drop to around $4k.
The land doesn't drop to zero value no matter how high the tax goes.


So where did the extra
   (F/I) - (F / (I+T)) =
   (F(I+T) - FI)/(I(I+T)) =
   F*T/(I*(I+T))
   of value go?
Assuming this money was burned, then the value became part of the market cap of the currency that is used to pay harberger taxes.

Bidding on land
==========

Bids on land stay off-chain until they are matched. We use Merkelized Abstract Syntax Trees (MASTs) to encode the bid.
That way, if you are interested in any 1 of 3 different properties for example, you could encode all 3 into a single bid. and if one of them becomes available, you buy just that one, and not the other two.

This is more liquidity efficient, because you only need to lock up your money in a single bid, not in 3 different ones.

To activate your bid, you make an on-chain transaction that includes the merkle root of the MAST.
You can cancel or change your bid with another transaction.

To activate a land transfer, someone makes a transaction that reveals part of one or more MAST bids, these bids together move land around such that people who lose land are paid what it is worth, and people who gain land pay less than how much they had bid, and people who gain land, they get the land according to the rules in their bid.



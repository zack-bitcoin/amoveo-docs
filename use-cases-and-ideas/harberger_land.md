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

If we wanted global harberger land taxes, what would the database look like for assigning land ownership?
I think there is a point-line projective duality we can take advantage of. Every point on the sphere has an opposite point on the other side, and between the 2 opposite points is a line. like how the equator is a line between the north and south poles.
So if we have some coordinates to talk about a point on the sphere, those same coordinates can specify the line.
Instead of worrying about the points at the corners of a particular property, we should pay more attention to the lines that connect those points.
Every line is a great-circle that cuts the world in half.
These great circles are a good basis for the database, because as we walk down the merkle tree, each step can be a great circle that cuts the world in half, so that we are certain each of the 2 branches do not overlap at all.
Each location on the sphere can only be in 1 location in the merkle tree.

So what I am trying to solve for now is what format should we use to refer to a particular great circle? I am pretty sure it is a 2-partnumber, but maybe both parts can be fractions, so it is better to make it a 3 part number where the 3rd part contains the denomenator part. 

We want to choose a format that makes it very easy to calculate the point where 2 great circles meet, and to calculate the great circle formed by 2 points.
The great circles on a sphere, they can be mapped to any planes that pass through the center sphere.
I think if we look at where these planes intersect the plane that is tangent to the sphere, and touches the north pole, then we can convert the complicated sphere geometry back to normal rational geometry, and maybe this is how we can get the best coordinates.
kind of like how the klein model turns hyperbolic geometry back to rational gemoetry, I think this projection is turning spherical geometry back to rational geometry.
so, the equator gets mapped to the north and south pole, and is (0,0,1)
great circles that pass through the north and south poles, on lines of latitude, they coorespond to points on the equator, and in the projective plane they may to points that are very far from the origin. something like (9999999,0,1) or (0,99999999,1).

points at 45 degree latitude (so, in the northern hemisphere) correspond to great circles that pass through 45 degrees at their most northern location, and 135 degrees at most southern. So, locations like (1, 0, 1) or (0, 1, 1) or (-1, 0, 1) or (sqrt(2), -sqrt(2), 1)

In this format we can only refer to pairs of anti-podal points, so the points at 45 degrees latitude are the same as points at 135 degrees latitude.
how many layers does the database need.
earth's radius is 6371 kilometers.
the surface area is 4*pi*r*r = 5.1*10^8 square kilometers. or 5.1*10^14 square meters.

each great circle is a binary split. so to divide down to 1 square meter, we need 48.8 steps of merkle proof.

Each step of the proof is 256*2 bytes of hash of children, and maybe 16 bytes to specify the great circle. = 528 bytes.
so a proof is around 50*528 bytes, about 25 kilobytes.

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



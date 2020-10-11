using governance
==========

We need to make futarchy markets before we update the governance variable, that way the community can come to consensus about what updates should be made.

The oracle is a reporting mechanism, it isn't made for coming to consensus. If you try to use it to come to consensus, it is like a game of chicken, and is bad for the network.

The basic idea of governance in Amoveo is called futarchy.
If you can show that a certain decision is good for the price of VEO, then the community makes that decision.

<!---

For example, you could make these 2 binary bets:
* "if update X is merged into Amoveo before block height H return bad, otherwise is the price of VEO below $100?"
* "if update X is not merged into Amoveo before block height H return bad, otherwise is the price of VEO above $100?"

You make an open offer to bet on both of them.
You bet on "true" for both.
You use the same odds for both bets.
If neither of these bets get matched for a period of time, that is evidence that the update would be beneficial for Amoveo

---->

For example, you could start by making the binary contract: "Hard update X merged before block height H?"

So the "true" shares are only valuable if we merge, and the "false" shares are only valuable if we do not merge. Lets call them T and F.

Next we use each of these kinds of shares as the source currencies to make markets for the price of veo relative to some stable asset. So now there are 4 more currencies:
TV, which is worth long-veo, but only if we merge the update.
TB, which is worth stable btc, but only if we merge the update.
FV, which is worth long-veo, but only if we do not merge the update.
FB, which is worth stable btc, but only if we do not merge the update.

So we have 2 important markets.
Market1 has 2 currencies: T and TV.
So the price of market 1, it shows what the price of long-veo would be, conditional on us merging the hard update.

Market 2 has 2 currencies: F and FV.
So the price of market 2, it shows what the price of long-veo would be, conditional on us not  merging the hard update.

By comparing the prices in market1 and market2, we can tell if this hard update will positively or negatively impact the price of veo relative to the stable currency.

This same technique can be used by any community of people who have a shared goal. They can ask the oracle how well their goal will be satisfied in 1 year time, conditional on which strategy they use.
So any community can find out which strategy would be most effective for them.


[more about futarchy here](futarchy.md)


<!---

for example, if you want to use futarchy to find out if we should merge an update
we should have 2 scalar oracles:
"if update is not merged, return bad. else, return the price of USD in VEO."
"if update is merged, return bad. else, return the price of USD in VEO."

Because if you make a bet in an oracle, and the result is bad, then each participant gets their money back that they had put in the bet.

using these 2 scalar oracles, we can show that the price of veo if we do the update is higher than if we don't do the update.

Scalar oracle 1 creates an asset that is the same value as VEO if the update is merged.
Scalar oracle 2 creates an asset that is the same value as VEO if the update is not merged.
By comparing these 2 assets, we can find out if the update is good for the price of VEO.

if there is simultaneously unmatched orders to long veousd if the update goes through and to short veousd if the update does not go through, and both of these are at the same price, we can have some confidence the price of veo will be higher if there is the update than if there is not.
since nobody wants to take the other side of those trades.

So here is a concrete example of a futarchy market:
```
if the block reward on 21 July at noon GMT is above 0.15 return 'bad', else { A = the price of USD in VEO from 0 to 0.3 on 21 July at noon GMT; B = the price of USD in Veo from 0 to 0.3 on 21 August at noon GMT; return ((0.15 - A + B) * 1024 / 0.3)}
if the block reward on 21 July at noon GMT is below 0.15 return 'bad', else { A = the price of USD in VEO from 0 to 0.3 on 21 July at noon GMT; B = the price of USD in Veo from 0 to 0.3 on 21 August at noon GMT; return ((0.15 - A + B) * 1024 / 0.3)}
```

For the above example, make sure that your futarchy bets expire before 21 July.

--->


Ending Contracts Early
===============

For Amoveo smart contracts to be scalable and efficient, it is best if we do not need to actually run the contract on chain, it is best if we do not need to use an oracle.

If the participants in a contract can agree on how that contract would be enforced, then they don't need to pay the cost of doing enforcement, and they can get their money out early.

Potential Failure Mode
==============

If the decisions of one user can cause another user to bear a cost, there is concern that the contract could be held hostage.
For example, if we have a contract together, and I lost the contract, that means that now you control almost all the money in the contract. You want to end the contract and get your veo out now, without needing to pay for an oracle.
I could refuse to cooperate in letting you take your money out of the contract, so that you need to pay for an oracle and wait days to see your money. I could demand that you pay me for my cooperation.

Mitigation 1 - split the bill
=============

The loser of the contract can still have a little extra money locked into the contract. A safety deposit to encourage their cooperation.
The amount of this deposit that gets returned to them is based on how quickly the contract ends.
The idea is that whatever interest rate costs the winner of the contract could need to bear, this cost should be split up 50/50 between the 2 participants of the contract.

This trick reduces the size of the problem in half. The maximum possible bribe that could be paid is 1/2 as large, and the symmetry makes it easier to analyze.


Game Theory Analysis
===============

There are 3 strategies.
1) fair split, no compromise.   Fair
2) holding money hostage.       Demands
3) giving in to ransom demands. Folding

```
_______ Fair   Demands Folding
Fair    0/0    -1/-1   0/0
Demands -1/-1  -1/-1   1-e/e-1
Folding 0/0    e-1/1-e 0/0
```

where `e` is a small bribe to encourage them to choose the Fold instead of the Fair.

Fold is better or equal than Fair everywhere, so we expect no one to use the Fair strategy in the case where this game is one-round. The Demand strategy is better or equal to Fold everywhere, so we can expect that we need to use an Oracle every time. People will never cooperate to end their contract early.

But, that is only true for the single-round version of this game.
Specialists can build up a reputation for never using the Fold strategy, for any size of bribe.
If a specialist has the other side of the trade, and you are certain that they are using the Fair strategy, then you are better off using the Fair strategy instead of the Demand strategy.
So, if you own the winning side of a contract, you can sell it to a specialist who has a reputation of never Folding, and you get almost all of the value out.




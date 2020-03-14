Derivative liquidation
============

A popular feature of financial derivatives is the "margin call", also called "liquidation".
A margin call is something that can happen to a financial derivative contract.
A derivative is an agreement between 2 entities to exchange value at a future date based on a publicly available piece of data, like betting on the price of bitcoin.

Some derivatives have a rule that the contract gets liquidated if the public data crosses a margin. That means that if the publicly available data goes outside the acceptable range, that the contract can get ended early.
For example, if we are betting on the price of BTC with leverage, and my side of the contract becomes worth 0, then we could end the contract at that point and my counterparty could take whatever leftover money is still available.

Margin calls are a popular tool in combination with leveraged derivative contracts, because the leverage provider's getting their money out earlier means they can react more easily to big price swings. So you don't need to pay as much to buy leverage exposure.

How this can be done in Amoveo
============

An Amoveo smart contract can reference thousands of oracles that have not been created on-chain yet.
Each oracle references the price of the underlying asset at a different second in time.
The contract says that if I can show any one of the oracles has a price outside our agreed upon price range for our derivative, that this activates the margin call, so I get all the money from the contract.

So if ever the price goes outside our agreed upon range, and you refuse to participate in the liquidation, then I only need to put that one oracle on-chain, and it enforces the correct outcome of our contract.

State channels can be programmed to exit more quickly if an oracle exists which shows that a margin call has occured.

Sortition chain contracts are fully transferable, even if the person on the other side of your contract doesn't want to participate. The margin call oracle only needs to be created if you actually win the sortition chain lottery.


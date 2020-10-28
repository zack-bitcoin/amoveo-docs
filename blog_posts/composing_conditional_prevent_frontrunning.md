Composing Conditional Contracts via Resolution to Prevent Front Running in Markets
==============

A conditional contract.
what it is:
Defined by it's source currency, how many subcurrencies it has, and a turing complete contract that determines how to divide the value between the subcurrencies.

How to use it:
If you give it the source currency, it gives you a complete set of it's subcurrencies.
If you give it a complete set of it's subcurrencies, it gives you the source currency.
You can provide evidence to help the smart contract resolve.
Once the smart contract has resolved, then you can exchange any of the subcurrencies to receive the portion of source currency that has been assigned to that subcurrency.

Front running prevention.
Some methods of preventing front running leave your market open to other attacks. The only secure way to do trading is with single price batches. Here is a great video on the topic: https://www.youtube.com/watch?v=mAtD0ba-hXU
I can give a quick summary.
According to game theory, any game can be pareto improved, while being converted into a honest reveal game, were everyone is incentivized to reveal their preferences. By "pareto improve", I mean that every player is no worse off, and possibly better off, after this change.
So the most efficient market is one where all the traders reveal the highest price they are willing to pay, and an automatic mechanism determines the most fair price for all the trades to get atomically executed.

We can't have single price batch markets on-chain.
Attempting to put single price batch markets on-chain causes vulnerabilities to miner extractable value MEV attacks. The miner can censor all the trades moving the price in a particular direction in their block in order to front run the entire blocks.

commit-reveal trading schemes to enforce single price batches markets are either insecure, because the attacker can make lots of commitments and not reveal the ones that aren't front-running.
or else the they are a usability nightmare, because you need to log on again after the delay to reveal at the right time, so you don't lose your safety deposit.

on-chain commit-reveal trading schemes are more expensive, because people often commit to making trades, but the price moves beyond the limit price they had agreed to pay, and so the trade doesn't get matched, but they still have to pay fees for the tx to get published on-chain.
by using a single price batch tool built inside of state channels, any trades that don't get matched, they never get recorded on-chain and you don't need to pay any tx fee for having made them.

After a trade has been matched in a batch, it is important that the trader and the market maker can get their new subcurrencies out of the state channel.
The market maker needs to use that money to allow other people to make state channels, so they can trade in single price batches too.
The trader needs to get their money out so they have the option of selling it early before the contract expires. The trader wants the option to spend the money to someone else, or trade with it in a different market, without depending on this particular market maker.
So this means that when the state channel smart contract resolves, it is potentially resolving into subcurrencies that represent either side of some other existing smart contract.

If a trade does not get matched, because the batch price is more expensive than the limit price, it is important that the trader and market maker are able to get their money out of that state channel quickly, and it is not trapped.
The market maker needs it to make channels with other people so other people can trade.
Te trader needs their money so they can spend it, or use it to make some other trade.
So this means that when the state channel smart contract resolves, it is potentially resolving into the source currency of some other exisiting smart contract. This needs to be the same currency which had been used to create this state channel.

It needs to be possible for a state channel smart contract to either resolve back into the currency that was used to create it, and it also needs to be possible for a state channel to resolve into 2 different new subcurrencies, which respresent either side of some other contract.

In order for a smart contract system to enable markets that are secure against front running, it is necessary that the smart contracts have composible resolution. Any smart contract can resolve into any other, as long as they are built of the same source currency.


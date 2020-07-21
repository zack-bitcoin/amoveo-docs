# The nature of smart contracts

# Smart contracts

A blockchain smart contract is a computer program that is used to determine how some money will get divided up among the participants.
For example, if you want to bet on the outcome of a sporting event, you could use a smart contract to enforce that the winner gets paid his prize, and the loser does not.

# Motivations

We want to have big liquid markets with single-price batch trading, so that we can trade our contracts at good prices.

We want it to be impossible for miners to front-run these markets by ordering the txs.
So this means the market smart contract needs to be inside of state channels.
State channels are a kind of smart contract that can be modified merely by consensus of participants in that contract, without needing to report any information to the blockchain or involve the miners.

We want to only lock up the minimum liquidity necessary to enforce the correct outcome, and only for the shortest period of time necessary.

### Limitations of a pure state-channel smart contract system

In previous experiments with state channels, the markets we had built had very serious liquidity issues.

For example, there was a server that hosted betting on a sporting event.
If Alice bets on team A, and Bob bets on team B, then there are 2 channels. Channel A is between Alice and the server. Channel B is between Bob and the server.

If the bet is for $100, then that means Alice can potentially win $100, and she can potentially lose $100, so her channel needs $200 locked in it. $100 is her money, and the other $100 is the server's money.
Similarly, Bob needs $200 locked in his channel.

So this means to support $200 of trading, the channels need a total of $400 locked up, and the server owns half this money.
The server needs to be ready for these channels to be updated at any time, so the $200 needs to be controlled by a hot wallet. That means there private key is on a computer connected to the internet.

The requirement of the server to lock up so much money makes it cost prohibitive to run this kind of market. The server would need to charge such high fees that no one would trade in this market.

Another liquidity issue with state channels is the situation where your channel partner is refusing to update the channel, and also the contract is not yet ready to be completely executed. In this situation it is impossible to get your money out of the channel until the contract can be completely executed. You can hedge your position by betting in the opposite directly, but that locks up even more liquidity in contracts.

### Flavored State Channels

The first half of our solution to the liquidity problem is to allow for channels to be denominated in other currencies besides VEO.

Looking at the same example of Alice and Bob betting on a sporting event.
This time, instead of making a $200 channel between Alice and the server, instead the server takes $200 and splits it up into 2 flavors of currency.
The server has 200 units of A-coins, which are only valuable if team A wins the sporting event, and the server has 200 units of B-coins, which are only valuable if team B wins the sporting event.

The server can have a channel with Alice that has 200 units of A-coins in it, and the server can have a channel with Bob that has 200 units of B-coins in it. The channels can be linked to atomically sell A-coins and B-coins simultaniously, so the server is never holding risk in the outcome of the sporting event.

In this example there are $200 of bets, and only $200 of money locked in the contracts, so the liquidity problem has been solved.

### Converting state channels to on-chain contracts

Another way liquidity can get trapped in the old version of state channels is if your channel partner goes offline, or refuses to cooperate with updating or closing the channel.
Channels can only be updated if all participants cooperate, or if you wait long enough for the smart contract to be completely executed.

For example, if you are betting on a sporting event, and the sporting event occured today, then you know who won. But it will take the oracle another week or longer to import the winning results into the blockchain to enforce the correct outcome.
In this situation you would like to get your money out of the channel now, and not need to wait a week to get it out.

Our new strategy is to allow for a state channel to be converted into an on-chain contract.
The two participants in the state channel, they each receive subcurrencies defined by the new on-chain contract. The subcurrencies have a value defined exactly the same as their positions in the state channels. The advantage of holding a subcurrency is that it can be spent without needing anyone else's permission. So this allows you to sell your position in a contract even if the contract has not completely executed yet, and even if your channel partner is refusing to cooperate.

# Mutable Contracts

Also known as "state channels".

Scalability plans today tend to involve [turing complete state channels](programmable_state_channels.md)

Putting the smart contracts into the channels gives many advantages
* speed - off-chain state can be updated as quickly as you can communicate with your channel partner. This is much faster than waiting for confirmations on-chain. If your partner is a server, you can use Amoveo smart contracts instantly.
* privacy - off-chain state can stay secret. As long as neither channel participant disappears or tries to cheat, they never have to publish the contract on-chain.
* atomicity - channels can be connected together so either both update, or neither does.
* secure against manipulations of miners - since channel contracts are updated off-chain, the miners are not involved at all. They have no way to manipulate a state channel contract to their advantage.
* scalability- parallel off-chain computation. The channel contracts are usually only processed by the 2 participants in the channel. Every pair of channel participants can be running different channel contracts simultaneously.

The majority of smart contracts will exist off-chain, inside of state channels, in the lightning network.

So, let's make the assumption that smart contracts will be in the channels, and let's use cryptoeconomics to try to predict what these contracts would look like. 
[Why we need markets.](why_markets.md)

Techniques like [hashlocking](https://en.bitcoin.it/wiki/Atomic_cross-chain_trading) are used to connect many channels together into markets.

The limitation of mutable contracts is that they have a finite list of participants, and everyone needs to sign off on every update.

To enforce the outcome of a mutable contract, it first gets converted into an on-chain shareable contract.

# Shareable Contracts

the limitation of shareable contracts is that they can't be changed.

A shareable contract has an source currency, and it creates 2 or more new subcurrencies.
Any of these subcurrencies can be the source of another shareable contracts. You can make mutable contracts out of the subcurrencies.

If you give some source currency to the shareable contract

a shareable contract creates 2 or more subcurrencies. you can split the parent currency into the child types. If you send all the child types to the shareable contract, then it converts them back into the source currency.

So an example of a shareable contract would be a stablecoin contract. We could split VEO into 2 types: one kind that follows the price of USD, and one that has double VEO volatility.

And anyone who owns both USD-stablecoin as well as the double-VEO, they could use this same contract to convert them back into normal VEO.

You can build a mutable-contract (a state channel) out of any kind of subcurrency defined by any shareable contract.

[you can learn about how shareable contracts are implemented here](shareable_contracts_implementation.md)

# conclusion

If you have a mutable contract, and they aren't cooperating, you just put a hash of the last smart contract on-chain, and it becomes shareable, so you can sell you stake as subcurrency, or make channels out of it with other people.

If you and someone else want to do something faster or at higher bandwidth than the blockchain offers, you can make a mutable contract out of any subcurrency in the system.

So smart contracts can switch types over time, depending on the needs of the users.

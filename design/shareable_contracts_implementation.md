Shareable Contracts Implementation
=============

Trees
=========

the shareable contracts use 3 trees: colored-accounts, colored-channels, contracts.

The colored-accounts and channels work almost the same as the existing accounts and channels trees. the only difference is that each element records which flavor of subcurrency is being stored.
The key to store a colored-account is hash(pubkey ++ contract id ++ subcurrency type).

the contract element remembers the hash of the contract that defines this shareable contract.
It remembers the total outstanding input currency that has been put into it (so we can be double-sure that it doesn't create output currency from nothing.)
It remembers how many kinds of subcurrency it produces from the input currency.
It remembers the kind of input currency that it can accept.

Tx Types
===========

* create a new shareable contract
* send some source currency to a shareable contract to have it divided into the new types.
* send all the types to the shareable contract to have them recombined into the source currency.
* run the smart contract to resolve the shareable contract.
* convert back to source currency based on the resolution price of the smart contract.
* create a channel priced in the subcurrency. (all the different kinds of channel txs need to work)

Contract Resolution
===========

There are a couple ways that the smart contract could resolve.
If the top of the output stack is a zero, then that means the contract is not ready yet.
Either more time needs to pass, or an oracle needs to resolve, or something like that.
It still isn't possible to resolve the contract.

If the top of the output stack is a 1, then that means one of the subcurrencies has won 100% of the value. The second element of the output stack specifies which of the subcurrencies gets all the value.
for example, if this was the output stack: [1, 0|_]
It would indicate that 100% of the value should go to the first subcurrency.

If the top of the output stack is a 2, then that means the different subcurrencies divide up the value between themselves. Say there are 3 flavors of subcurrency, then the stack could for example look like this: [2, 10, 15, 22|_]
This would mean that the first subcurrency has (10/(10+15+22)) = 10/47 portion of the value.
The second subcurrency has 15/47 of the value.
The third subcurrency has 22/47 of the value.
And anything else on the stack is ignored.
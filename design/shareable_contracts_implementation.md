Shareable Contracts Implementation
=============

Trees
=========

```
-record(account, {balance, nonce, pubkey, contract_id, type}).
-record(channel, {id, accounts_root, amounts_root, nonce, last_modified, delay, closed, contract_id, type}).
-record(contract, {code, many_types, nonce, expires, closed, result, veo}).%closed = 0 is still active, 1 is settled to source currency, 2 is settled into a different subcurrency.
```

%for contract record, the result has length depending on how many-types there are. How do we make this compatible with our merkle trees?

the shareable contracts use 3 trees: colored-accounts, colored-channels, contracts.

The colored-accounts and channels work almost the same as the existing accounts and channels trees. the only difference is that each element records which flavor of subcurrency is being stored.
The key to store a colored-account is hash(pubkey ++ contract id ++ subcurrency type).

the contract element remembers the hash of the contract that defines this shareable contract.
It remembers the total outstanding input currency that has been put into it (so we can be double-sure that it doesn't create output currency from nothing.)
It remembers how many kinds of subcurrency it produces from the input currency.
It remembers the kind of input currency that it can accept.

Tx Types
===========

```
-record(new_contract_tx, {from, nonce, fee, contract_hash, many_types}).
-record(use_contract, {contract_id, amount, veo_accounts}).
        %veo accounts [{pubkey1, amount1}|...] amounts need to sum up to amount.
        %amount can be positive or negative, depending on if we are buying or selling veo from the contract.
        %needs to be signed by all veo accounts.
        %the order of accounts determines who is buying/selling each type of subcurrency.
-record(swap_offer, {from, nonce, type1, type2, fee}).
-record(swap, {from, nonce, signed_swap_offer, fee}).%swap 2 kinds of currency of any type
-record(contract_offer, {contract_id, amount, pub, types}).%types is like [{0, Portion1},{2, Portion2}], where the integer is the type that the offerer wants to control, and amount is the portion of it that they want to control.
-record(contract_accept, {pub2, signed_offer}).
-record(resolve_contract, {contract, contract_id,  evidence}).%potentially unsigned tx.
-record(contract_timeout, {contract_id}).%possibly converts it into a new kind of contract.
-record(contract_winnings, {contract_id, type, pubkey}).
-new version of spend, how to handle fees?? probably paid in veo. allow stablecoin fees if miners accept them.
-record(new_channel_tx, {id, accounts_hash}).
-record(new_channel_accept, {from, fee, signed(new_channel_offer(from, fee, contract))}).
-record(channel_evidence, {id, accounts, signed{nonce, contract_hash, delay}}).
-record(channel_timeout, {id}).
```



Contract Resolution
===========

There are a couple ways that the smart contract could resolve.
If the top of the output stack is a zero, then that means the contract is not ready yet.
Either more time needs to pass, or an oracle needs to resolve, or something like that.
It still isn't possible to resolve the contract.

If the top of the output stack is a 1, then that means one of the subcurrencies has won 100% of the value. The second element of the output stack specifies which of the subcurrencies gets all the value.
for example, if this was the output stack: [1, 0|_]
It would indicate that 100% of the value should go to the first subcurrency.

If the top of the output stack is a 2, then that means the different subcurrencies divide up the value between themselves. Say there are 3 flavors of subcurrency, then the stack could for example look like this: `[2, 10, 15, 22|_]`
This would mean that the first subcurrency has `(10/(10+15+22)) = 10/47` portion of the value.
The second subcurrency has 15/47 of the value.
The third subcurrency has 22/47 of the value.
And anything else on the stack is ignored.

If the top of the output stack is a 3, then that means this contract is identical to some other contract. [3, Pointer|_], where pointer is the id of the shareable contract that this one is resolved into.


Finally, we always also output a nonce for the priority of this outome, and a delay for how long to wait for counter-evidence before resolving in this state.
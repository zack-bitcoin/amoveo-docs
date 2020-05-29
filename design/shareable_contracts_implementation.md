Shareable Contracts Implementation
=============

Trees
=========

-record(account, {balance, nonce, pubkey, contract_id, type}).
-record(channel, {id, accounts_root, amounts_root, nonce, last_modified, delay, closed, contract_id, type}).
-record(contract, {code, many_types, nonce, expires, closed, result, veo}).

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

-record(new_contract_tx, {contract_hash, many_types}).
-record(use_contract, {contract_id, amount, veo_accounts, type_keys}).%veo accounts [{pubkey1, amount1}|...] amount can be positive or negative.
%type_keys = [pubkeyA|...].
-record(resolve_contract, {contract, contract_id,  evidence}).
-record(contract_timeout, {contract_id}).
-record(contract_winnings, {contract_id, type, pubkey}).
-new version of spend, how to handle fees?? probably paid in veo. allow stablecoin fees if miners accept them.
-new version of channel_new tx.
-should all handle the new channel type: channel_solo_close, channel_team_close, channel_timeout, channel_slash

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
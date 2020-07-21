Shareable Contracts Implementation
=============

Consensus Merkel Trees
=========

```
-record(sub_acc, {balance, nonce, pubkey, contract_id, type}).
```

sub_acc is the tree for storing account balances in various kinds of subcurrency.
So if you own 2 different subcurrency, you have a different address for each, and they get stored as different elements in the merkle tree.
Even 2 different subcurrencies from the same smart contract have different accounts.

```
-record(contract, {code, many_types, nonce, last_modified, delay, closed, result, source, source_type, sink, volume}).%closed = 0 is still active, 1 is settled to source currency, 2 is settled into a different subcurrency.
```

Contracts exist in an active state for a period of time. Anyone can provide evidence for how the contract should enforce the outcome of the bet. The contract prefers the evidence that causes the smart contract to output a higher nonce. Eventually the contract settles on one evidence with the highest nonce, and changes to a closed state.

`code` is the hash of the bytecode that determines the result of the bet.

`closed` starts as 0, meaning that it is open, and eventually gets converted to a 1, when that contract is finalized.

`many_types` is how many flavors of subcurrency are defined by this contract.

`nonce` is the priority level of the highest-priority evidence that has been provided. The evidence is used to decide how this contract will enforce the outcome of the bet.

`last_modified` is how long ago the highest-nonced evidence had been provided.

`delay` is for how much time after last_modified that we need to wait until the contract can be closed in this state.

`result` is for how to pay owners of the subcurrency their winnings from the bet.

`source` and `source_type` define the subcurrency that this contract is priced in. For example, if a contract is priced in BTC-stablecoins, then that means you can convert 1 unit of BTC-stablecoins into a complete set of shares in this market, and you can convert a complete set back into BTC-stablecoins.

`sink` is used if a contract resolves into another contract. It is a pointer to where you get paid your subcurrency if you withdraw your winnings from this contract.

`volume` is a record of how much money is locked in this contract.

Even after a contract is closed, the `volume`, `result` and `sink` elements can still get changed.
`volume` can decrease as people withdraw their winnings from a contract. 
`result` and `sink` can change if this is a contract that settles by pointing to some child contract, and that child contract has also settled, and we simplify the result so that you can withdraw your winnings with a single tx and a small fixed sized number of merkel proofs.


Tx Types
===========

```
-record(new_contract_tx, {from, nonce, fee, contract_hash, many_types, source, source_type}).
-record(use_contract_tx, {from, nonce, fee, contract_id, amount, many}).
-record(sub_spend_tx, {from, nonce, fee, to, amount, contract, type}).
-record(resolve_contract_tx, {from, nonce, fee, contract, contract_id, evidence, prove}).
-record(contract_timeout_tx, {from, nonce, fee, contract_id, proof, contract_hash, row}).%possibly converts it into a new kind of contract. %possibly unsigned
-record(contract_winnings_tx, {from, nonce, fee, contract_id, amount, sub_account, winner, proof, row}).
-record(contract_simplify_tx, {from, nonce, fee, cid, cid2, cid3, m1, m2}).
```

`resolve_contract_tx` is for providing evidence for a potential way to close the contract, but it doesn't close it yet. It sets a delay timer.

`contract_timeout_tx` is for closing the contract, once the delay timer has run out.

`contract_simplify_tx` is for when a contract resolves into another contract, and they have both been closed. So now we want to update both contracts to be resolvable directly to the source currency, that way owners of any sub-currency can withdraw their winnings with one tx, and a small fixed sized number of merkel proofs.


Contract Resolution
===========

A smart contract's final state can be `[Nonce, Delay, PayoutVector|_]`, or it can be `[Nonce, Delay, ContractHash, Matrix|_]`.

The nonce determines how much priority this outcome has relative to others. The contract will resolve with whatever evience provides the highest priority nonce.

the delay determines how long to wait for counter-evidence before allowing the contract to close in this state.

If the contract is resolving directly to the source currency, then it outputs a `PayoutVector`. the length of this vector is the same as the number of subcurrencies defined by the contract. It is used to specify how to divide up the money.
N = (2^32) - 1
N is the biggest number that can be expressed in the 4-byte integer format used in the chalang smart contract language.
The sum of the elements in the `PayoutVector` must equal N.

If the contract is resolving to another contract that shares the same source currency, then it outputs a contract hash and a matrix.
If you own subcurrency N in the first contract, then you can find out which subcurrencies you own in the new contract by reading row N from the matrix.
So the height of the matrix is the number of subcurrencies of the first contract, and the width of the matrix is the number of subcurrencies in the second contract.

To maintain constant the total number of veo, each column of the matrix needs to sum to N. It is a kind of left stochastic matrix generalized to allow for changing dimensions.


Contract resolves to another contract
==============

Lets say there are 2 sporting events coming up, EA and EB.
you are confident in your ability to predict the outcome of both. So you make a bet where you win only if you are correct about both.

There are existing markets for EA and EB alone, but your market for EA && EB has almost no traders.

So, if oracle EA expired first, it would be nice if you could convert your shares of EB, and if oracle EB expired, it would be nice if you could convert your shares to shares in EA.

Once you have shares that are fungible with everyone else, you can participate in the bigger markets.


Another example
=======

Lets say there are several contracts for USD stablecoins: USD_A, USD_B...
we have multiple because they resolve at different expiration dates.

Alice and Bob want to have a contract ContractAB, and if it doesn't work, they want to be refunded.
Alice wants to be refunded the USD equivalent of what she had put in, and she wants it in the USD_* contract that will expire as soon as possible.

if ContractAB gets cancelled, Alice's tokens in ContractAB all get converted to USD_* tokens, which are totally fungible with all the other USD_* tokens, because their outcome is determined by the same USD_* on-chain contract.


A more computer science description.
========

Our contracts are very lazily executed. This allows us to avoid redundancy, because contracts that share code, they can wait and just run that code once for everyone. 
This also allows us to spread out a very long contract into multiple blocks. So your contract's size isn't limited by the availability of space in a single block.


Simplifying resolved contracts
===========

Let S be the vector of the subcurrencies you own in contract A.
Contract A uses matrix A to convert your subcurrencies into subcurrencies for contract B.
B goes to C, and C results in a payout vector = C which converts subcurrencies into an integer value of how many Veo you own = V.

So the formula is 
SABC = V.

Matrix multiplication is associative.
So the payout vector for contract A is (ABC).
The payout vector for contract B is (BC).

The matrix that takes subcurrencies from contract A to contract C is (AB).



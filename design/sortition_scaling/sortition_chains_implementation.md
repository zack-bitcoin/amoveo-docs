Sortition Chains Implementation
============

[sortition chains home](./sortition_chains.md)

tx types
====

1) sortition new

* creates a new sortition chain.
* pubkey who initially owns all the value.
* amount of money for the lottery prize.
* expiration date for when it it becomes possible to make sortition-claim-txs for this sortition chain.
* pubkey of who will be the validator for the new sortition chain.

2) sortition claim

* show what height at which you had a claim to the winning part of the probabilistic value.
* You pay a fee based on how many claims are already listed for this sortition chain.
* this potential winner gets added to a list of potential winners
* you can only do this if your sortition claim will have the highest priority.

3) sortition waiver

* which potential winner did not win.
* a signed waiver showing that they gave up control, with a contract hash.
* they get removed from the list of potential winners, but their `candidate` element is still in the merkle tree, this prevents them from giving the same evidence again to spam the blockchain.
* you can only do this for the claim that is currently at the top of the priority list.

4) sortition contract

* which potential winner did not win.
* a merkle proof showing that their winning is dependent on the result of a particular contract hash.
* a contract which matches the hash that they had commited to. The result of processing this contract needs to show that they did not win.

4) sortition timeout

* whichever potential winner has the highest priority claim to win, they win the lottery.
* a claim linked to an earlier block height has higher priority.
* this tx can only be made if you wait a sufficient amount of time after the RNG to choose the winner was generated.

5) sortition block

* validator for a sortition chain signs a root hash of some state about who can potentially own parts of the probabilistic value space.

6) sortition final spend

* if your money in the sortition chain is frozen, you have a chance right before the sortition chain finalizes to sell your money out, that way you don't need to hold any lottery risk.

7) rng result tx

* contains 129 hashes, evenly spaced along the progress of computing the vdf.
* then you pay a safety deposit assigned to your pubkey.
* points at a sortition contract

8) rng challenge tx

* which of the 128 gaps are we claiming is invalid?
* points at a result or response.

9) rng response tx

* contains 129 hashes, evenly spaced along the progress of computing the vdf.
* points at a challenge.

10) rng confirm tx

* if no one can prove that the result is false within a certain time period, we default to considering it as the correct rng output. (check that radix > 0).
* it is not possible to do a sortition_claim_tx until after the rng_confirm_tx has finalized the RNG that will be used for that sortition chain.

11) rng refute tx

* if this gap has less than 1000 hashes, the result is computed on-chain, if there is a disconnect in the 1000, then we consider this rng result as invalid.
* OR if a challenge doesn't get a response for too long a period of time, we consider this rng result as an incorrect rng output.
* if you did a challenge or response, and the evidence you had provided is consistent with the eventual outcome of that RNG, then you can have your fee refunded, plus a small reward.

11) rng_cleanup_challenge

* show that some rng_challenge exists that points at a rng_result.
* show that a rng_result is settled, or that it does not exist.
* we can get rid of the rng_challenge.
* refund fees for users who participated honestly.


Potential Timeline of txs for a sortition chain
=============

There are 6 phases in the sortition process.

trading -> final spend -> rng calculation -> sortition claims -> sortition evidence -> sortition result

Trading
===========

someone creates a new sortition chain with sortition_new_tx,

now there is a delay where people can make smart contracts in the sortition chain. 

sortition block, sortition block, sortition block,

sortition block txs are used to update the state of each sortition chain

Final Spend
==========

the sortition object has a number written in it, sortition.trading_ends.
At this block height, all sortition chains descended from this one are frozen. Now there is a delay so everyone can have one last chance to spend their veo from the sortition chain.
The delay continues until block height sortition.entropy_source

RNG Calculation
=========

rng response,

It becomes possible to calculate the RNG, and someone reports it to the chain. Now starts a period of time when it is possible to make challenges txs and response txs on top of this in a tree.

during this period, if any challenge goes unresponded for too much time, then the parent rng_response of this tree of possibilities is marked as invalid. Whoever had posted it has failed to defend its integrity. 

rng_challenge, rng_challenge, rng_response, rng_response.

eventually enough time has passed that it becomes possible to do rng_result txs and finalize the RNG being generated.

rng_result_tx

this finalizes the rng value calculated for the sortition chain. Now we can start the dispute process for who won the sortition chain.

Sortition Claims
===========

sortition claim,

Anyone can try to provide evidence that they are the winners of the sortition chain. This creates an on-chain object called a sortition_claim.

Anyone can provide evidence to show that a sortition claim is invalid.

There is a delay programmed into the sortition chain object to determine how long this period lasts.

sortition evidence
===========

Now it is not possible to make new sortition claims. But it is still possible to provide evidence to show that existing claims are invalid.

There is a delay programmed into the sortition chain object to determine how long this period lasts.

Sortition Result
==========

Whoever has the highest-priority claim that wasn't invalidated, they can now move the money from the sortition chain into their account.
This ends the sortition chain.


New Merkel Tree Data Structures in the Consensus State
============

1) sortition

* range of probability space that could result in a winner
* where the source of randomness is measured.
* pubkey of who created this sortition chain


2) sortition blocks

id is the 32 bytes being stored.

* arbitrary 32-bytes.
* the height where this was recorded.

3) candidates


for every potential winner there can be multiple layers of sortition chains in their proof that they won.
for every layer of sortition chain, we need to remember a priority height as well as a list of pubkeys of accounts assigned to collect evidence for when users give up ownership of parts of that layer.

the priority height is the block height when this data was commited into the blockchain. Earlier heights are higher priority.

consensus state consumed O((number of potential winners)*(# layers of sortition chains deep)*(# accounts assigned to gather evidence in each layer))

each pw_root contains a pubkey of who could win.

so, every pw_root will point to the next pw_root in the linked list. it is ordered based on priority.
and the pw_root also points to a pw_layer.

The rule for comparing the priority of 2 branches.
If the top layer is not a tie, then the winner has higher priority. If it is a tie, go to the next layer.

You can only add a potential_winner if it is higher-priority than the current highest.

  potential_winner_layer

id is hash(sortition id, potential_winner pubkey, layer depth #)

each pw_layer contains a priority height for that layer.
It has the root-hash

If someone can demonstrate an alternative way to close this layer that results in a higher priority height, then we can know that this potential_winner did not win.

4) rng_challenge
- id of this challenge
- id of result being challenged
- id of a parent challenge, if it exists
- id of the sortition chain this is related to.
- pubkey of who made this challenge
- hashes. this is the root hash of the checkpoints, once a rng_response_tx is done to provide the checkpoints.
- start hash. this is the beginning checkpoint of the part we want them to prove.
- end hash. this is the final checkpoint of the part we want them to prove.
- many. how many hashes are in this challenge.
- timestamp
- if refund was paid
- which of the 128 gaps is being challenged.


Starting at the sortition object as the root, there is a tree that starts with rng_result, and then has one or more branching trees of rng_challenges coming from it.
The sortition object can have multiple responses. the responses can have multiple challenges, and the challenges can have multiple challenge descendents.

5) rng_result
- id of this response
- id of the sortition chain
- pubkey of who made this response
- has a merkle root for 128 hashes of the vdf
- a pointer to the next possible result in the queue
- is this result proved impossible?
- is this result confirmed as true?


Claim Proof
============

A baby sortition chain won the sortition chain if all N of the operators have a signed a merkel root giving the baby sortition chain control of the winning part of the sortition chain.

An account won if all N of the operators for the winning sortition chain have signed a merkel root that gave that account control of that part of the probability space.


Timeline for horizontal payment
============

I want to send veo I own inside a sortition chain to you.

SortitionLine = [{me, true}].

I ask the validator to make you send in line.

SortitionLine = [{me, true}, {you, true}].

I send you my signature over a waiver saying that I am giving up control of this part of the sortition space.

SortitionLine = [{you, true}].


Timeline for horizontal payment + atomic swap
=============

I want to send veo I own inside a sortition chain to you, and receive alt-coins from you in return, trustlessly.

SortitionLine = [{me, true}].

I generate the secret that will be used to unlock the payment.

I ask you to sign something saying you give up ownership of my value, and it is only valid if the secret is not revealed on the main-chain in a proof of existence tx before a certain height. This means that if you commit the secret on-chain, that will give you ownership.

I ask the validator for my sortition chain to make you second in line to own my money, and I ask them to make me third in line, using a different pubkey.

SortitionLine = [{me, true},{you, "secret not revealed on main chain"},{me, true}].

I send you my signature over a contract with my new pubkey. it gives up my spot as 3rd in line, if you know the secret. (the secret does not need to be on the main-chain)

SortitionLine = [{me, true},{you, "secret not revealed on main chain"},{me, "secret not known to you"}].

I send you my signature to give up my spot as first in line.

SortitionLine = [{you, "secret not revealed on main chain"},{me, "secret not known to you"}].

We can make a contract on some other blockchain so that you will give me value if the secret is revealed.

I reveal the secret to you.

SortitionLine = [{you, "secret not revealed on main chain"}].

You generate a new address, and show the secret to the validator. They make your new address next in line to own the sortition chain value. (if they refuse, then you need to publish the secret on-chain).

SortitionLine = [{you, "secret not revealed on main chain"},{you, true}].


Timeline for vertical payment
===========

Bob has veo in a sortition chain, he wants to spend to Alice, and he wants the option to hashlock this payment against something else.

1) Bob gives a signed message to the operators explaining that he wants to convert his account into a baby sortition chain. He gives the new list of operators for the new sortition chain. This message gets committed on-chain by the operators.

2) Alice downloads all the merkel proofs for the sortition chain, so now she knows about the baby sortition chain.

Bob owns 100% of the value in the new sortition chain, so he can do horizontal payments like normal.







<!-----



Data the sortition chain operator needs to store
=============

1) We need to store all the merkel proofs so that we can prove to users that parts of our probability space are unowned.

```
(number of elements in your sortition chain) * (number of blocks that the sortition chain exists for) * (number of ancestors between you and the main chain) * (size of a merkel proof in bytes)
1000 * 2k * 6 * (32 bytes * log2(1000))
```
is like 0.64 gigabyte of data per sortition chain



for each user, merkel proof of that sortition contract such that it is stored based on the part of the probability space that results in this sortition contract winning the lottery.
```32 * log16(#of live sortition contracts)*(# of live sortition contracts) bytes```
So if there are 1000 users, and about 1 trade happens per second, and the sortition chain lasts 2 months, then this will take up 32*log16(1000)*5000bytes = about 400 kilabytes per user, or 400 megabytes for everything.

2) for every sortition contract that has existed in his sortition chain, he needs to store a signed message where the user has agreed that the old version of the sortition contract is invalid. The signed message has a commit-reveal. He also needs to have the secret which was revealed for this commit-reveal.

signature + contract hash + commit + reveal
```(about 250 bytes) * (# of sortition contracts)```
If there are 10k users over the cource of the 2 month period, we are looking at 2.5 megabytes of data.

3) a copy of every live smart contract with every customer, the customer's signature over the contract.
Generally a market's contracts are repetitive, so each can be comopressed to 100 bytes or so. The signature is like 150 bytes.
So if there are 1000 live sortition contracts, this database takes up around 250 kilobytes.


Collapsing spend proofs
=============

For example, lets say that you are running a sortition chain, and one of your customers controls 10% of the value in your sortition chain.
This customer makes thousands of tiny payments per day, spending and receiving fractions of a percentage of the sortition chain.

We don't want to have to store a seperate spend-tx every time this one customer spends more of the value they own in the sortition chain.

So lets say they own [0.15, 0.2].
At first the spend tx could give up ownership from [0.15, 0.155], and then we could make a new spend tx to give up ownership from [0.15, 0.16].
The new tx includes the same range of coverage as the old, so we do not have to store the old one any more.

This is why we only need to store one spend tx per pubkey being used in our sortition chain.

Data the Users Need to Store for a small wallet
==============

1) for your sortition contract, you need to keep a copy of the most recent contract state signed by the sortition chain operator. So 150 bytes of signature, plus however long your smart contract is.

2) you need the keep a merkel proof showing when your sortition contract was first created. You can use this proof to punish the sortition chain operator if they try to double-spend your money.
256*(log16(number of sortition contracts in your sortition chain)) = about 1280 bytes.

3) you need to download a merkel proof of the part of the probability space that you want to buy. You need this proof for every merkel root that the server recorded on the main chain from the start until when your contract was first created.
You don't need to store this, you just verify it once.
512*(log2(#users)) * (number of blocks in the sortition chain) = about 3 megabytes.

4) you need to keep a copy of the txs of anyone else who had previously owned part of the probability space that you now own, so if they try to claim it, you can stop them by showing that they gave up ownership.
For a small account, this is probably about 10 signed txs with short contracts. Around 20 kilobytes.


Lightning Sortition Contract Creation
===========

a 2.2 secure way to do a lightning payment to create a new sortition contract.

But it can only work if
* you have an existing sortition contract capable of accepting as much value as you will control in the new sortition contraxt
* there is a lightning path between you and the person that you want to make the new sortition contract with.

The trick is that if you want a new sortition contract, then you just buy insurance against the possibility that it will not get created.
You use an existing lightning path to buy this insurance.

Once the sortition contract is created, then the insurance contract can never pay out, so it can be deleted.

The cost of buying insurance is far less than the volume of money that can be held in your sortition contract, because you can buy an empty contract.

The cost to the server is (6 block periods of confirmations) * (interest rate) * (amount of money which you will be able to receive I the new sortition contract)

So this is a way to instantly increase the amount of value you can potentially receive in sortition contracts more than 1000x, within a few confirmations, trustlessly.

But, you need an existing sortition contract before you can do this trick.

The value that you control in the sortition contract that is about to be created needs to be less than your total insurance coverage.
Your total insurance coverage needs to be less than the amount of veo you could possibly receive in existing sortition contracts.

Mixing Merkel proofs with contracts
=========

We want the merkel proof to be a proof that the server has not double-spent your part of the probability space. So we need bits of software in every branch of the merkel tree.

A merkel proof looks like this.

```proof = [stem, stem, stem, leaf];
leaf = {address, contractID};
address - this is the address of the person who owns the sortition contract being proved.
stem = {chalang_bool, evidence, hash1, hash2} // if chalang_vm(evidence ++ chalang_bool) returns true, then hash1 needs to match the hash of the next element of the proof. if it returns false, then hash2 needs to match the next element of the proof.
// chalang_bool - this is some chalang code. It outputs 2 values. the first is a true/false for which branch of the merkel tree is being executed. 0 is false, any other value is true. The second value is the nonce for this version of the contract.
```

We need to keep track of gas while verifying merkel proofs, since the chalang_bool step is turing complete.

example chalang_bool contracts:

`int 7 int 13 rand_bit` This contract has a 7/13th chance of returning `true` and a 6/13th chance to return `false`

`OracleID oracle_lookup dup int 2 == if int 3 int 4 rand_bit else drop drop then` This contract returns `true` if the oracle is `true`. it returns `false` if the oracle is `false`, and if the oracle is `bad_question`, it has a 3/4ths chance of being `true` and a 1/4th chance of being `false`.



So lets make a very concrete example of a merkel proof.
Lets imagine Bob bought a contract worth $20, and the sortition chain has $1000 in it.

rand_int is a new function we need to add to chalang. it takes 3 integers as input, and uses the random seed embedded into the merkel proof verifier for entropy.

rand_int ( A B -- true/false )

It is required that A =< B.

It has an A / B probability of returning true, and (B-A) / B probability of returning False.


[{stem, [], compile("int 1 int 100 rand_int"), hash1, hash2},{stem, [], compile("int 1 int 2 rand_int"), hash3, hash4}, {stem, [], compile(" OracleID0 oracle_lookup dup int 2 == if int 1 int 2 rand_bool else drop drop then "), hash5, hash6}, {address, contractID]

where

```
hash1 = hash(compile("int 1 int 2 rand_int") ++ hash3 ++ hash4;
hash4 = hash(compile(" OracleID0 oracle_lookup dup int 2 == if int 1 int 2 rand_bool else drop drop then ") ++ hash5 ++ hash6;
hash5 = hash({address, contractID});
```

and given the random entropy programmed into this sortition chain, the "int 1 int 100 ran_int" contract needs to return true, and the oracle needs to either return true, or it's bad question version needs to randomly select true. and the "int 1 int 2 rand_int" contract needs to return false.

So this is a contract that has a 1/200th the value of the sortition chain it is a part of, and it is a winning bet in an oracle.


entropy for contracts
=============

If our merkel tree has multiple tiny contracts, it would be inefficient to re-load the block hash into the random number generator over and over for every contract. and it would be bad if we re-used the same random bits on multliple contracts, because that could cause correlation between the multiple layers, so some lottery tickets would be worth double what we had intended, and other lottery tickets will be worth nothing.

example tree update
============

`operator` is who made the merkel tree

tree starts empty, which means 100% chance it goes to the operator. `operator`

Bob buys 1% of the value`{"int 1 int 100 int 1 rand_bool int 1", bob, operator}`

Alice buys 2% of the value `{"int 1 int 100 int 1 rand_bool int 1", bob, {"int 2 int 100 int 1 rand_bool int 1", alice, operator}}`

Carol buys 1% of the value `{"int 1 int 50 int 1 rand_bool int 1", {"int 2 int 100 int 1 rand_bool int 1", alice, bob}, {"int 3 int 100 int 1 rand_bool int 1", carol, operator}}`

The key to look up your name in the merkel tree is any entropy value and oracle values such that you would win.
By using that as the key, the sortition chain operator is free to rewrite the contracts as necessary to keep everything in balance.

the rules for updating the tree need to be deterministically defined somewhere, that way anyone syncing the sortition-blocks will calculate the same root.


Contract Table
=========

Many contracts are appearing repeatedly. So we should keep a single copy of them in a different table, and refer to them by hash.
For example, if 4 people are betting on 4 mutually exclusive outcomes, the tree could look something like this:
```
{Contract1, {Contract2, Alice, Bob}, {Contract2, Carol, Dan}}
```
If contract1 and contract2 are both long, then it is best to avoid having to write one of them out twice in the database.



---->
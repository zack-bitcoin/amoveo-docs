Amoveo Smart Contract Creation
================

This document is not about tx types or how to use existing contracts. It is about when and where smart contracts are created.

Smart Contract Basics
=========

Before we get started explaining how the smart contract is built, lets review what the smart contract is computing.

A smart contract calculates how we will divide up the collateral value between the 2 or more subcurrencies for this contract.
Every time someone provides evidence to the smart contract, the smart contract produces 3 values:

* a priority nonce.
* the ratio of how to divide up the subcurrency between the owners.
* a delay for how much time the other users have to provide evidence before the contract can be finalized to this state.

Smart Contract Creation Parts
============

There are 4 different times when the smart contract is being made. For clarity, they are explained in this document in this order.

1) writing oracle questions 
2) the smart contract can have rules for what is a valid oracle question. This is a kind of macro for building oracle questions. 
3) When the MAST merkle root gets recorded on-chain. 
4) When it is decided which branches of the MAST to publish. A valid trace of the MAST.

This is not in time-order. Steps (2) and (4) happen at the same time.

Each of these 4 steps is turing complete or stronger. Choosing which parts of the computation belong in which of these 4 steps is how we optimize smart contracts to save on fees.


Writing oracle questions
==============

The oracle question can be asked any time before the contract is resolved. In particular, it can be asked after the contract is created on-chain.

You can ask oracles about any information that is public knowledge. The oracle responds with True, or False, or Bad Question.

You can ask the oracle "The VEO in BTC price is 0.0001 or lower at block height 11345." 

The oracle question is written in human language. Human language is Turing complete, so this is part of where the smart contract is happening.

Oracles can do massive amounts of computation, and they can return a very large amount of information. Asking any oracle question is equally expensive, no matter how computationally expensive it is to ask that question.

For example, asking "the 5th prime number 11" is just as expensive as asking "the 500th prime number 3571".

So, when designing smart contracts we should be trying to push as much computation into the oracle as we can, and we should be trying to get the most information we can out of as few oracles as we can.

The oracle is more expensive if the text is longer. So we are trying to use oracle questions with the shortest text as possible.


Macros for Oracle questions
==============

The Smart Contract can have rules in it about kinds of questions that you can ask oracles. 

A rule can be something like: "You can ask the oracle 'The price of VEO is in BTC is 0.0001 or lower at block height N' for any N between 11000 and 12000."

This rule is for generating oracle questions that are useful for enforcing strike prices.
The oracle questions it permits not only tell us that the price of VEO crossed the 0.0001 limit, it also tells us the block height at which that event had occured.

Think of making rules to limit how oracles can work is like making a macro where the macro is for generating the text of the oracle.

The reason we use macros is in order to get more information out of fewer total oracles, while keeping the oracle text short.

Making these macros for oracle text questions is a part of how the smart contract is written.


On Chain MAST creation.
=============

When there is an on-chain tx to create a contract, you give the root of a merklized syntax tree MAST for that contract.
When users become aware of parts of the MAST, this gives them the capability to provide evidence to the smart contract about how that smart contract should divide up it's value between the subcurrencies.
This sets the extreme limitations for what the smart contract can possibly be.
The MAST can be much larger than the code that actually goes in a block. Only branches of the MAST that are executed needs to be provided in a block as evidence.

The parts of the MAST that don't go into the tx that resolves this contract are far cheaper than the parts that do.

The form of the MAST determines how difficult it is to prove what the contract cannot be.
If someone wants to take part in your contract, they probebly want to download enough of the MAST to be sure that it does what they expect it to do.

Building the MAST root is like writing a domain specific language (DSL) for the kind of evidence that can be provided for settling the contract.

for example, here is chalang code that produces a MAST root.
```
: fun_one int 9484828202303 drop 1 ;
: fun_two int 2389454357493 drop 2 ;
: main
  if
    fun_one call
  else
    fun_two call
  then ;
main call
```

This MAST has 3 branches: fun_one, fun_two, and main.


building the MAST is part of how the smart contract is written.

Choosing which parts of the MAST to publish
=================

Continuing with the same example as before.

You can see that the main function is necessarily called. So, in order to execute this contract, you would need to provide the definition of the branch labeled "main".

in the "main call" part of the code, the word "main" gets compiled into the merkle hash of the word `main`.

An example of a valid trace through the MAST.
```
: fun_two int 2389454357493 drop 2 ;
: main
  if
    fun_one call
  else
    fun_two call
  then ;
false main call
```

The `fun_one` function isn't used, so we don't need to define it. It's definition does not recorded in any tx.

The purpose of this trace is usually to build the oracle macro.

Choosing the part of the MAST that goes on-chain is like writing a valid program in the DSL, and this is part of how the smart contract is written.

Timeline
============

The timeline for the order when these contract parts are being written:

1) the MAST is recorded on chain

Much time passes.

2) a valid oracle is resolved

Less time passes

3) someone makes a tx to show a trace of the MAST that shows that the oracle from step (2) can be used to resolve this contract.


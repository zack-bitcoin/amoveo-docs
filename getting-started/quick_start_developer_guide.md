Thank you for your interest in Amoveo.
This doc is an introduction to the technology.
It is made to help you be able to start contributing to the software as quickly as possible.

[Guide to erlang](https://learnyousomeerlang.com/)

[installing and turning on the amoveo node](https://github.com/zack-bitcoin/amoveo-docs/blob/master/getting-started/turn_it_on.md)

## Testing

We maintain two kinds of tests: unit tests and integration tests. Final test is syncing fresh node with public testnet node.

For integration tests that simulate multiple full nodes and test how they interact, first make sure your full node is turned off, then do `make tests`.

To run the single-node tests of all the modules in Amoveo, first, turn on a test full-node.
`make local_quick`

When the full node is loaded, it says something like
`(amoveo_core_local@YOUR_COMPUTER)1> attempting to sync`
from here you run
`tester:test().`
This will run all the tests, and return `success` if they all pass.

you can kill the erlang process with `halt().`



## Blockchain Commands

[Here are some basic commands you might want to run from a full node](../api/commands.md)

[Here is the external JSON HTTP api for the full node.](https://github.com/zack-bitcoin/amoveo/blob/master/apps/amoveo_http/src/ext_handler.erl)

[Here is the JSON HTTP api that you only access from that same computer.](https://github.com/zack-bitcoin/amoveo/blob/master/apps/amoveo_http/src/api.erl)

Since this is erlang, it is possible to run any exported function of any module, from the erlang command line.

[Most users interact with a full node from a light node. You can download the light node here to test it against your full node.](https://github.com/zack-bitcoin/light-node-amoveo) If you click the `test mode` button on many of the light node pages, then it will connect to a test full node on your computer.


## transaction types

[This will teach you about the transaction types](/design/transaction_types.md)
Transactions are how you can modify the consensus state of the blockchain.

## database

[This will teach you about trees](/design/trees.md)
Trees are the data structures that hold the consensus state of the blockchain.


[guide to contributing](/contributions.md)

[stuff that needs to be done](/todo.md)

Other concepts that could be useful.

* hash functions
* merkel trees
* nash equilibrium
* financial derivatives

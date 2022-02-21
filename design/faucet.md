Faucet
=======

so for the griefable dex.

1. user opens page, it creates a new account with 0 veo
2. user creates offer selling eth for veo. js pulls current eth block height from API, puts it into oracle language.
3.  user pushes swap offer to server. user also pushes 99% settle offer to server.
4. LP bot picks up offer off server, inserts eth pubkey, signs this transaction, AND signs a transaction spending 1 sat to user.
5. LP bot broadcasts both transactions to VEO L1.
6. (optional) user waits for veo block
7. user sends eth to LP pubkey
8. LP accepts 99% settle offer

the faucet server api:

* users publish uncollateralized swap offers. The offer is only valid for one block, so it automatically gets deleted after that. if a swap offer is accepted, it's contract data needs to be preserved until that contract expires. So it can be used for enforcement.

* the list of swap offers currently stored on the server.

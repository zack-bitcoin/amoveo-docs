# secure atomic swapping.

Atomic swaps as invented by TierNolan are very important theoretically. https://en.bitcoin.it/wiki/Atomic_cross-chain_trading
They prove that it is possible to trustlessly exchange currency on one blockchain for currency on another.
You can use a similar mechanism to show that exchanging different currencies on the same blockchain can be trustless.

Unfortunately, atomic swaps have been worthless practically.
It only solves half the problem. We don't _just_ want to swap tokens. We want to swap them at the current market price.

So, for example, if you wanted to trustlessly use Bitcoin to buy Veo.
The worry is that you will set up the atomic swap tx, and the person on the other side of the swap can decide at the last minute to either cancel or accept the swap, based on how the price of BTC/Veo moves. This is called the "free option problem".

So, how do we solve the free option problem?
First we need synthetic bitcoin on the Amoveo blockchain. Then you can use Amoveo markets to trustlessly change your Veo into synthetic bitcoin.
You can trustlessly do an atomic swap to sell your synthetic bitcoin on Amoveo for bitcoin on the Bitcoin blockchain.
Since the synthetic bitcoin and bitcoin both maintain the same price relative to each other, there is no free option.


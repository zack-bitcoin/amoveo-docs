Truthcoin Contracts
===========

Amoveo smart contracts in the context of Truthcoin's design.


In Amoveo we have abstracted the idea of truthcoin oracles into 2 parts. Oracles and Contracts.

Oracles answer a yes/no question, and make that data available.

Contracts do the rest, and they are also able to do basic computation.
The oracle data is available during that computation.
The result of the computation decides how to divide up the collateral inside the contract between between the different share types.

Cutting apart the oracle and the smart contract also allows us to make the smart contract before the oracle, which allows us to do last-minute optimizations in the oracle text.
We can create a smart contract to report on the price. And the oracle question can end up being "Is the price of BTC $39567.34 ?", and when the oracle responds "true", then you have used a binary oracle to feed a 10 digit decimal number into the consensus state.
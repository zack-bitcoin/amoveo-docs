User Stories
=========

different people have a different process of using Amoveo's light node.


# liquidity farmer process

* acquire the 2 kinds of currency needed for the market
* deposit them into the market to get liquidity shares
* wait
* exchange your liquidity shares for the 2 kinds of currency + trading fees you have earned.

# trader in high volume standardized markets process

* swap veo for the subcurrency that represents the bet that you want to make.
* later sell your subcurrency, hopefully at a higher price. or if you won the bet, withdraw your winnings.

# selling customized bespoke contracts

* use the id generator to know the id of the currency that represents the contract you want to own, generate the ID.
* use that id to make a swap offer, where you would buy what you want.
* someone accepts the swap offer to take the other side of your custom contract, this also creates the contract on-chain.

# new market creator process 

* if the contract doesn't yet exist, then use the new_contract tool to specify how the money in the contract should get divided among the subcurrencies.
* use the set_buy tool to acquire the different flavors of subcurrency from the contract, that represent participating in the different sides of the contract.
* create the market using the new_market tool and depositing the initial liqudity into the market.

# market resolution process

* use the oracle_bet tool to make a report on the outcome of the oracle.
* wait enough time for the oracle to become resolvable.
* use the oracle_close tool to finalize the outcome of the oracle.
* use the contract_resolve tool so the smart contract will read from the oracle, and decide how to divide up it's value between it's subcurrencies.


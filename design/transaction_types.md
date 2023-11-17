Governance decides a different minimum fee size for each transaction type.
The miner profits by including transactions that pay above the minimum fee for that transaction type.

These are the 26 types of transaction that can be in blocks.

3 transactions for accounts:
* create_account_tx
* spend_tx
* multi_tx

5 transactions for the oracle:
* oracle_new_tx
* oracle_bet_tx
* oracle_close_tx
* oracle_unmatched_tx
* oracle_winnings_tx

6 transaction types for smart contract:
* contract_new_tx
* contract_use_tx
* contract_evidence_tx
* contract_timeout_tx2
* contract_winnings_tx
* contract_simplify_tx

4 transaction types for subcurrencies:
* sub_spend_tx
* swap_tx2
* market_swap_tx
* trade_cancel_tx

2 transaction types for managing markets:
* market_new_tx
* market_liquidity_tx

5 employment contract transactions:
* job_create_tx
* job_receive_salary_tx
* job_buy_tx
* job_adjust_tx
* job_team_adjust_tx

1 bonus transactions:
* coinbase_tx

# create_account

This creates a new account on the blockchain and gives it some Veo.

# spend_tx

Spends Veo to a different account.


# multi_tx

A multi-tx contains one or more other transactions inside of it. If this tx is included in a block, then all the txs inside of it are executed.
There are multiple reasons to use this:
* cold storage. A multi-tx only updates your account nonce once, this makes it simpler for cold storage.
* tx fees. a multi-tx only has one signature, so it is smaller than using multiple tx.
* atomically linking txs. sometimes you need multiple txs to go through together, otherwise you are left holding risk you don't want to hold. A multi-tx can be used to link the txs together, so either they all get included in a block, or none do. This is important for preventing an attacker from inserting their txs between your txs, and to prevent a malicious miner from including only some of your txs.
* flash loans. multi-tx allows for veo and subcurrency balances to go temporarily negative, as long as they end positive.
* accounts without veo. You can use a flash loan and a amm-market to buy the veo to pay the fee inside the same tx.
* it is not possible to put a contract_evidence_tx inside of a multi_tx, because this would be a denial of service vulnerability to mining pools and full nodes. Contract_evidence_tx run a turing complete smart contract, it is necessary that if this contract runs out of gas, we should include that tx, and charge the tx fee, but without executing the tx. This is contradictory with how multi-tx atomically either execute all the txs, or none of them.

# oracle_new

This asks the oracle a question.
The oracle can only answer true/false questions.
Running the oracle costs a fee which is used as a reward to get people to use the oracle.
The fact that an oracle exists is recorded on the blockchain in a way that is accessible to the VM. So we can use channels to make smart contracts to raise funds to run the oracle.
The entire text of the question is written into the transaction, but only the hash of the text is stored into a consensus state merkel tree.
The oracle has a start-date written in it. Trading doesn't start until the start-date.
The oracle can be published before we know the outcome of the question, that way the oracle id can be used to make channel contracts that bet on the eventual outcome of the oracle.

# oracle_bet

This is how you can participate in an existing oracle.
The market is an order book with 3 types of shares: "true", "false", "bad_question"
All trades are matched into the order book in pairs at even odds.
So the order book only stores 1 kind of order at a time.
If you want your order to be held in the order book, it needs to be bigger than a minimum size.
The minimum size gets bigger as the order book gets bigger. So if there is C number of coins in the order book, the number of orders is smaller than `log2(C/(minimum for first order))`
If your order isn't big enough to be in the order book, you cannot buy shares of the type that are stored in the order book.

# oracle_close

If there is a lot of open orders for one type of share in an oracle for a long enough period of time, then this transaction can be done.
This ends betting in the market.
The fee that was used to start the oracle is the final bet included. It bets against the winning outcome.

# oracle_unmatched

If you had money in orders in the oracle order book when the oracle_close transaction happened, this is how you get the money out.

# oracle_winnings

If you bet in an oracle, and the oracle has closed, this is how you get your winnings out.
If you bet on the winning outcome, then you get twice as much money back, otherwise you get nothing.

# contract_new_tx

This creates a new smart contract on-chain. The turing complete code is not store on-chain, we only store the hash of the code.
Each smart contract has a source currency and 2 or more subcurrencies.

# contract_use_tx

If you own the kind of currency that is used as collateral for this contract, this tx can be used to give more collateral to the contract, and to receive in exchange a complete set of the subcurrencies defined by this contract. You can also do the reverse; you can combine a complete set of subcurrencies to receive the collateral.

# contract_evidence_tx

You can provide the turing complete smart contract code, along with evidence, to help the contract figure out how it should divide it's source currency value to the holders of the different subcurrencies.

# contract_timeout_tx

If someone had already provided evidence, and enough time has passed without anyone else being able to provide stronger counter-evidence, then it becomes possible to do this tx. This tx ends the smart contract. Then it is possible for owners of subcurrency from that contract to claim the collateral currency that they won.

# contract_winnings_tx

This is how you transform your subcurrency into the collateral currency that you won.

# contract_simplify_tx

If contract A settled by paying out currencies from contract B. and contract B settled by paying out currencies to contract C. then it is possible to use this tx type to directly connect A to C, so holders of subcurrency in A can withdraw directly to C without having to go through B first.

# sub_spend_tx

This is used to spend subcurrencies. any currency besides veo.

# swap_tx

this tx is for 2 users to exchange one currency for another.
one user publishes a swap_offer explaining the currency they are willing to give up, and what they want to receive in return.
the second user can take the swap_offer and use it to make this tx.

Swap_offers can be stored in centralized off-chain order books.

# market_swap_tx

This is for participating in an on-chain constant product automatic market maker. you can exchange one kind of currency for another.

# market_new_tx

This is for creating a new on-chain market maker. you need to provide currency on both sides of the market for initial liquidity.

# market_liquidity_tx

This is for adding or withdrawing liquidity to a market. If you leave money in a market to provide liquidity, you will collect trading fees.
If one of the 2 currencies loses significant value, then you can lose a lot of money.

# trade_cancel_tx

canceling a swap offer.

# job_create_tx

for creating a new employment contract. You start out as both boss and worker.

# job_receive_salary_tx

If you are the worker for a job, you get paid with every block. This transaction type is used to move you salary from the employment contract to your account.

# job_buy_tx

The employment contracts are all available for sale, using the harberger continuous auction. This tx type is how you purchase them and become the boss of that contract.

# job_adjust_tx

This is how the boss of a contract can adjust the settings of that contract. Like, how much it costs to purchase.

# job_team_adjust_tx

This is how the boss and worker from a contract can cooperate to adjust even more setting for the contract. They can change the worker's salary.

# coinbase_tx

Every block can have one coinbase tx. it needs to be the first tx in the list of txs. this tx is used to give the block reward and miner-tx-fees to the miner who found the block.


[transaction types are the ways to modify blockchain consensus state. All the consensus state is stored in trees. Read about the trees here](trees.md)


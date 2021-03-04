It is the 3 year anniversary of Amoveo's genesis block. It is a lot of fun building financial tools with you all, I hope we can continue for many more years.

This year saw a lot of big changes to Amoveo. The biggest change is that we abandoned our plan to have a pure state channel system for smart contracts. This happened because the pure state channel system was too capital inefficient. You can learn more about why we made this change, and our new smart contract system here https://github.com/zack-bitcoin/amoveo-docs/blob/master/design/smart_contracts.md
In this smart contract system every smart contract you participate in, your position is a spendable currency.

Another major change is that Amoveo now has native constant-product markets, like uniswap, but since it is native instead of in a smart contract, it is as cheap as a normal spend tx.
This year we also created the Amoveo limit order tool, which allows you to make offers to swap any of your currencies for any other currency in Amoveo. The orders themselves stay off-chain until matched, so unmatched orders are free to make.
This year we added flash minting to Amoveo. So you can atomically combine any of the amoveo tx types (besides contract_evidence_tx), and your balances in any currency can temporarily go negative, as long as they are all non-negative by the end of the flash-mint.
Using the flash minting tool, we created an AI that combines multiple uniswap txs with depositing/withdrawing veo into smart contracts, to get the best possible price for the trade you want. A feature Vitalik wants to add to Ethereum https://twitter.com/zack_bitcoin/status/1362489877791715329?s=20
This year we created a new simplified user interface in the light node, to give easy access to Amoveo's most popular tools http://159.89.87.58:8080/wallet.html
The UX for the swapping AI is in the swap tab. 
The futarchy tab is also a new innovation this year.
Our futarchy tool allows us to find out the impact any decision will have on the price of anything. For example, we can know if an update will be beneficial for the price of Amoveo. We made changes to the old futarchy design based on advice Robin Hanson gave.
This year saw the creation of the Amoveo crosschain DEX, which allows for creating offers to trustlessly exchange VEO for any currency on any blockchain, including Zcash and Monero. You can see it compared to other designs here: https://github.com/zack-bitcoin/amoveo-docs/tree/master/crosschain_dex
Amoveo is at the leading edge of financial innovation. We are still the only blockchain using the memoryless full node design, a kind of rollup scalability strategy. Our oracle is the cheapest and the most secure available. We have the only immutable smart contract system.
We have the cheapest and the most secure crosschain DEX available.

This is a community where anyone with good ideas can see them included in the mainnet quickly.

I hope you will join us for year #4 of Amoveo.

This year we had 17 hard updates.
9 were to fix bugs.
2 to turn off the old state channel system.
2 to make the new smart contract system.
1 to add constant product market makers.
2 to add flash loans.
1 for limit orders
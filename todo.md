you are in the middle of hard update 47. which will charge by the number of bytes in a tx.



maybe contract evidence tx and oracle new tx should have a fee per byte.
block:gov_fees2



take your money from this oracle when it resolves
d4TQD0dcYWTz9i9JTmKngpR+ypt8DGPRBl3flx+WVX4= around 25-feb
de01XJM9elbsxRgvHp5ELLTqgWHEHguvibeq5zXFTNs= cid



hard update to be able to make offers to buy veo.



p2p derivatives swap verify.
should check if they have enough subcurrency to make the trade.




look into the idea of having merkle root checkpoints inside the same block, so that the txs can be processed in parallel.
How can miners produce this blocks as fast as they can be verified?
we don't need to include proofs of the same data more than once, because one checkpoint produces the proof for the next.
We just need a copy of what the data looks like after running that checkpoint.

maybe the mining pool can process in parallel if it cuts the database into shards, and charges users less if they make txs that only touch a single shard.

how about one checkpoint per tx, or more than one per tx.




Idea: Amoveo atomic swap tool. for enforcing swaps between 2 other blockchains.
If someone refuses to participate in the swap they should be over-punished in veo terms.




in crosschain DEX.
when accepting an offer, maybe instead of doing it in a single button, there should be a "more details" button that shows the address. and to help protect from misclicks.
maybe it should copy the btc address to clipboard too.
when you broadcast it.
and maybe the confirmation message could include the BTC address.
ordering trades by price would be nice.

would be nice if the refresh button was automatic.
could connect it to when new blocks are found, and to clicking the crosschain-DEX tab.


in crosschain DEX.
go through the process of making a trade and trying to sell both sides.
look at what gets displayed in the tab all along the way, and make sure it makes sense.


the "accept offer" tool in the crosschain DEX should display price as well.




in crosschain tab builder. Every time we generate the cancel buttons, we should remove any memoized data related to that subcurrency. That way you don't need to refresh the page to see the "release the funds" buttons when they are ready.


improve the crosschain DEX tab

maybe separate into two sections
"information on coin to receive (buy)"
"information on coin to send (sell)"




write about the decentralized local bitcoins idea.
use an oracle as the third party to verify that a tx went through.

the contracts.html page, when you accept a swap offer, there should be links to look up what the Contract ID is in reference to.

contracts.html subcurrency set buy shouldn't accept decimal amounts.

in swap tab, seems like veo fees is not calculated correctly.

sometimes the swap tool is making bets in the wrong direction. when you try to make a bet that moves the price near to 100%.

the swap tool should account for txs in the mempool when processing your bet.



working on stablecoin_new_tx. 




look into starting the undercollateralization auction when we are more than 100% collateralized, and maintaining the stablecoin backing during the auction.




perpetual subcurrency hard update
=========

-record(stablecoin_new_tx, {
     id,
     source,
     amount,
     code_hash,
     timelimit_auction_duration,
     undercollateralization_auction_duration,
     undercollateralization_price_trigger,
     collateralization_step,
     period
}).



-record(stablecoin_buy_tx, {
      SID, %id of the stablecoin contract we are depositing into.
      source,%finite subcurrency depositing
      amount %amount of source currency to deposit into SID to receive perpetual stablecoins. If it is negative, then we are selling the perpetual stablecoins for the source currency.
      %during auction mode, amount cannot be positive.
      %during auction mode, this partially refunds whoever made the highest bid, to maintain the price of their bid.
      }).
      
-record(stablecoin_undercollateralized_tx, {
      %starts the auction because the source isn't collateralized enough.
      %spending lots of veo to buy all the finite stablecoins currently collateralizing the perpetual stablecoin.
      SID,
      source,%finite stablecoin currently backing this perpetual stablecoin
      source_type,
      amount, %the quantity of veo being paid. 99.9% of the stablecoins.
      }).

-record(stablecoin_u_bid_tx, {
      %bid veo in a auction to try and win long-veo contracts for a new finite stablecoin contract.
      %must be bigger than the previous biggest.
      %gives a refund to whoever had the biggest bid before us.
      SID,
      amount
}).

-record(stablecoin_auction_end_u_tx, {
      %end an auction that happened for undercollateralization.
      %whoever made the biggest bid deposit, they get the long-veo of the new contract. their veo is added to the pool of collateral.
      SID,
      code,%matches the code_hash from the stablecoin
      %code is used to define the new finite stablecoin contract.
      %the winning bid in the auction, it's price is given to code, to help decide the limit price of the new contract.
}).

-record(stablecoin_timelimit_tx, {
      %starts the auction because the timelimit is nearly reached.
      SID
      }).

-record(stablecoin_t_bid_tx, {
      %bid veo in an auction to try to win lots of a finite stablecoin that is nearly expired, and long-veo for a new finite stablecoin contract.
      SID,
      Amount
      }).

-record(stablecoin_auction_end_t_tx, {
      %end a timelimit auction.
      %whoever made the biggest deposit, they get the finite stablecoins of the old contract, and the long veo of the new one.
      SID,
      code, %matches code_hash in SID. used to generate the new finite stablecoin contract.
      %the winning bid parice is given to the code to decide the limit price of the new contract.
      }).


The perpetual stablecoin is collateralized in a finite stablecoin.
The finite stablecoin is collateralized in veo.

* initiate auction because of undercolateralization.
- if the collateral is 1000 finite stablecoins, it is always possible to give 990 veo to buy those 1000 finite stablecoin, which initiates the next auction period.
- During the auction, the perpetual stablecoin is linked to the price of veo.
- People bid in the auction with veo. If they win, they get the long-veo side of the new finite stablecoin.
- It is like they are trading 210 veo for ~220 veo worth of long-veo contracts.
- so the long-veo has leverage around 6x.

what if someone triggers the auction 10% early?
Then they are spending 1000 veo to buy 900 veo worth of stablecoins.
we are auctioning off ~300 veo worth of long-veo contracts, and end up 10% more collateralized than we had intended.

* case of overcollateralization.
- just keep the time limits short enough so it wont matter.
- people can swap out to different perpetual contract if it is extremely overcollateralized.


* initiate auction because of time limit.
- the auction is selling finite1.
- creating finite2+longVeo2 is atomic with winning the auction.
- they bid in veo. if they win, they get finite1 + longVeo2.


* when you provide evidence to a contract, there should be a way for the contract to finalize with an intention to swap it's source currency out for a different source currency. The person who makes this tx does a safety deposit to pay for this.
* if someone else makes a safety deposit, the older deposit should be refunded.
* when the contract is settled, the person who had paid the security deposit should get the other kind of money instead.
* we need a new version of the contract tree to remember the contract ID, because we can't use the source to generate the contract ID. (or maybe we just don't use the source when generating the id?)
 - also remembers the amount deposited, and who deposited it.
 * if we are in the process of switching source currencies, don't let anyone buy more perpetuals. but we should allow people to combine a complete set back to the first source. doing this also refunds part of the safety deposit for whoever is swapping us out for the new source.




swap_books:re_absorb_cron/1 is vulnerable to memory overflow. We shouldn't create a new perpetual process for each request. Maybe we can have a thread that keeps a list that it occasionally scans through.

update the light node and p2p_derivatives_explorer to use the new version of swap_tx.

light node should know how to cancel your limit orders.

update the AMM swap tool to use limit orders when possible, and you should be able to make your trade as a limit order.

soft fork to turn off the old version of swap_tx.



contract_explorer and market_explorer could be tabs in wallet.html, that way if you click to make a bet in the contract_explorer, you don't need to re-load your private key.





interblock changes in the contract_explorer graph could be displayed better.

the order book and AMM need to be combined.


it seems like the explorer might be counting txs twice. it is counting them in the next block, even when no txs exist in that block.


we load headers automatically now.
only check if balances have changed if the height changes. don't check every time.


for contract/market explorer.
if the market is only created once, then there is only one unit of data, but the chart is empty. display something more useful.
http://159.89.87.58:8080/contract_explorer.html?cid=hujphLVR3ayTMVFQWs6hq9NSQMwOYB9xXV95GpWKwPk=



change the market explorer and contract explorer into tabs in wallet.html, that way you don't have to reload keys.
in wallet.html, key management should be a different tab, to keep each tab cleaner.
* if they load an explorer tab directly, don't load headers or contracts until you leave the explorer part of wallet.html


a link from the contract_explorer to the pool tab, so you can sell all your liquidity from any contract.


sync needs a gen server so we don't have more than one thread running at once.
* also to automate restarting the sync process if it gets stuck.


in the light node refresh market prices after trading or syncing blocks.

batch the api, so you can look up subcurrency balances all at once.

when you load the private key from file, it would be nice if it defaulted to the file that is default for saving. or simplify the process somehow.


the contracts_list page could organize by new instead of by size.

some way to atomically match multiple limit orders to earn arbitrage. maybe a part of mixing the AMM with the limit order tool.
* maybe it makes more sense to auto-combine opposite types when you accept a swap offer.

some way to assign small tickers to markets.


if you try to sell you shares in the pool tab, and you don't have any shares to sell, it should give a more useful message.

maybe the block meta tool should track contracts and markets.

new plan for the update to get rid of channels.
1) soft fork to turn off channel txs.
2) use normal spends to pay people back from developer reward funds.
3) hard update to refund zack's developer reward funds.


maybe we want an alternative mode in the swap tool optimized for futarchy applications.
So a user can say "changing this law will have this effect" without betting on whether the law will change or not.
you want to own both sides of the base binary market, and only bet with one of the two kinds of shares.
possibly a futarchy-betting tab would make sense.


hard update to give back the veo from the old version of channels.

in contract explorer "total amount invested in this contract" is actually just amount1. it should be changed somehow
.


review drop zone https://github.com/17Q4MX2hmktmpuUKHFuoRmS5MfB5XPbhod/dropzone_ruby/blob/master/Drop%20Zone%20-%20Whitepaper.pdf



the swap tab should have url variables to auto-load a contract that you want to trade.
the explorer page should have links so you can open up your wallet with a trade for this contract auto-loaded.




when you look up a trade price, it should also give you details about the collateral currency.

maybe we should have contracts for options.

when you are making a trade it would be nice if there was a clear explanation in english of what exactly this trade is doing.

create tab. betting on hashrate
we probably need new regex for a new standard oracle format.


test the order book tool.
send the spare money to a different account, and set up sales, that way they wont get un-done by the nonce changing.


make a new tool for browsing contracts.
show open interest, trading volume in 24h, price, liquidity, volume in 24h, trades in 24h, 
Allow comparing prices of related contracts.
show historical price, liquidity, volume in graphs.
remove price and open interest from the dropdown in the swap tab.


soft fork bribery attack doesn't work.
add a disclamer to old incorrect documents.
as long as the validator bond is locked up long enough, we can eventually identify which validators were honest, and undo whatever punishment the dishonest validators had done to them.
Look into if this constraint means pos is necessarily vulnerable to data availability attacks.

look more into the merged mining idea.


in the swap tab, auto lookup price and other info, so we don't need 2 buttons.

update how the standard oracle for stablecoins works.
* set up the UX for the optional leverage multiplier on the price measured. add this option to the create tab.

 8. make sure that nothing requires refreshing. getting your new list of balances for example.

both "how much to sell" and "how much to buy" fields should be editable. if you change one, they both change, based on the possible price.
We probably only need 1 button in this case.

a page for historical price in the market.

in the pool tab. it seems like rebalancing prices before depositing liquidity isn't working. it has some rounding error that leaves it off by like 0.3%.

auto-combine when possible.
* when selling liquidity shares.
* after swapping.
* when accepting swap offers?

combine the swap tool with the AMM tool.



display a "dev fee" in the checksum when making txs.

if you lose all of one of the subcurrencies, it should delete that from your balances list.



sum up all the long-veo contracts, along with your veo balance. This is your total veo exposure.

standard hashrate 0; blockchain = Bitcoin; units = "million terahashes per second"; max = 200; min = 40; time = 12:00 10-29-2020 China Standard Time (GMT+8); website = blockchain.com; h = hashrate of blockchain according to website; return(4294967295 * ((h/units)-min) / (max-min));


paper: why price feeds are a bad idea. Comparing the utility provided by a constantly available price feed, in comparison to the utility of a slow to update price, they are nearly equivalent. So there is almost nothing to gain from using price feeds instead of normal oracle mechanisms.
Show that a price feed cannot be used to automatically update the price of AMM, because of the MEV. miners want to front run the AMM before the price gets corrected. Bribing the miners to let you correct the price of your AMM is as costly as letting them frontrun.
Show that a price feed's security for enforcing the outcome of derivatives is very expensive.
Show that a slow oracle can be very cheap and secure:
The DAO hack in Ethereum was prevented by using a hard update. Amoveo uses the same security model for our oracle. If an attack is 1) slow, 2) costly to attackers, and 3) profitable for people who warn that the attack is happening; then we can use hard updates to prevent the attack. In order to achieve this, the amoveo oracle mechanism is based on a prediction market mechanism, which was modified to achieve these properties.





swap offers to sell veo for stablecoins seem to not be working.


it is currently impossible to deposit into contracts that you did not create.


leverage/collateralization should be on different lines, and the buttons too.





## create tab updates


investing.com should be a default source.
https://www.investing.com/indices/us-spx-500-historical-data
is controversial, lets get it working well first.
the "price" column specifically is the closing price for that day
you can use the lowest "low" column # across all the rows as the liquidation provision

would be nice if we could end up holding some initial stake after creating the market.

#######



update text for selling subcurrency for veo.

if selling stablecoin, then the units of how much to sell should be in stablecoin terms.
also in the spend tab.

when you display slippage for buying long-veo, the slippage should be in terms of how much the stablecoins are changing in price. not in terms of how much the long-veo changes in price.

when you make a trade, it should show you what the price of stablecoin will be after the trade.


auto-combine types of shares.

option to swap liquidity directly to veo when selling it.


explorer isn't cleaning liquidity shares or subcurencies correclty.


graph of historical mining difficulty.


update pool_tab to use zeroth confirmation state of markets.

update balances if you switch pubkeys*

private key into localstorage in the lightnode.

show liquidity with the contracts.


if a tx gets published then we could potentially need to reset some timers in the balances_db in tabs.js
That way it knows which balances to update.
specifically for the case where you sell all your stake in something, and then buy more stake later, all without refreshing the page.




create tab is not starting at the right price.


say the source unit as part of the price in the ticker text.


don't display balances in markets.


put a ticker in the url and optimize for trading that ticker. maybe even get rid of inverse.

gossip swap offers in p2p_derivatives_explorer

pool tab. total liquidity, my liquidity.


in the [pool] tab, the "lookup price to sell all liquidity shares" button is confusing. We need to make it more clear what is happening.
* hide unnecessary fields.
* maybe use more tabs.


drop downs for the date when creating markets.

when you sell liquidity shares, or buy shares in a swap, it should auto-combine when possible.



history price chart of markets

maybe we should display balances more intelligently. have a module that keeps track of them, and only refreshes when it makes sense to.



in the pool tab, we should use the correct market data when processing the txs, and for generating the txs.
Currently we update it sometimes, and not other times. and we don't reset it when we should.


display prices and liquidity with market tickets. use market prices to calculate what we need.
drop down for currency to get paid in.

update the stablecoin oracle text to support a limit price, if it gets crossed, then the market immediately ends and 100% of the source currency goes to one party.

when you scroll over a market ticker, a box with more info should appear.

when yo uare swapping, it should update the price when you edit the field. no "lookup price" button.



in the wallet page, it is currently looking up all your market balances before displaying anything.
we should set it up to trickle info onto the page instead.



if you try buying liqudity, but don't have the source currency, it should give a useful error message.



mining pool white list for request frequency.





checkbox to auto-sell your winnings if you win a bet.


it needs to be simpler.
oracle questions are too long. a ticker would be better.
make the contract id disappear.


integrate the AMM and order book with one UX.




* in uniswap, it would be nice if we could do a keyword search for contracts to display, instead of just the top 10. also for markets.





it would be nice if there was a page of existing markets. including historical price data.
convert to convenient format when possible. usd/veo is better than usd/long-veo
* even more important is a chart of liquidity and volume.



hard update
==================
* governance variable to change all the fees at once.
* governance variable to change the block time, block reward, and those 2 oracle delays, block size.



rewrite binary derivatives to not have a start height.


a smart contract to create a warm-wallet.
A private key that can be used to have restricted trading access to an account.
This way people can keep most of their value in cold storage, but still be able to use it to do certain things.
I publish a swap offer that can only exist if the contract gets created.

And if you accept a swap under invalid conditions, you lose your money. It is the same as creating a contract that gives me your money, and then depositing your money into it.
So this way I can have a warm-wallet. With restricted access for trading.
It's like, you pre-sign a bunch of swap offers from your cold storage.
And these swap offers reference off-chain contract code that specifies the rules under which the swap is valid.
Both my warm wallet, and the person I am trading with, they can both provide evidence to determine how the contract should resolve.
my contract could specify that I am allowed to sell for down to 3% below some on-chain markets price.
But before I give this offer to someone, I can sign more evidence onto it if I want. Like saying this particular offer is for 5% above the current market price.

It is a valid trade offer which meets the conditions for restricted trading.




it would be nice if we could pause and continue while syncing in reverse. or restart it if one peer stops sharing.





hard update to get rid of the burner address


hard update to make the market-cap written on each block correct.



we need some explorer database to look up which subcurrencies each account owns.
maybe make it a configuration option of the full node, and default it to "yes".


* in contracts.html, when we are displaying the swap offers for a given market, we should use the {history, mid, nonce} api request and merge updates with existing data.



* garbage collection for p2p_derivatives binary_contracts.erl. we should delete data if it is more than 30 minutes old, and we have never stored any trade related to that contract data. if a trade gets matched, it is important to store the data until either the contract closes.


* a delayed response tool for headers would be nice. so the light node could automatically sync when new headers are found.


after the subcurrency update activates
* hard update to get rid of the old version of smart contracts.



consider getting rid of the governance variable for the block time, or making some system so the oracles can have consistent expiration, even if the block time changes.
- instead, how about calculating the oracle ID inside the smart contract, so we can have rules about acceptable start_heights.

chalang should be able to make empty binaries.

the smart contract can have rules like:
make an oracle with text: "the result of the football game was known after block height N", and another oracle who's betting begins at block height N, with the text "Alice's team won the football game".

So when it is time for enforcement, we can figure out what N needs to be to resolve this contract, and then build the oracles that that N.
Can we use 2 binary oracles to enforce the outcome of a scalar contract?

smart contract can have rules saying how they work as upper and lower bounds on the price.
maybe just one.
Is the price of X within 0.1% of P?
and require that the outcome of that oracle is "True"
using bits of smart contract to generate oracles that enforce the same smart contract, it seems like a technique with a lot of potential.

I think this is a lot more secure than what we were doing before, encoding the value with N binary oracles





hard update so balances can be bigger than 2.8 million veo.





consider posting stuff to hackernoon for SEO.
youtube with hashtags for SEO



we need smart contracts embedded in the light node.
* 2 of 2 contract. accepts a pair of signatures for arbitrary updates. also called a "state channel"


hard update to accept subcurrencies.

start updating the light node to support the new channels.

hard update to remove old txs.










the workflow we want.
Someone who buys a contract, they should simultaniously make an offer to sell it for 99% of it's value.


swap-accept tx type needs some swap-id to prevent reuse of the trades without incrementing any account nonce.



if all the trades in an oracle aren't being displayed because they are in the mempool, then don't display the oracle either.



governance variable for the maximum number of subcurrencies in new shareable contracts.

test withdrawing from a contract priced in a non-veo subcurrency.


a shareable contract needs to be able to resolve into some different shareable contract with the same source currency.
* make a test
* update contract_winnings tx to support this case.

mutable contracts.




documenting shareable contracts
one of the features we discussed in regard to shareable currency, is we would like a tx type that can atomically allow a pair of people to buy opposite sides of a contract, or sell opposite sides.
Also a tx type to atomically swap different kinds of currency on-chain.

The current channels in Amoveo have a feature where you can post an open offer, and anyone can accept the other side of the new channel tx to participate in the opposite side of the contract from you.

So a feature I am considering is that we should allow open offers for making txs to buy/sell/swap subcurrencies.

I am imagining a process like this. If you start with VEO, and want to buy stable USD.
First you do an on-chain swap to change from VEO into a subcurrency that acts as an open order to purchase stablecoins. Because the batch price isn't yet known, the exchange rate between the limit-order subcurrency and VEO is stable, this prevents front running and allows us to do it on-chain.

When a batch occurs, if it is inside the limit price of the shareable contract, then the 2 kinds of shares of this contract become long-veo and stablecoins.

If the batch price is outside the limit price, then the 2 kinds of shares become regular veo. It works like a refund.

If you end up holding stablecoins after the batch, you can use a on-chain swap tx to convert these stablecoins into stablecoins defined by a more standard contract, without risk of front running. because the relative price between the stablecoins defined by the 2 contracts, it is the same.






when a channel is enforced on-chain, maybe that should create a new shareable contract.
another benefit of this strategy is that if multiple channels are all using the same contract internally, that contract will only ever need to go on-chain once, because the channels are all going to reference the same shareable contract.





It would be really cool, if instead of fully resolving one of the shareable contracts, if there was a way of showing that it can be partially-resolved to become equivalent to another existing shareable contract, and then the 2 shareable contracts combine, so the subcurrencies in each are fungible, and when spent, they automatically convert to the simpler type.
Which allows us to smoothly prune obsolete parts of the code from shareable contracts, and reduces the amount of data you need to provide to prove the value of your partially resolved sub-sub-currency.

This would help us avoid running the same computation more than once. and it would reduce on-chain traffic, because participants in sub-sub-currencies wont need to use a market to swap to the sub-currency, it will be automatic.

It also provides a natural way to break up complicated computation into steps in multiple blocks.







mutable contracts should resolve into shareable contracts.

implement the new tx types as defined in the design/shareable... document

update the channel tx types to accept the new format of channels as well, or rewrite them if necessary.







### a document about layered sharable contracts.


This isn't as exciting as we had hoped that sortition chains could have been.
But it is compatible with the stateless full node model.
It is entirely secured by nakamoto consensus.
It only uses technology that we already understand.
And it is probably the best way to do blockchain-secured financial derivatives given the technology that is available today.
I think this will keep us in a good position to continue adopting scaling technology as it is invented in the coming years.

the limitation of channels is that you either need your partner to cooperate, or you need to wait a delay and post the contract on-chain.
the limitation of a sub-currency is that you can't update the contract once it has been made.

That way, you can sell your unmatched order without needing the permission of the market maker.
or you can sell your unmatched order back to the market maker, to cancel your trade.



make it more clear what "oracle starts" means in the light node.


** in the trees files, the get_dict functions, we need to distinguish between when we know a spot in the tree is empty vs when we don't know what is in that spot.






Light node should have pages with more pre-set defaults for the things that common users want to do.

retitle the "Txs" page in the light node to "Amoveo wallet".

a tool for duplicating a trade. it fills out the form for creating a new trade.

the otc tool should give an estimate for how long until the trade expires.

the p2p_derivatives website should recognize some kinds of contracts, like bitcoin put contracts, and optimize how they are displayed to keep it simple.
show strike, maturity, premium, notional

remove bets from the p2p_derivatives website one block before they expire.
Keep a list of recently matched/expired bets for reference.

when you accept a bet from the p2p_derivatives page, it should automatically create close offers, so if someone realizes that they have lost, they can quickly unlock the funds.
specifically, Mr Flinstone wants to receive close offers, so he can give up the money if he loses, so his customers can have a one click experience.

* integrate p2p explorer into the light node.
* when you accept a channel offer, immediately create a channel close offer and send it to the server, to win 99% of the value.
* the server should store the most recent 1000, and have an api for viewing them.
* the light node should scan the full node peer list to find all the p2p derivatives explorers.

the p2p explorer needs a database to store channel close offers. store the most recent N.
There should be an api to request all the close offer that relate to channels where acc1 is the account being searched.



* more tests of the new sortition chains.
  - smart contract at layer 2, including posting the contract on-chain in a sortition-evidence tx. 
  - atomic swap value between 2 sortition chains.
  - receiving value in a sortition chain that you didn't previously know about, including merkle proofs of the history for the part of the value you will own.
  - atomic swap between channels in sortition chains.
  - make a channel in the sortition chain, buy stablecoins, then settle the channel so that you are left holding stablecoins inside the sortition chain.



Sortition Chains
* api
* javascript light node interface
- create a new sortition chain
- claim winnings from a sortition chain
- advertise existing sortition chains
- communicating with the operators of the sortition chain
- horizontal payments
- vertical payments


create a process for keeping track of the VDF and making txs as necessary to cause the correct RNG value to be computed.


syncing blocks in reverse.





ideas for the p2p betting experience:
* consider a single page app.
* minimize the number of clicks
* make it so you don't need to reload keys so often
* save channel offer in the browser automatically.



in each tx file, remove the no longer used `make` function


a lot of the tree modules have practically identical functions. It would be better to abstract the repeated code into trees.erl.

light node tool to simplify the futarchy process.

auto-sync the wallet when you open the light node. auto-check your balance.


in the light node, would be cool if we could remember a cookie or something of the top block's hash. so we don't have to resync headers on refreshing the page.

why do we support 2 ways of making channels? can we stop supporting one of them?







it looks like when we are syncing blocks, a lot more of block:check can be moved to block:check0, which will make block processing more parallelized.
We are loading the blocks an entire list at a time, so it shouldn't be that hard to include the previous block with each block for reference.


looking up O(log2(n)) many blocks from the hard drive is probably a lot slower than looking up O(n) headers in a row for n<300.
we should re-write get_by_height_in_chain to not use prev_hashes.

remove support for db_version 1.
remove support for hd mode for tries.

Then we should be able to get rid of prev_hashes entirely, which should make checkpointing more straightforward.


syncing headers is very slow.
maybe we should store headers in compressed pages, like how we do blocks.

delete unused code in merkleTrie repository.



in block_db, for every block we are storing an entry in the X#d.dict dictionary. The key is the block hash, and the value is the location to read that page from the hard drive.
Maybe it would be better to look up the header, get the height from the header, and then use the height to know which page to read.


syncing blocks in reverse order.

-wait for hard update 27 to activate around Feb 27.
-switch from calc_roots2 back to calc_roots.
- sync blocks back to genesis. maybe a new version of cron/0 in sync.erl to sync the blocks in reverse order.
  -For old blocks we should just care if the hash is valid for the headers instead.
- verify that both forwards and reverse kinds of nodes can sync with a node that synced in reverse.

practice making smart contracts with people. make one smart contract every day.

consider getting rid of modes in otc_derivatives, move it to home page.

in otc_derivatives.html, some tool to automatically make a bet on an oracle hash, maybe some other preset bets, like a binary bet on whether bitcoin will go up or down in a time period. We can do the front-running protection where both dates are in the future.

for the bet resolution process, it would be nice if the page automatically looked up the result, so the user doesn't need to do it manually.

for pre-set bets, it would be nice if it could suggest a price based on the current veo/btc price or whatever they are betting on.

use the same method to select the price to trade, and for resolution.

in otc_derivatives.html, when you make a channel offer, there should be a button to immediately publish it to the p2p derivatives server, without having to open that page.

a link from the p2p derivatives page back to the light node otc_listener page. that way it is more obvious how to accept a trade.

test that the trade auto-populates correctly, when you link from the p2p derivatives page.




remove legacy code from otc_finisher. we no longer use channel data, we dont use function start1(). we don't use start_button


in otc_listner: 
maybe we should reconfigure it to be like “if X is true, you win Y veo. if not, you lose Z veo”
then you could get rid of most of the text there


simplify OTC_listener, look at the pic from Flinstone in /home/zack/Pictures/
* have a "see more details" button to reveal all the extra details about the smart contract.

rewrite otc_* in the light node



needed for cold storage https://github.com/zack-bitcoin/amoveo/issues/184
multi-tx from the light node


hard update to prevent an attack.
The attack mines a valid looking header, but doesn't reveal the block. 
So the rest of us aren't sure if it is better to build on that header, or to ignore it and build from the highest known block.
We could also include a Merkel root of the txs from the previous block, but they should all be salted with like a single 0 byte each.
That way, it is impossible to mine a valid block without knowing the txs from the previous block, so this will prevent any miners from building on the attacker's header.
So then this attack becomes the same as the selfish-mining attack, which we already know does not work.





syncing blocks in reverse order.
* checkpoints.




video about how to do betting with Amoveo. preferably with 2 narrators, one a beginner, and one with experience.



would be nice if there was a way to combine settling a binary derivative contract with a small payment. to incentivize them to settle earlier.






Now is 83342
find out which block the channel got created in
BFD1dYbhVe8vEzCmtu/70m+lPKXzDoKIHlNjGiJCXYeGapadChVENendo8G1XskHKfMD8G18kWdrJ2r9ok/iFV8=

in p2p_derivatives/channel_offers_ram:valid/1
the part that is like `true -> true`, we should check if the account's balance is big enough for the contract to be valid.


p2p derivatives web page should allow direct links to look up oracles or contracts.


update syncing blocks to use websockets.
That way nodes don't need to open their firewall in order to receive blocks.



restore the proof-of-existence txs, they are needed for hashlocking with sortition chains.

GPU verifier for the https://github.com/zack-bitcoin/vdf_calculate RNG, needed for sortition chains.

the tx types that will allow for sortition chains to exist.



consider setting up a backup system for pulling headers, if your IP isn't on the list.

explore alternative things for futarchy to optimize for:
sharpe ratio.
return/volatility

just maximizing for price isn't good. for example a 50% chance of 3x and 50% chance of going to 0 has a positive expected value.


fix the centralized betting tool.
Bets aren't being matched because when we run the smart contract it doesn't result in a delay of 0.
this is the old broken tool for matching -> channel_feeder:bets_unlock(channel_manager:keys()),
in order_book:match_internal2 we are calculating all the orders that are getting matched. We should collect all this information so we can update exactly those contracts to be matched.






Potential block should keep track of the 2 most recent version of the work, so that miners still working on the previous version aren't wasting their effort.




new_oracle binary oracle is not working.



chart to visualize historic difficulty

new_oracle.js governance_futarchy_oracle could suggest block heights automatically


update the scalar and binary market contracts to use the new strategy for generating oracle ids.
we can generate all 10 oids inside of chalang, so we dont have to embed 10 raw oids.
test out scalar oracles from the light node before pushing anything.

do a hard update to enforce the new way of generating oracle ids.

update the smart contracts to handle oracle that do not yet exist.

update the light node to handle contracts for oracles that do not yet exist.

check that p2p derivatives explorer can handle contracts for oracles that do not yet exist.



update p2p derivatives explorer to keep a record of which contracts expired unmatched, vs which were matched. This will make futarchy easier.




once the hard update activates at 76200
update the light node for the new channel close tx type.

update the light node to use the new simpler binary contract for p2p bets, but use the old one for centralized betting with the server.

write a simpler scalar contract.

update the light node to use the new simpler scalar contract for p2p betting.

make sure the light node still works for bets in the centralized market.

teach the light node chalang about the new destructive comparison opcode, and the new ways of encoding integers.

soft update. require that the oid of each oracle was deterministically generated from the height when trading begins and the question being asked.
* also update the light node to enable trading of derivatives on oracles that do not yet exist.


the new tool to execute a command when we find a block is not working, because currently the block isn't updated until you try pulling the data from it.



idea to improve the oracle mechanism
* block any bets that would leave the oracle in a state where less than 1 veo of volume of bets is sitting in the order book.
the advantage is that we could reduce the initial liquidity to 0, so it would be cheaper to make oracles.



add to chalang:
* load the next 1 byte as an integer
* load the next 2 bytes as an integer
* 50 or 100 opcodes that each load a single integer from 0-99 onto the stack. So we can use 1 opcode to load a small integer.
* we need to set up a soft update to activate this

add to chalang:
* grab arbitrary byte from a (binary or (an integer, which is interpreted as a 4-byte binary.))



try pushing a tx from the light node in chrome on a mac.


having trouble making channel_solo_close from the light node to close our channels.

The light node should store the entire compiled contract. That way, even if the rules for how to build the contract should change, our old signatures are still valid. And so we can update how the contract is built without invalidating existing contract signatures.

Make transactions to close the 5 channels in ~/oracles.md, and publish them somewhere publicly so that the other participant can close these channels.

rewrite the scalar market smart contract like market2.fs
update the light node to use these better contracts.



teach the master branch not to have zombie nodes trying to download non-existance blocks.



like, it should say somewhere that bad question means you get your money back


also, I think “you win if veo/stablecoin goes up” is the most intuitive way, when veo/stablecoin is a number quoted like 92 and not 0.01085

veo/stablecoin and stablecoin/veo labels might be backwards.

update futarchy documentation:
I think it is much better to use a % change in future interval
like, % change from block where reward increase goes thru until like 1000 more blocks or something
and then there isn’t the free option dynamic as much anymore

experimental version seems to have some race condition while syncing. alarmingly, you need to do `block_hashes:second_chance().` in order to get it to continue syncing after the error happens.


* add randomness opcodes to sortition chalang, as documented in opcodes.md load_seed and get_entropy.





We need to get the randomness into chalang, so we can make these sortition merkel proofs.
I guess we should choose a block hash to import as a binary?

Ideally we would use the block hash are the seed for a deterministic random number generator, that way we can have more than 256 bits of entropy from a single block hash.

So I guess I should use an erlang library for this, and add some chalang words to for:
1) load a block hash onto the stack.
2) load a seed into the random number generator
and then every time we call rand_bool, it can use the random number generator to make the decision.


teach the light node to use ctc2 instead of ctc.



Why did the light node follow it's own fork briefly?


sometimes the light node generates channel_team_close txs where one of the accounts spends more money than they have in the channel, so the tx is invalid.
- unable to reproduce.


amoveo light node channel team close should handle the case where the channel participants send their channel states to each other.
Either there should be a warning if you use the wrong channel state, or it should use the information to accomplish the goal anyway.

when you make a channel team close offer, give an option to save to file.

display the channel ID as much as possible in light node for p2p derivatives.


amoveo light node solo-close could be having problems.



lower the cost of question oracles.


figure out prob-payments from blitzkrieg.


figure out channel factories.





sometimes when a block syncs, the full nodes aren't clearing out their entire tx pool, and they keep an invalid tx. This could potantially prevent them from finding blocks, so it could be a serious error


if you block other nodes from talking to you, eventually you drop all your peers. This could be related to the memory leak causing there to be too many threads trying to sync at the same time.


we should be able to create channels for accounts that do not exist, and they are created when the channel is closed. for prob-channels.


* syncing blocks in reverse order.

* probabilistic payments.

every tx where you need a gov variable to calculate the new balances, put that gov variable into the block meta.


if `sync_mode:normal().` hasn't been done, and you try making a tx, there should be a useful error message.


rename the tx type to oracle_unmatched.


if we don't export our IP, do the other nodes blacklist us?
Why does it stop syncing eventually?



Why did the light node follow it's own fork briefly?




gov variable in block meta is in the wrong format.


if a node sits long enough, we end up with lots of threads downloading empty lists over and over.
it is requesting above the top height that anyone has



light node otc_listener.js "someone already did this contract. you are too late"
we should put a message to the screen to indicate this.

Some confirmation message when you accept a contract.

Stepan lost the channel state for a channel. What can we do to help him?

better error message if you try to look up a channel that doesn't exist in the light node.





tx_scan is failing, make some better tests.

to calculate the delete amount correctly,
* block:get_txs_main needs to be implemented



do a second pass, check if any delete_acc_tx has an amount too low.


we need a better warning system if a governance value is being changed.
message loloxian when it is ready.


we should probably store blocks and meta data seperately.

oracle_winnings and oracle_unmatched txs from the light node.



store the highest hash with each page of compressed blocks, since this makes it easier to organize the blocks and resync them later.
We should store the top hash of a page of blocks under the key "top".


issue with channel_team_close2
blocked because packer doesn't know about the key.
We can't fix packer directly, because some nodes would freeze.
1) mining pools should do a soft fork to block ctc2
2) we fix the packer library.
3) we give everyone a week to update dependencies.
4) we schedule a date to simultaneously turn off the soft fork in all the mining pools.
* currently here.
5) clean up now unused soft-fork code.




move all records to records.hrl . Many developers are exposed to the datastructure first, and then search for the file with the keys second. they have difficulty knowing which file to look in to find the keys.






futarchy markets:
* lower block reward
> if the block reward is below 0.3 veo, return bad. else return the price of USD in VEO.
> if the block reward is above 0.3 veo, return bad. else return the price of USD in VEO.
* lock the block reward with a set halvening schedule


set up a testnet



merkel tree memory leak for miners.



configuration option to not store any blocks.


automatically adding your IP to the list of peers is failing.


replace many dictionary data structures with ets.


otc_listener should display the channel ID.
* we did this, now we need to test it and then push to github.


make a javascript tool for managing channel states.
It should tell you which channels are ready to be closed, and display a chart for how much money is in each contract, how much longer until it can be closed, and store it all in a single file.


glossary long-veo/stablecoin on otc_derivatives and otc_listener


start closing some oracles


scientific notation oracles.
How about we combine a  binary and scalar oracle. so you can make a new binary oracle, and combine it with an old scalar oracle, to make a contract that either returns $0 or $200 of veo.
P = the amount of veo in $200 from 0 to 10; if A happens return P * 1024 / 10; if A doesn’t happen return 0


in the light node, when we look up oracles, we should verify that the hash of the question tx matches the hash stored in the merkel tree.


sharding.



in the light node update from bigInt js library to the BigInt built in the browser.


another button in otc_derivatives, this one for using oracles to make an inverse stablecoin.
So if the price of amazon shares in USD increases 5%, then your inverse stable shares will have decreased 5%.
The only difference is that whatever price the user types in as the initial price, replace that with (limit_max - the_price_they_entered). because everything is flipped vs a normal stablecoin.


people want shorts in holo/rvn/abbc


otc_listener should display the channel ID.


new_oracle should make some standard format for oracles so that we can easily parse the oracle question and other tools can say if it is a USD stablecoin, or a BTC stablecoin, or whatever.
It could translate block heights to dates.
new_oracle page simplification.
We only ask for: 3-letter ticker, maturity data, and max price, short/long
Then the oracle question will be more standardized, so we can parse it easier at other steps.

Also standardize inverse stablecoin oracles, so the interface for making bets can be simpler.

Maybe change the name on the "stablecoin" button in otc_derivatives. It is for more things than just stablecoins.
"scalar - simplified" and "scalar - advanced" could be good names on the buttons.


The p2p derivatives pages have too much info. remove everything that we do not need.

add an atomic swap feature to api. look at the decred atomic swap example.

channel team close should have a limit, so it needs to be posted in the next 10 blocks to be valid.
To prevent people using it as a free option.
* being written in channel team close tx 2.




reduce orphan rate on small pools.

a tool to review the state of your active contract.

stablecoin interface in the light node should accept bets in either direction.

instead of displaying the oracle upper limit, it should just have an error message and block you from continuing if it can't load the upper limit.

maybe we need an extra confirmation so that with the scalar interface you don't accidentally make a bet where your partner puts nothing at stake. display the same text from otc_listener in otc_derivatives when making a contract.

add salt to amoveo smart contracts for privacy

moving bets to a direct path.

a website for listing channel offers.


maybe it was a mistake to set up int_handler.erl to always return 2-tuples that start with "ok".


What if 2 people try to match to create the same channel? is the error message useful?


in otc_finisher, if the oracle is already closed test making a ctc to close the channel.


we should use nlocktime on all the txs so that it isn't possible to profitably undercut and include future txs at an earlier height. It should be impossible to move any tx into a block height from earlier than the tx was made.
* if we add maturity times to block rewards, then we can't use the block reward for anyone-can-pay txs.


hard update to support something similar to anyone-can-spend tx types in bitcoin. This is an important tool so that miners can share windfalls, that way miners never have an incentive to undercut each other's blocks.
Thank you to Fernando Nieto https://twitter.com/fnietom for explaining this solution to me.




option to customize the delay when making p2p oracles.


refactor the chalang market and oracle a lot.


Maybe tx fees should be put into a pool, and the pool distributed to the miners over time.
This way we can safely make the block reward lower than the tx fees.


oracle bets should reference the previous block's hash, that way you can't reuse many in a reorg attempt.

api to check what a scalar oracle will output if no more bets are made.

test solo-closing the channel from the p2p derivatives node. make sure the correct amount of money is moved.

test the case where someone pays a higher fee.
* the limit order trick for new channels probably does not work in the long run, because you can make off-chain tx fees.

unmatched:dict_significant_volume, we should probably be checking if manyOrders is >1, not 2.

would be nice if in otc_finisher the same file upload spot could accept either channel states or trade offers, so that the interface can be simpler.


api:oracle_bet should have a useful error if you try and use a floating point value

light node should tell you if you have insufficient balance to ask the oracle a question.

figure out what went wrong with the stablecoin contract to Evan Pan.

when you make contracts in the p2p tool, we should check that you private key matches the address in the channel of the contract.

in otc_finisher.js we need to make it clearer how to write the final price. people confuse veo/usd with usd/veo.
We should have some confirmation saying what portion of the veo goes to each party.

similarly, if you accept a proposal from someone, it should say something about how much of the money goes to each party.


We should sum up input money and output money from each block to double-check that there is no counterfeiting.

combinatorial chalang contract tested. combinatorial_market.erl written.

in the light node, the contract offers should have time limits other than 100.

in otc_finisher, it should display the details of whatever bet you have made.

in otc_finisher, we never need to save the channel state, so get rid of that button.

consider paying the exchange digitalprice.io to list Amoveo.

We need a theory of the flavors of trust.
Between 0 trust and 100% trustlessness, are there discrete layers, or is it continuous?


Now we have tools for signing and verifying on spks.
spk:sign/1
spk:unwrap_sig/1 %this converts the new kind of signed spk into something that can be verified the old way, it leaves the old kind of spk unchanged.

* replace every case where we sign an spk with spk:sign.
* replace every case where we check a spk's signature with testnet_sign:verify(spk:unwrap_sig(Stx)).



add endpoints to the amoveo api to access other amoveo services that could be running on the same machine. use white-lists, don't let them connect to internal api or run anything dangerous.


simpler way to customize port instead of 8080



### Other hard fork ideas


we should have a time limit in channel team close txs to prevent the free option problem in some cases where they want to close the channel early.


Maybe block rewards should be locked for a week to prevent P+epsilon attacks against the consensus mechanism.
Maybe locking for less than a week would be enough.
Calculate how much time the coins would need to be locked up for.


free option problem when closing a channel early with CTC.
Right now we only use the nonce of acc1.
So there is no free option if acc1 signs first, since acc1 can make another tx to make the ctc invalid if it isn't published soon enough.
We should update CTC to accept the accounts in either order, that way acc2 could sign first by listing themself first.

* we need to add more information to all the txs. when a channel is closed, it should say how much money is going to each participant, and there are many other cases.

* we should give a reward for closing oracles.

* merkel proof and verification code for txs in blocks. and rewrite it to javascript. That way we can prove if a tx has been included in a block.

* the oracle should say the sum of open bets, otherwise it is so complicated for light nodes to request a proof of this information.

maybe governance oracles should have a minimum amount they need to be changed by. otherwise an attacker can block an oracle from being made by keep making the same oracle to only change 1%.

Maybe we should add a governance variable for each opcode in the VM. To be a gas price per opcode.


maybe channel_team_close_tx should have a negative fee. As a reward for deleting the channel.
We could raise the fee for opening channels, and the reward for closing them.
This would prevent attacks where the attacker opens too many channels, and tries to close them all in too short of a time period.

* rename oracle_bets and orders. (is this a hard fork??)



### governance ideas

* we should probably lower the block size limit more.


### Things to do

tree_data:idut2/4 needs to be updated to support light nodes.




find out where fees are coming from if you keep forming and canceling bets.

some oracles can never be closed. we should stop returning them from any queries of the oracles.

maybe we should do block_hashes:second_chance(). on restart, because it makes usability easiler without significantly impacting the cost of restarting.

add a function to api instead of api:orders/1. so we can look up the unmatched bets in one oracle.
figure something to replace the oracle_bets endpoint in ext_handler, it should probably be removed.

remove mentions of "testnet"

chalang should be aware of the block time.
use the block time in a new version of the market.


* people should be able to use a light node to make channels with custom bets directly between each other.
https://github.com/zack-bitcoin/light-node-amoveo/issues/4

* remove depreciated javascript code.

* untrusted third parties who hold channel data and publish it if a channel is closing wrong.

* if channels mode is turned off, then don't share your pubkey from the api.

* when we first sync a node, it should automatically try to pull headers from a bunch of different peers. This way we are more likely to find out about the highest header.

* torrent of the light node.

* confirmed_root has the constant "confirmations". it needs to be combined with something from the configurations.

* we should blacklist peers who send us invalid blocks. Ignore any messages from them.

* we rarely change any governance value, so why does the pointer increase so much?

* teach the light node to scan multiple servers to identify the version of history with the most work.

* light node should know how many bets are outstanding for it's account in oracles.
*light node needs to be able to look up the volume of oracle bets. (or at least put it on the explorer for now.)

* fix variable and function names for readability.


* there is a bug. channel data gets stored into the channel manager, even if the tx didn't get produced.

* Once a share is matched, then we know exactly how much veo it needs. So we should simplify the contract and extract the excess veo to be used in other smart contracts in this channel.

* We need a way for pairs of people to write a custom CFD contract for a single channel between them using only the light node.

* the integration test should include removing old bets from the channel state. javascript can do it, so erlang should be able to as well.

* in ext_handler:new_channel/3, we accept channels made in either direction, is this really secure? Make sure we don't assume the direction in any other step.

* add a note to this hard fork that full nodes running markets will need to close all of those markets first before doing this update. Channels do not have to be closed, they can contain old and new contracts at the same time.

* in channels.js we need to give the user a chance to confirm that the period, server_pubkey, and expiration are all the expected amounts. Along with anything else from ext_handler:market_data



* transactions are being dropped ??

* voting in the oracle from a light node.

* we need to display more oracle data:
- total matched bets of each type.
- total unmatched bets.

* partial refund for closing a channel early.

* make it more clear what the cost of forming channels is.

* if you try making a channel with all of your veo, then the tx gets dropped, but the server still stores channel state. So you are unable to make a new channel. We need to prevent this failure mode.
- maybe we should have a button for putting all your veo into a channel.

* the light node should probably have more feedback when you do stuff.
- when you make a channel, it should say something about if the tx succeeded.

* make sure there is no epmd vulnerability letting people connect to our full nodes remotely.
 - Maybe setting the environment variable export ERL_EPMD_ADDRESS=127.0.0.1 will disable access from outside. I could test this at a later time

* test out the full contract resolution in light nodes to make sure we are displaying amounts correctly.x

* when sharing blocks, compress them first. we probably need a new http handler for this, since the existing handlers are assuming JSON format.

* enable running multiple instances of amoveo on the same machine using different ports.

* dominant assurance markets.

* light wallet improvements suggested by OK.

* combinatorial markets.

* spend_tx is using global state "mode". This should instead be passed to the function.

* maybe we should have a game to see who can keep testnet mining pools active most, during the game we encourage spamming each other and making unusual transactions to cause problems.

* consider adding a debugger. add this line to amoveo_core.app.src: `debugger, wx, reltool, erts, observer, tools, sasl, compiler, et, runtime_tools`
u simply activate them whenever you want via the shell:
```
debugger:start().
 observer:start().
 ```

* maybe `error_logger_hwm, 50` should be raised to 10 000.

* consider making a light node in python.

* look at the pull request for the escrow tool.

* get rock-paper-scissors working in chalang.

* teach the light node to generate messages about oracles. to make it easier to know when to vote.

* make sure that in the markets, evidence outcome always has a bigger nonce than no_publish.

* maybe tx_pool_feeder should make a new thread for each tx being added, and listen for a response. If it doesn't respond in time, then drop the tx.
- Maybe txs should return error codes instead of crashing

* improve signal|noise ratio in logging.

record tx_pool should keep track of the block hash that it is building on.

* we should have more rules for ignoring bad peers. If they send the same request too often, or if they send invalid data more than 10 times per minute. 

* during DDOS, sometimes nodes end up dropping all their peers, and are then unable to sync. We should refuse to black list the hard coded peers.
- dangerous, someone else might rent the same ip.


* check that txs don't get dropped when a block is orphaned.

* is merkle spk.js looking up the merkle proofs for the wrong information??

* the market.fs contract has a problem. Is the expiration date output of the contract relative, or absolute? I am not consistent.

* we should test the case when there are multiple partially-matched trades in the order book simultaniously.

* when you make a channel in the light node, there should be a way to look up how much the server charges before

* the light node should have an interface for encrypting and decrypting messages.
* display oracle data verified by merkle proofs.

* harden mining pools against attack.
- Consider hiding some of the API behind a fire wall.
- put a limit on how many blocks you can download with a single request.
- when syncing you should simultaniously download blocks from multiple peers to spread the load.
- limit how many bytes we serve to any one IP per 10 seconds.
- as well as downloading X number of blocks at a time, we should enable downloads of M megabytes of blocks at a time.

* if you haven't done `sync_mode:normal().` and you try to publish a tx, then there should be some sort of error message. Maybe connect it to the tx signing function.

* test downloading the light wallet. There are reports that it is not connecting to a full node easily.

* if you have the wrong private key loaded into a light node and try signing a tx, it should give a useful error message.

* port "8080" defined in more than one place.

* documentation for governance oracles
You have to set it between 1 and 50 inclusive.
if the governance variable is above 100, then it is a percentage.
If the governance variable is below 100, then it is an integer value.

So if governance is currently 40, and you change by 30, you can go to 10 or 70.
If the governance is currently 1000, and you change by 30, you can go to 1300 or 700.

- true means higher and false is lower, right?


* ubuntu 18.04 compatibility.

* order_book:match() should have a timer so we only run it every 3 minutes. Otherwise it is wasting cycles while we are syncing blocks.

* in proofs:txs_to_querys2, in the oracle_close branch, we are using Accounts and we should be using Accounts2.

I think he means put an entry in /etc/hosts for amoveopool2.com such that it points to your pool... but that would only work if your pool accepted /work on the end of the URI
* update pool to accept /work
* make a script to take advantage of the /etc/hosts trick.



* maybe potential_block.erl should save the 2 most recent blocks, so if a nonce doesn't work on one, we can try the other.

* the market user interface should say how many blocks until the next batch.

* prevent the creation of markets with batch periods that are too short to be secure.

* add the hash of the github commit in the explorer.
% git ls-remote | grep HEAD

* atomic swap protocol

* main.html from the mining pool should say the total number of miners, and the total outstanding shares.

* check the case where someone sends a good headers with a bad block. Don't ignore the good block after this happens.

* miners need instructions on making pubkeys.

* test_txs(15). channel slash isn't being automatically created.

* It is not clear in the docs on github how to update values in the config file. 

* if the response from {give_block, Block} is not base64 encoded, then it freezes us from pushing the new block to peers. We should probably decode it manually so that we can handle errors better.

* potential block:new_internal2 can use headers:top_with_block instead of the slow block_to_header.

* test the case where we know about more headers than blocks, and we want to recover the network by mining a new version of history.

* it seems like if we are aware of txs from future blocks, it can prevent us from verifying those future blocks.

* sync gen server is getting a too-full mailbox, and it is filled with unnecessary repeat data.

* optimize the protocol for trading peers and txs. Only send txs and peers that they don't know about. Trade these lists less frequently, right now it is too much bandwidth.

* decrease how often miners try to sync.

* we are wasting some time syncing with ourselves.

* it isn't switching to normal mode well !!!!!!!!!!!!!!!!!!!!!!!!!
maybe we should switch back to the original idea. If it finds less than 1 block per 5 seconds in the last 2 minutes, then switch to normal mode.
- update docs getting-started/turn_it_on.md

* measure the rate at which blocks have been found in the recent 2 minutes. if the rate is < 1 block per 30 seconds, then switch to sync_mode normal.

* in the mining pool, we need to make the cron task into a gen_server so that it wont crash.

* if a peer refuses the blocks we send them, then blacklist them.

* it is confusing how we have sync:start/sync:stop and we also have sync_mode:quick/sync_mode:normal.
Can't 1 flag do both things?

* instead of downloading a certain number of blocks at a time, we should have a certain number of byts we download at a time.

* if you make several txs in a row, they don't all get included in a block.

* fix compiler warnings. unused variables and such.

* delete unnecessary messages

* we should probably delete and rebuild the configuration files every time we build the project. That way you don't have to ever manually delete them.

* limit how much bandwidth any individual IP can consume.

* decrease data volume requirements.

* if you try turning the node on while it is already on, it should at least give you error warnings. At best it should also refuse to corrupt it's database.

* the documentation needs to be clearer that you are not supposed to run the software as root. you are supposed to make an account.

* the explorer should say how many headers, and how many blocks the node it is connected to has.

* maybe we should use pkill instead of killall in c-miner clean.sh

* the light node should automatically know whether you need a spend_tx or a create_account_tx.

* start out with more default peers.

* do txs get dropped from the mining pool tx_pool if someone else mines a block?

* the light node should have tabs, so it doesn't display so much at the same time.

* rethink the process of creating blocks and mining. It seems like race conditions might happen here.

* looking up blocks to push is too slow. we should look them up in reverse order to be faster.

* lightning payment api is not verifying data before using it. We should fail fast instead. Review the rest of the external api for the same problem.

* if the node is already running, then `make prod-restart` should do the same thing as `make prod-attach`

* `sync:stop().` should be called before `api:off().` when shutting down. put this in the documentation somewhere useful.

* config fork toleranace and config revert depth should be the same thing.

* documentation for sync_mode.

* in block_absorber.erl we are spawning a process that has to filter some txs. We can make this faster n**2 -> n*log(n).
- additionally, we should only do this calculation when in normal mode. If we are trying to sync blocks quickly, we can skip this calculation.

* in spk.js there is a spot where we should be verifying signatures, but we are not.

* spk get_paid and spk apply_bet should probably incrase the nonce by more than 1.

* When syncing we are building a potential block at every height. This is very innefficient. Instead we should download the entire history before building potential blocks.

* the mining pool should never spam the full node. They are on the same machine.

* rethink syncing. If you have more headers than the server, it fails to download blocks.

* The light node should allow for betting in the oracle. 

* when your bets get matched, the ss gets displayed in the browser. We should probably display more information along with the ss, so users can more easily tell if they need to use the smart contract enforcement mechanism.

* more tests of the attack where someone generates tons of fake peers and adds them all to the list.
- maybe we should limit how many peers we are willing to download from any one peer.
- There are some peers hard-coded into the core software. If these peers are not in our peer list, we should occasionally check to see if we can link with them again

* verify that the light node will not make a market smart contract where the server might not have enough funds to pay.

* if the peer isn't accepting blocks, then do not blindly give it more blocks.

* the light-node is memorizing the server's pubkey too early. If you change the ip you are connecting to, it should change the server's pubkey we store in ram as well.

* the light node fails badly. It should give useful error messages.

* The password is being recorded in the log. This is bad.

* it should be more obvious that miners need to insert their pubkey into c_miner and javascript_miner.

* the c-miner should have an easier way to decide which node you will connect to.

* We need to prune bets and orders.

* outstanding_orders.js needs to be a chart, that way we don't repeat the same words over and over.

* we need to test out the different formats for "true" and "false" in the javascript light node.

* go through every case in the light node where we do a variable_public_get. Make sure we verify the response as much as possible. Do not blindly sign or store anything from them for example.

* in sync.erl we should start by checking each peer's version, and then ignore peers who use the wrong version.

* secrets is leaking data.

* headers:test() is broken and unused.
* keys:test() is broken and unused.
* tester:oracle_test is unused.

* change vocabulary for channels. spk is a "contract". ss is "evidence".

* there should be a refund if you close a channel early. The refund should be enforced by a smart contract. It is important that this smart contract's nonce does not increase with time, otherwise the contract can be slashed forever.

* running sync:start() when we are already synced is causing some error messages.

* Use request_frequency.erl to limit how quickly we respond to requests from each ip address.

* make the pubkeys more convenient for copy/pasting. It would be nice if we used compressed pubkeys instead of full pubkeys. Maybe we should use the base58 library, or the pubkey checksum library.
Maybe encoding the pubkeys should happen at the wallet level, not the node level.

* pull channel state shouldn't cause a crash when the state is already synced.

* there needs to be an off switch on each market, so the market maker can gracefully stop his losses before too much information leaks. or does there? this should be thought out more.

- the market contract delays need to be long enough so that the contract is still live, even if the oracle takes a while to publish.

* analyze contracts to make sure they aren't unclosable, as explained in the attacks analyzed doc.

* the wallet should have some error messages:
- insufficient funds
- address incorrectly formatted
- lightning partner doesn't have a channel

* the readme should explain about public keys better

* If you use an incorrect password, there should be a useful error message.

* parts of the api need to be encrypted, to keep channel state private.

* Maybe we should make a way to run internal handler commands externally. Add a new command to the external api. To call this command, you need to sign the info with your private key, and it has a nonce inside that needs to have incremented from last time.



* calculating block_to_header is too very slow. Which means calculating the hash of a block is slow too.
* We should store the hash of the block along with the block, that way we don't have to re-calculate it more than once. When sharing blocks we can use this hash to quickly ignore blocks we have already seen, but for a block to be considered valid, we need to check at least once that the hash was calculated correctly.

* merkle.js should be able to verify proofs of the trie being empty in some places.

* light nodes should only download headers and a few recent blocks. They should verify blocks in parallel.

Get rid of any reference to "ae", "aeternity", and "testnet".

in the proofs dict we should have a flag for each thing to know if it has been updated. That way we can know exactly what to include in the batch update of the tree.

 Secrets module seems unnecessary. As soon as we find out a secret, why not use arbitrage to update all the channels immediately?

Cold storage and tools.

Download blocks talk/1 seems useless. talker:talk is accomplishing the same goal.

Javascript light wallets need to be able to do all the channel stuff that full nodes do. 

It would be nice if there were some macros for chalang/src/compiler_lisp2.erl that did backtracking. that way we wouldn't have to think about control flow when making smart contracts.

The current market design charges a 1/10000 fee on every trade. This is to protect from rounding errors.
There is a more elegant way to stop rounding errors. Set a certain maximum trade size. All orders must be measured in increments of the same size
A limitation of channels is that their output amounts are measured in integers from 0 to 10000.
Every 1 in G of the possible 10000 outputs can be valid.
A1 = amount of money getting matched from our bet,
A2 = amount of money in biggest possible bet,
B = A2 div 10000,
0 == A1 rem B
Making A1 rem B == 0 limits the possible output values of the contract, which slightly reduces liquidity. Being able to reduce the fee to zero is worth this small cost.

Blocks should be serialized to be fully compressed.

* We need some way of garbage collecting old channels from the channels manager once the channel has been closed long enough.

* reading from the hard drive can be slow. order_book can be updated to recover from errors without having to re-read everything from the hard drive.

* it is weird how spk_force_update22 in chalang.js calls run5. Since it's parent function is already calling the VM, it seems like we are running it multiple times unnecessarily.

* in tx_pool_feeder absorb_async we sleep for a little time. This is a hackish solution. There is probably a way to use an additional gen_server to make it efficient.

* maybe governance history should be stored by default.

* we need configuration options to decide which parts of the historical data you want to keep.
* it should be possible to store a shart of a tree.

* an api for downloading blocks in a compressed format. good for blocks with smart contracts.
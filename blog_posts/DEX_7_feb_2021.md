crosschain DEX update
=================

Today 2 people did an exchange using the Amoveo DEX, and neither of them were Zack.
10 veo were sold for 0.015 BTC.
Approximately $57 per VEO at the current BTC price.

[Here is the tool they used for the crosschain swap. They used the "crosschain DEX" tab on this page](http://64.227.21.70:8080/wallet.html)
 this tool is getting easier to use. Now it lists available offers for you to match, so you can do everything from this one page. It has better clearer error messages, so if you forget to load your account, or have insufficient balance, you will know why it isn't working.

[Here is the tx that activated the trade](http://64.227.21.70:8080/tx_explorer.html?txid=sH1uO/04Ux2HYc9gAl4z2QqNO8HnISxg7gYZjmZAG8M=)
Notice that it is using flash minting to combine several txs. It would have been impossible to do these txs one at a time in any order, but with flash minting they only needed 1.1 VEO instead of 11 VEO.

[Here is the smart contract enforcing the crosschain exchange](http://64.227.21.70:8080/contract_explorer.html?cid=OWByrUqzrM/3Zz6DkbqC4oM2/wsPgonBpESXvs4vzbc=) You can read the oracle text enforcing the outcome here. This oracle never actually went on-chain, because the 2 people swapping cooperated to get their money out faster and cheaper without needing to use the oracle.

[Here is the bitcoin address that received the payment](https://www.blockchain.com/btc/address/3NUw8Wd1JxVU98VjnKgFSnxNHEa8zutnVb)

[Here is the bitcoin payment](https://www.blockchain.com/btc/tx/45a1270f01540c17d17b57f859cb5a2a92475d7148d408fde8a441e144c48c04)

[Here is the tx where the person buying BTC release the veo, because the bitcoin had arrived](http://64.227.21.70:8080/tx_explorer.html?txid=c8lrn31kuF/2nxHJ42T53s8HCNAOYCh/N8Ti4dRNTnA=)

[Here is the tx where the person selling BTC combined the 2 share types of the contract to get their VEO out of the smart contract](http://64.227.21.70:8080/tx_explorer.html?txid=1NGS14+56OYk/3z5vK+/JStAf7dEvaTD2vcS3xiaNcY=)


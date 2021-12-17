Trustless Employment
=============

Alice wants to pay Bob for doing a job. She only wants to send the payment if the job is done. He only wants to be certain that Alice cannot refuse to pay him, if he completes the job.

Additionally, only Alice wants to hold VEO risk. Bob wants to be paid in a fixed amount of USD for the job.

Alice needs to make the USD stablecoin that she will use to collateralize the employment contract.

She opens her wallet.
Here is the one I am serving: http://159.89.87.58:8080/wallet/wallet.html
it is safest to download your own here: https://github.com/zack-bitcoin/light-node-amoveo

She goes to the "create stablecoin market" tab.

Alice doesn't want to deposit money into a uniswap market for this stablecoin, she just wants to create a new stablecoin contract. So for "amount of source currency to put into the market as liquidity" she selects 0. zero.

When Alice makes the contract, the page displays the contract ID for that contract. Alice will use the contract ID to deposit veo into the contract and get the stablecoins she needs to pay Bob.

Alice goes to the contract.html page.
Here is the one I am serving: http://159.89.87.58:8080/contracts.html
You also have it if you downloaded the light node. In the part that says "Advanced smart contract tools".

Alice scrolls down to the "subcurrency set buy" tool. This is where she can buy stablecoins from the stablecoin contract she just created. Alice chooses how much to buy, the number is written in Satoshis. 1 veo is 100 000 000 Satoshis.
Alice buys enough stablecoin to pay Bob.
Alice needs to wait a block to receive her stablecoins, before she can continue.

Next Alice wants to use her stablecoins as collateral for the contract to pay Bob.
Alice goes back to the wallet.html page.
Here is the one I am serving: http://159.89.87.58:8080/wallet/wallet.html
Alice goes to the "create binary market" tab.
As the source currency, Alice selects the stablecoin contract. Alice wants to use type 1, which is USD. not type 2, which is her leveraged VEO.
Alice chooses to put 0, zero, of her stablecoins into a market, because she doesn't want to make a uniswap market for this contract.
The initial probability doesn't matter, because she isn't making a market.
Alice needs to be very specific in explaining Bob's job. The oracle reporters need to be able to verify if Bob did it or not.

Once alice makes the binary contract, she receives a contract ID. This is the contract id that she will use to activate the contract with Bob.

Alice needs to deposit her stablecoin into this binary contract, so that she will receive the shares that are only valuable if Bob completes his job. Alice goes back to the contracts.html page so she can do this.
Here is the one I am serving: http://159.89.87.58:8080/contracts.html
Alice scrolls down to the subcurrency set buy tool. She buys a complete set of shares in the new binary contract. She uses all of her stablecoins for this.
Now Alice has both the shares that are valuable if Bob completes the job, and the shares that are valuable if Bob does not complete the job.

Alice needs to wait to receive the subcurrency in the block before she can continue.
Next Alice can send the shares of type 1 to Bob's address directly, using the spend tab in wallet.html.
Here is the one I am serving: http://159.89.87.58:8080/wallet/wallet.html

Alice might also consider sending them a little VEO, so that they can pay the tx fee to eventually convert their winnings to veo and sell on an exchange.


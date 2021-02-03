Amoveo Decentralized Exchange as of early Febuary 2021
=========================

We just had the first successful trial of the Amoveo DEX.
The purpose of this document is to explain the current process for how this works, so the community can understand where we are at now, and we can start planning a better UX.

In this trial I sold 0.182 VEO to purchase 160 DOGE.

[Here is the Amoveo smart contract](http://159.89.87.58:8080/contract_explorer.html?cid=Ly48mnz02wWo40+OprkLmkThN3IjPy66DrZs5pF88mo=) that was used to enforce the DEX.

Txs involved
================

[Here is the tx](http://159.89.87.58:8080/tx_explorer.html?txid=LRKiNTFWIG4SiXKnEerISzkgU02cziRs8L4XOanZPoM=) that used a flash mint to atomically:
* created the contract for enforcing the DEX
* purchase a 0.2 of a full set of shares in the new contract
* used the limit order to receive 0.182 VEO in exchange for giving 0.2 shares in the contract. Those shares would be valuable if the DOGE were not delivered.

This tx was signed and published  by the user who is selling DOGE to me. After sending this tx he was left holding 0.2 shares in the contract that are only valuable if the DOGE are delivered.

It cost 0.2 VEO to purchase the shares, but they received 0.182 VEO from this tx inside the same flash mint. So in total he only needed 0.018 VEO in order to create this tx and sell his DOGE.

Notice that the smart contract was not created until the limit order was matched. This means the limit order stays completely off-chain until someone matches it. So if you make a trade offer, and no one matches your trade offer, this costs you nothing.

[Here is the tx on the dogecoin blockchain](https://dogechain.info/tx/416ec24865ae4eef7c243a55fa0fca20549f428377385548b604cfeb1974da49) that was used to deliver the DOGE to my address.

[Here is the tx](http://159.89.87.58:8080/tx_explorer.html?txid=GDJGQCCINccjeE7hzZL28Si7yUFXP+IrIQFf+laZhq4=) that I signed and published after I had confirmed that the DOGE were delivered to me. The purpose of this tx is to unlock the VEO from the smart contract, so that they have access to the 0.182 VEO that I am paying for the DOGE, as well as the 0.018 VEO that they had locked into the contract. In total they are gaining access to 0.2 VEO.
The way this works is that I am spending the 0.2 shares from my stake in the smart contract to them. My shares would only be valuable if the DOGE had not been delivered. Since I can see that the DOGE have been delivered, I know that these shares are practically worthless.
If I had refused to send these shares to unlock their VEO, they could still get their VEO out of the smart contract by using an oracle to enforce the correct outcome.

At this point the person selling DOGE, they own 0.2 shares on both sides of the contract.
[Here is the tx](http://159.89.87.58:8080/tx_explorer.html?txid=pvmFkz1E7yD4nmW0FLtZFoPZcaKjyxhrS1MJNkWpdl4=) that they used to combine these shares back into 0.2 VEO.

Process for creating the offer to buy DOGE
============

We still do not have a dedicated UX for the DEX, so this process was done entirely with the more generic smart contract tools that can be used for any kind of smart contract. 

First off, I had to define the terms of the smart contract which would enforce the DEX. In this page http://159.89.87.58:8080/contracts.html I used the tool called "teach scalar contract"
in the section "what is being measured, and at what time?" I wrote: "the dogecoin address DMpm1ry3scQj4FMBogexyMMBUi6hBWyA6h has received less than 160 DOGE before 5 Febuary 2021 noon GMT time"
for "maximum value that can be measured, an integer" I wrote: "1". Because this is a binary contract. either the DOGE was delivered, or it was not.
Then I clicked "teach".

At this point the smart contract does not exist on-chain. But the p2p_derivatives server is holding a copy of the smart contract information, so it is now possible for the p2p_derivatives server to hold limit orders that trade in this smart contract.

After clicking "teach", the interface told me that the contract ID for this new contract is Ly48mnz02wWo40+OprkLmkThN3IjPy66DrZs5pF88mo=

I used this contract ID to build the limit order.
To build the limit order I used the "order book swap offer maker" tool.
I choose to make the offer valid for 150 blocks, which is a little over 1 day.
I offered to pay 0.182 currency. I left the next 2 fields blank, because I am paying in VEO.
I want to receive 0.2 units of subcurrency.
The contract I want to receive subcurrency in is Ly48mnz02wWo40+OprkLmkThN3IjPy66DrZs5pF88mo= , this is the contract we are creating to enforce the DEX swap.
I want to receive shares of type 1, because type 1 says that the DOGE did not get delivered.
That way, if the counterparty does not pay me my DOGE, I have shares that are worth 0.2 VEO to refund me.
I unclicked the checkbox that says "allow partially matching this limit order".
Because for the DEX I want to have exactly 1 counterparty: the person who is sending me my DOGE.
Finally I clicked the "publish the offer" button in the "publish an order book swap offer" section, so that my limit order would be visible to anyone, so anyone can sell me DOGE.

At this point anyone can see my swap offer in the same page in the "explore order book swap offers" tool by clicking the "refresh list of markets" button.

Process to sell DOGE
=================

The person selling me DOGE visited this page http://159.89.87.58:8080/contracts.html
They used the "explore order book swap offers" tool to view the swap offer, and clicked the "accept swap offer" button.

Next they sent me 160 DOGE to DMpm1ry3scQj4FMBogexyMMBUi6hBWyA6h

Process to unlock the VEO after receiving the DOGE
===============

I confirmed that I had received the DOGE.
Then to unlock their VEO, I used the "subcurrency spender tool" on that same page.
I sent them my shares in the Amoveo DEX smart contract.

For "contract id", I used Ly48mnz02wWo40+OprkLmkThN3IjPy66DrZs5pF88mo= , which is the Amoveo contract enforcing the DEX.
For "type", I used "1". Which is the kind of shares that I am owning in the smart contract.
For "to", I used "BLd2a8vvckvg0wPm8C99X1cSJl6s1m/zkpvzbzVOEkLXNr1eXrcVs61hMbgUgxH1Kjgox5MITDG144r0mdCH0Mo=", which is the Amoveo pubkey of the person selling me DOGE. [You can see the history of their account's txs here](http://159.89.87.58:8080/account_explorer.html?pubkey=BLd2a8vvckvg0wPm8C99X1cSJl6s1m/zkpvzbzVOEkLXNr1eXrcVs61hMbgUgxH1Kjgox5MITDG144r0mdCH0Mo=)
for "amount", I used "20000000" which is how many satoshis of shares that I owned.

Process to gain access to the unlocked VEO
=================

The person selling me DOGE used the "subcurrency combiner" tool on that same page.
For the "contract id", they used Ly48mnz02wWo40+OprkLmkThN3IjPy66DrZs5pF88mo= , which is the Amoveo contract enforcing the DEX.

This combines the 0.2 shares of type 1 with the 0.2 shares of type 2 back into 0.2 VEO.


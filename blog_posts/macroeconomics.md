Macroeconomics of blockchain
===============

The point of this document is to share a model of blockchain that can help predict how different events impact the market cap of the cryptocurrency. The model is optimized to explain the existential threat that will destroy all cryptocurrencies, if we can't find a solution in time.

Using an example from physics. We can model the blockchain as a pressurized container of gas. Each satoshi of currency is like a unit of space inside of the container, where gas particles can exist. The value of a satoshi corresponds to the kinetic energy of the gas particles inside that unit of space. The market cap corresponds to the total kinetic energy of all the particles inside the container.

The container leaks energy. If the economy has an interest rate of 4%, then that means the container loses 4% of its thermal energy every year, due to leaks. This is equivalent to Discounted Cash Flow valuation. Maybe it makes sense to think of these leaks as a kind of black body radiation. Since it depends on a background temperature, which corresponds to the interest rate of the wider economy.

Sometimes some money gets burned, or someone loses their private key, and the money becomes unspendable. This means that there are fewer places available for the gas to exist in. This corresponds with forcefully compressing the container smaller. As you compress the container, you are doing work to compress the pressurized gas. So, this gives energy to the system. If you delete 1% of the currency, this is the same thing as distributing that 1% to all other holders. The smaller container has more total energy. This is adiabatic compression.

Blockchains sell block rewards. Miners pay a cost in order to earn the block reward. In PoW blockchains, miners pay by doing expensive calculations. In PoS blockchains, miners pay in coin-hours by locking up other coins. The blockchain is like a big pressurized container where the pressure corresponds to the price of coins, and the block reward is like a tiny pressurized container where the pressure corresponds to the price of mining the coins in the block reward. If the tiny pressurized container has the same pressure as the big container, then connecting them together does not change the pressure in the big container. But, if the tiny container has a lower pressure, then this will slightly lower the pressure of the big container too. If the pressure in the small container equals the pressure in the big container, then putting them together is a reversible process. 

Blockchains have transaction fees. A transaction fee works like a combination of a burn and a block reward. If you pay a fee equal to 1% of the coins, that is like compressing the container 1% smaller, and then merging with a new container that is 1% the size of the existing container. So, the final volume of the container is unchanged, but the temperature inside the container is 1% higher.

We can predict how the market cap will change.
If the heat added to the system by transaction fees and burns is less than the heat lost due to leaks, then the temperature of the system is decreasing, so the market cap is decreasing.
If the heat added by transactions and burns is greater than the heat lost due to leaks, then the temperature of the system is increasing, so the market cap is increasing.

For a blockchain to be sustainable, we need some kind of negative feedback around the market cap. That means we need a restoring force, to keep the market cap somewhat stable. 
So, if the price is low, we need the fee pressure to exceed losses due to leaks so that the price goes up, and when the price is high, we need the fee pressure to be less than the leaks so that the price goes down.
If we don't have negative feedback, and we attempt to build the system on positive feedback, then the price will bounce around until it hits zero.

Blockchains today get their fees by auctioning off scarce block-space and consensus level cpu cycles.
The problem is that block-space and cpu cycles are more valuable when the market cap is high.
So, these kinds of fees are all giving us positive feedback instead of negative feedback.
That means that these kinds of fees can never work to sustain the market cap, even if they somehow got high enough (very unlikely), they still don't work.

How can we make blockchains stable?
Certain mechanisms do produce negative feedback.
A land registry for example, could have a market cap that stays proportional to the value of the land in the registry.
It has negative feedback, because when the currency's price is low, that makes the land's value relatively higher. When the currency is high, that makes the land lower.

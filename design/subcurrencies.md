What would it look like to add subcurrencies to amoveo? like erc20.

One way is if the smart contract wouldn't have any way to end and pay out.
The smart contract has a Merkle root of account balances. Making a payment involves providing a proof of your balance and a signed message with a nonce saying you want to make the transfer. you also need a merkle root of who you are sending to.
The smart contract calculates the new merkle root after making that transfer, and creates a child smart contract based on the new merkle root.

This is a very general way to design any smart contract, and the main chain stays stateless.
 
The merklized database of accounts data can be stored in a layer 2 network specialized for this subcurrency.

Keeping the main chain stateless means we don't need to touch the hard drive to process blocks. Touching the hard drive is the slowest part, so skipping this makes it fast.
Another way to allow for subcurrencies would be to let contracts have an option where they prevent any more deposits. So you can't convert veo to the subcurrency any more.

This strategy has the benefit that your subcurrency works with the Automatic Market Makers, and the currency-swap transaction types.

but it has the drawback that you can't program any other rules into it. It is just a subcurrency.
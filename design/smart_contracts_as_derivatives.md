Smart Contracts as Derivatives
==============


Scalability
==============

In order to be scalable, we need to get rid of all shareable mutable state. Shareable mutable state needs to be synchronized, and the synchronization cost is O((# of participants)*(# of mutations)). It doesn't scale.

Shared state cost is O(# of participants). it can scale.

Mutable state cost is O(# of mutations). it can scale.


Derivatives
============

Shareable immutable contracts, in the context of finance, are called derivatives.

a derivative is a kind of smart contract where there is some rule about how money will be divided up onto the different sides of the contract. The rule is written once at the beginning, and stays immutable until the end.

For blockchain applications, to create a new derivative we only need to put the hash of the derivative contract on-chain.
The contract itself is only put on-chain if we need it for enforcement.


Channels
===========

Mutable un-shareable contracts, in the context of blockchain, are called "n-party state channels", or "channels" for short.

Channels have mutable state that is known only the a finite number of participants.

Eventually, when the channel resolves, the final version of the state is committed to on-chain, and the channel transforms into a derivative.


Amoveo contracts
============

Amoveo contracts support both derivative and channel formats, and we make it as easy as possible to switch back and forth into these 2 scalable formats.

You can use any asset defined by a derivative as the collateral for making new channels, so this means you can convert immutable-shareable contracts into mutable-unshareable contracts as needed.

When channels get resolved, they transform into derivatives. So this means you can convert mutable-unshareable contracts into immutable-shareable contracts as needed.


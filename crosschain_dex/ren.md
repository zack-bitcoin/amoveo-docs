Ren Protocol
==========

Ren protocol is a kind of privacy mixer on Ethereum. Here is their [white paper](https://releases.republicprotocol.com/whitepaper/1.0.0/whitepaper_1.0.0.pdf).
Their white paper only talks about the mixer, not the crosschain exchange.

The mixer is based on a secure-multi-party-computation (SMPC) protocol where any 51% of the dark nodes can work together to reveal the trades.
If >50% of the dark nodes cooperate, they can see the orders, which breaks anonymity of the protocol.
Additionally, these dark nodes would be able to front run the orders, and commit free-option attacks against all of the orders, which is a way to steal from the users.

Since the trades are all encrypted inside the SMPC, the users have no evidence that this theft is occuring. The traders can't tell the difference between their trade matching at a bad price because of a legitimate crash in the price in the market vs the dark nodes cheating to front-run/free-option their order.

Ren Bridge
=========

Ren claims to be a tool for crosschain exchange, because they say you can make a wrapped version of BTC or ZEC or whatever, and then pass those wrapped tokens through the Ren mixer to transform them into a different kind of token.
The security of such a cross-chain exchange is based on the security of the protocol for wrapping the BTC into a token on Ethereum. BTC -> wBTC.

The protocol for wrapping BTC onto Ethereum is based on a team of trusted custodians who hold the BTC while you have your wBTC. You are trusting them to later exchange your wBTC for BTC.

This is insecure, because the custodians can decide to steal your BTC and not give it back in exchange for wBTC.

The insecurity makes the protocol unnecessarily expensive. The custodians need to receive enough fees so that the long-term expected profit from fees exceeds the short term expected profit from stealing the BTC.

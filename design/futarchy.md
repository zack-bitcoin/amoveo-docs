timeline of a futarchy bet
======
An unmatched trade that is still unmatched when the decision oracle resolves gets reverted.
If a trade is partially matched, the unmatched portion can still get reverted.

When the decision oracle resolves, the order book that doesn't get reverted, it's trades all turn into subcurrencies in a binary market who's result is determined by the result oracle.

LMSR
=======

how much money is in an lmsr market.
C = B * ln(e^(q1/B) + e^(q2/B))

instantaneous price 
price = e^(q1/B) / (e^(q1/B) + e^(q2/B))

on-chain data types
=======

* futarchy market- contains ids of both the result oracle and the decision oracle. has links pointing to both order books. 4 links in total, 2 for each book, because each book is 2 linked lists of unmatched orders. the current state of each of the 2 LMSR markets (how many shares of each type have been sold)

-record(futarchy,
        {futarchy_id, %deterministically generated from other values.
         decision_oid, %determines which market gets reverted.
         goal_oid, %determines who wins the bet in the non-reverted market.
         true_orders, %linked list of orders in the order book, by price.
         false_orders,
         liquidity_true, %liquidity in the optional lmsr market.
         net_shares_true, %shares of yes - shares of no.
         liquidity_false,
         net_shares_false})

* unmatched or unmatched order in the order book- the price you are trading at, the direction, the amount that you want to bet.

-record(futarchy_order,
        {owner,%who made this bet
         futarchy_id,
         decision,%the bet doesn't get reverted in which outcome of the decision oracle?
         revert_amount,
         limit_price,
         next %they are in a linked list sorted by price. This is the order book.
         }).

-record(futarchy_bet,
        {owner,%who made this bet
         futarchy_id,
         decision,%the bet doesn't get reverted in which outcome of the decision oracle?
         revert_amount,
         win_amount% > or == the limit_price
         }).


transaction types
=================

1) new futarchy market.
* id of the decision oracle
* id of the result oracle
* some initial liquidity for each of the 2 order book

2) futarchy limit order.
* id of the futarchy market
* which of the 2 order books to participate in.
* what price to bet at.
* how much to bet.
* bet on true/false.
* makes a new unmatched trade in the on-chain order book, or matches against an existing unmatched trade, or is partially matched.
* there is an optional lmsr market to give infinite liquidity.

3) futarchy resolve.
* id of the decision oracle, which is now resolved.

4) withdraw unmatched
* if you had an unmatched trade when the futarchy resolve tx happened, this is how you get your money out.

5) withdraw reverted
* if you had made a matched trade in the order book that got reverted, this is how you get your money out.

6) convert to binary
* if you had made a matched trade in the order book that did not get reverted, this is how you convert your money into a subcurrency in a binary market who's result is determined by the result oracle.

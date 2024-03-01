timeline of a futarchy bet
======
An unmatched trade that is still unmatched when the decision oracle resolves gets reverted.
If a trade is partially matched, the unmatched portion can still get reverted.

When the decision oracle resolves, the order book that doesn't get reverted, it's trades all turn into subcurrencies in a binary market who's result is determined by the result oracle.

LMSR
=======

q1 is how many shares of `true` have been sold. q2 is how many shares of `false` have been sold.

how much money is in an lmsr market.
`C = B * ln(e^(q1/B) + e^(q2/B))`
`C = q1 + (B * ln(1 + e^((q2-q1)/B)))`

instantaneous price 
`P = e^(q1/B) / (e^(q1/B) + e^(q2/B))`

Price to make a trade buying/selling d1 of q1 and d2 of q2
```
C2 - C1
= B*(ln(e^((q1+d1)/B) +
        e^((q2 + d2)/B)) -
     ln(e^(q1/B) + e^(q2/B)))
= B*(ln(e^((q1-q2+d1)/B) +
        e^(d2/B)) -
     ln(e^((q1-q2)/B) + 1))
```

on-chain data types
=======

* futarchy market- contains ids of both the result oracle and the decision oracle. has links pointing to both order books. 4 links in total, 2 for each book, because each book is 2 linked lists of unmatched orders. the current state of each of the 2 LMSR markets (how many shares of each type have been sold)

```
-record(futarchy,
        {futarchy_id, %deterministically generated from other values.
        creator, %provides liquidity for the lmsr, and needs to receive extra money from the lmsr later.
         decision_oid, %determines which market gets reverted. true/false
         goal_oid, %determines who wins the bet in the non-reverted market. yes/no
         true_orders, %linked list of orders in the order book, by price.
         false_orders,
         liquidity_true, %liquidity in the optional lmsr market.
         shares_true_yes,%total shares purchased for the case where the decision is true, and the goal is yes.
         shares_true_no,
         liquidity_false,
         shares_false_yes,
         shares_false_no,
         many_trades}).
```

* orders in one of the two futarchy order books.

```
-record(futarchy_unmatched,
        {owner,%who made this bet
         futarchy_id,
         decision,%the bet doesn't get reverted in which outcome of the decision oracle?
         revert_amount,
         limit_price,
         next, %they are in a linked list sorted by price. This is the order book.
         previous %by making it a double linked list, our proofs can be smaller. We don't need to prove the chain back to the futarchy market.
         }).
```

* bets that have been matched

```
-record(futarchy_matched,
        {owner,%who made this bet
         futarchy_id,
         decision,%the bet doesn't get reverted in which outcome of the decision oracle?
         revert_amount,
         win_amount% > or == the limit_price
         }).
```


transaction types
=================

1) new futarchy market.
```
-record(futarchy_new_tx,
        {pubkey, nonce, fee,
        decision_oid, %id of the decision oracle
        goal_oid, %id of the goal oracle
        period, %how long until the next fixed price batch can execute.
        true_liquidity, %how much money to put into liquidity for a lmsr market for the case where the decision is True.
        false_liquidity 
        }).
```

2) futarchy limit order.
* makes a new trade in the on-chain order book. If possible it is matched with other trades trades from the order book. The unmatched part is left in the order book.
```
-record(futarchy_bet_tx,
        {pubkey, nonce, fee,
        fid, %the id of the futarchy market
        limit_price, %the highest price you are willing to pay.
        amount, %the amount of veo you are risking.
        decision, %your bet is not reverted if this decision is selected. true/false
        goal, %you win if the goal oracle finalizes in this state. true/false
        tid, %id of the trade that is ahead of you in the order book. This value does _not_ get hashed when signing this transaction, but do hash it when calculating the txid and hashing the block.
        trade_number      
        }).
```

3) futarchy batch match.
* besides matching trades against each other, there is an LMSR market.
```
-record(futarchy_batch_tx,
        {pubkey, nonce, fee,
        fid, %futarchy id
        decision, %looking at the market that does not get reverted in this case.
        price, %the price that this batch will match at.
        true_matched, %ids of unmatched bets on true that will be matched or partially matched in this batch.
        false_matched});
```

4) futarchy resolve.
```
-record(futarchy_resolve_tx,
        {pubkey, nonce, fee,
        fid, %id of the futarchy
        decision_oid %id of the decision oracle, which is now finalized
        });
```

5) withdraw unmatched
- if you had an unmatched trade when the futarchy resolve tx happened, this is how you get your money out.
* id of the futarchy market
* amount of money that you will receive.
* bet_id
```
-record(futarchy_withdraw_unmatched_tx,
        {pubkey, nonce, fee,
        fid, bet_id, prev_id, next_id, amount});

6) withdraw reverted
- if you had made a matched trade in the order book that got reverted, this is how you get your money out.
* id of the futarchy market
* amount of money that you will receive.
```
-record(futarchy_withdraw_reverted_tx,
        {pubkey, nonce, fee,
        fid, bet_id, amount});
```

7) convert to binary
* if you had made a matched trade in the order book that did not get reverted, this is how you convert your money into a subcurrency in a binary market who's result is determined by the goal oracle.
* id of the futarchy market
* id of the smart contract where you will be paid.
* how the futarchy market resolved.
- potentially needs to create the binary smart contract.
```
-record(futarchy_to_binary_tx,
        {pubkey, nonce, fee,
        amount, futarchy_id, bet_id,
        contract_id});
```


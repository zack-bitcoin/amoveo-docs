Syncing before the verkle update
========================

Before hard update 52, by default the full node synced blocks chronologically. Starting at the genesis, and working towards the most recent block.
in the config file `config/sys.config.tmpl`, `reverse_syncing` should be set to `false`, or the line shouldn't exist.

If it isn't already turned on, then [turn the node on.](../turn_it_on.md)

It should download the headers and blocks automatically. wait for it to finish. If it freezes, you can start getting headers from a new peer with `sync:start().`. You can check the current number of headers with `api:height().`
You can turn off syncing with `sync:stop().` and it saves your progress so you can start again later where you left off.

Once almost all the blocks are synced, change it to normal mode like this: `sync_mode:normal().`. This optimizes the node for staying in sync instead of for getting in sync.
Finally, unlock the keys if you plan on generating transactions `keys:unlock("").`

you can use Control + D to detach from the node and let it run in the background

If you want it to stop syncing, you can use:
```sync:stop().```
it can be restarted with
```sync:start().```


Syncing after the verkle update
=======================

As of hard update 52, the verkle update, syncing in reverse is mandatory.
in the config file `config/sys.config.tmpl`, `reverse_syncing` should be set to `true`.

1) it should download the headers automatically. wait for it to finish. If it freezes, you can start getting headers from a new peer with `sync:start().`. You can check the current number of headers with `api:height().`

2) use `checkpoint:sync().` to sync with a random peer. or, you can use `checkpoint:sync(IP, Port).` to sync with a choosen peer, or if necessary, you can use `checkpoint:sync_hardcoded().` to sync with the node that the developer maintains. This will download the checkpoint, and start syncing from that point forwards.

3) Once almost all the blocks in the forward direction are synced, change it to normal mode like this: `sync_mode:normal().`. This optimizes the node for staying in sync instead of for getting in sync.

4) Once you have all the blocks to the top, start syncing backwards from the checkpoint towards the origin with `checkpoint:reverse_sync().`

5) If you also want to make txs, then you need to decrypt your private key:
```
keys:unlock("").
```


If you need to restart the process for syncing from the checkpoint forwards, use `sync:start().`  You can see the top block with `block:height().`

If you need to restart the process for syncing from the checkpoint in reverse back to the genesis, use `checkpoint:reverse_sync().` or `checkpoint:reverse_sync({IP, Port}).` to sync with a choosen peer.
You can see the lowest block you have with `block:bottom().`


to pause syncing in reverse:
`sync_kill:stop().`
Note that this stops it from syncing forwards as well.

to start syncing in reverse again after it has been paused:
`sync_kill:start().`
`checkpoint:reverse_sync().`
This also allows it to sync forwards again.




<<---- working below this line






Wait for it to sync the blocks. then do:
```
sync_mode:normal().
keys:unlock("").
```
you can use Control + D to detach from the node and let it run in the background

Syncing from a checkpoint
============

in the config file `config/sys.config.tmpl`, make sure that `reverse_syncing` is set to `true`.

When you turn the node on, you can sync headers with `sync:start().`.

After it finishes syncing headers, you can get the checkpoint with: `checkpoint:sync().`

You can download up to the top block by changing to normal sync mode. `sync_mode:normal().`.

It should sync all the old blocks in reverse, but if the thread crashes you can start it again with a different peer like this:
`checkpoint:reverse_sync().`

----->>

Advanced. For if something goes wrong.
==============

When you first turn on, it should automatically start downloading headers, and then it should automatically start syncing blocks.
Sometimes downloading freezes. you can start it again with the command:
```sync:start().```


After you sync the blocks, you will only automatically receive headers and blocks if you have port 8080 open so that peers can send them to you.

You can see how many headers your node has:
`api:height().`
you can see how many blocks your node has:
`block:height().`

You can only download a block if you already have the header for that block.


Once the node has synced nearly all the blocks, it needs to be changed from quick-mode to normal-mode like this:
```
sync_mode:normal().
```
This will allow you to automatically download blocks for any headers you already have, to process txs, to mine blocks, and automatically tell your peers when new blocks become available.

If you also want to make txs, then you need to decrypt your private key:
```
keys:unlock("").
```

Your peers will automatically send new headers to you. Once you get the headers, then you will automatically try and download blocks for them.
If your server doesn't accept connections from the internet, then you wont receive headers, and you wont try to download blocks. You node will seem frozen at one height.

Amoveo shares headers by pushing them, this way we can find out about new blocks as quickly as possible.
Amoveo shares blocks by pulling them, that way we can minimize the volume of data transfered, so we don't waste effort.

If you can't accept messages from the internet, possibly because you are behind a firewall, you can still get your full node in sync by manually requesting headers from a peer, like this:
```
P1 = lists:nth(3, peers:all()).%grabs 3rd peer from your list of peers.
sync:get_headers(P1).
```


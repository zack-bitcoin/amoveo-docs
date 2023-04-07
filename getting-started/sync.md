Basics
==========

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
P1 = lists:nth(3, peers:all()).%grabs 3rd peer from you list of peers.
sync:get_headers(P1).
```

If you want it to stop syncing, you can use:
```sync:stop().```
it can be restarted with
```sync:start().```

instructions for adding a new consensus level merkel tree to Amoveo, which is a more difficult kind of hard update.

in amoveo_sup.erl

`-define(trees`
add your new merkel tree process here so it will be turned on and off with the rest.

the 'trie_child' macro is used to start the merkel trees. start you new on there.


in block.erl

the defined tuple 'roots' or 'roots2', we need a new version, because there will be more merkel roots to include.

`  ((Height + 1) == F10)  ->` this line is where we update from 'roots' to 'roots2' a previous time that a hard update like this had been done.
You need to add some similar code to update the roots from the previous version to the new version.

make_roots/1 needs a new version to handle your new `trees` data structure.

roots_hash/1 needs a new version because of the new way of storing roots.

proof_roots_match/2 needs a new verison because of how roots are stored.

check/1 needs to see if we are at the hard update height, and update the trees database if we are.



in proofs.erl

tree_to_int/1 needs to handle the new kinds of tree, and int_to_tree/1


in forks.erl

get/1 needs to give us the height of the fork.


in governance.erl

name2number needs to handle the new trees.


in the trees/ folder.

add a file (tree_name).erl where (tree_name) is what you want to call your new merkel tree. if your name is multiple words, use underscores.

make sure to export these things so it is compatible
-export([new/2,
         %delete/2,%update tree stuff
         id/1, id/2,
         get/2, dict_get/2, dict_write/2,
         %write/2
         %dict_update/4, dict_update/5, dict_delete/2,%update dict stuff
	 %meta_get/1,
	 verify_proof/4,make_leaf/3,key_to_int/1,
         serialize/1,test/0, deserialize/1]).


in tree_data.erl

in internal/3, handle the new way of storing trees.

in internal_dict_update_trie/2 handle the new kind of trees.


in trees.erl

add functions for getting and updating value in the trees data structure.

update name/1, accounts/1, channels/1, existence/1, oracles/1, governance/1, matched/1, unmatched/1
and add a function like them for your new trees.
similarly, update the update_*/1 functions, where * is the names of the different trees.

update root_hash2 for the new ways of storing trees and roots.


records.hrl

a record for the new kind of trees.


Additional steps if you are making new kind of tx
==========

tx_pool_feeder

absorb_internal2 needs to know how much fees it needs to include the tx for mining pools.


txs/ folder

define it in a new file here.
make sure it defines the function go/4


txs.erl

key2module/1


in proofs.erl

txs_to_querys/2 needs to handle the new kinds of txs.


in block.erl

sum_amounts_helper/5 needs to be updated so it can run our backup checks that the total amount of money is corret.


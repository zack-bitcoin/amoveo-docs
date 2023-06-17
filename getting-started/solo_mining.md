
## Solo mining

#### During the process, if you face any problems, please see troubleshooting section at the end of this doc.

##### 1/ Cloning source
https://github.com/zack-bitcoin/amoveo

[install the amoveo full node and turn it on](./turn_it_on.md)

https://github.com/zack-bitcoin/amoveo-mining-pool

There are instructions for installing the mining pool and turning it on in the README of that project.


##### 2/ Now test your pool
run this in terminal
```
curl -i -d '["mining_data"]' http://127.0.0.1:8085
```
If it shows something like:
```
["ok",[-6,"F8iaECO9d0M2kmik0g0i9nMfAf6URiPOcrA0+VMIEUs=","52MYc3JWoVbIfHV0VEYTWqH/uf+R+qk=",257]]
```
Then you have correctly installed the mining pool.

### Troubleshooting

A common issue is erlang keeps running in background after crashing. you can kill all the erlang processes with `sh kill_all_erlang.sh`

Join us on telegram if you run into any issues while trying to solo mine.

<!--

##### If you mess up any source code and have no idea to fix:
```
git commit -am "mess up stuff"
rm -rf _build
git reset --hard origin/master
```
You can use git reflog and checkout to see what you’ve modified.

-->

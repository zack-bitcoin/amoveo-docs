#!/bin/awk -f

# satoshi's DAA
#once every 2016 blocks. retarget so the next 2016 take 2 weeks.

#eth classic
#G = genesis block difficulty
#DT = how many seconds it took to mine block N.
#Diff[N] = Diff[N-1] + int(Diff[N-1]/2048) * max((1 - DT)/10, -99)

#bitcoin cash ASERT
#exponent = (time_delta - ideal_block_time * (height_delta + 1)) / halflife
#next_target = anchor_target * 2^(exponent)
#* anchor block is the block where Bcash split from Bitcoin.
#* anchor_target is the unsigned 256 bit integer equivalent of the nBits value in the header of the anchor block.
#* time_delta is the difference, in signed integer seconds, between the timestamp in the header of the current block and the timestamp in the parent of the anchor block.
#* ideal_block_time is a constant: 600 seconds, the targeted average time between blocks.
#* height_delta is the difference in block height between the current block and the anchor block.
#* halflife is a constant parameter sometimes referred to as
#* ‘tau’, with a value of 172800 (seconds) on mainnet.
#* next_target is the integer value of the target computed for the block after the current block.

#Amoveo DAA
#Hashrate0 = Diff[N] / T
#EWAH[N] = 20/((1/Hashrate0) + (19/EWAH[N-1]))
#Estimate = Diff[N-1] / EWAH[N-1]

#if (Estimate > (Diff[N-1] * 3 / 2)) {
#   Diff[N] = Diff[N-1] * 3 / 2 / Estimate
#} else if (Estimate < (Diff[N-1] * 3 / 4)){
#   Diff[N] = Diff[N-1] * 3 / 4 / Estimate
#} else {
#   Diff[N] = Diff[N-1]
#}

function reward_per_hash(Node, Height) {
    if(!(Diff[Node, Height])){
	print("error. tried to calculate reward per hash when we don't know the difficulty " Node " " Height)
	throw("error")
	return
    }
    return(Reward[Node] / Diff[Node, Height])
}
function selfish_hashrate_winner(Time,      max, max_counter, i, X) {
    max = 0
    max_counter = 0
    for(i=1; i<= Chains; i++){
	X = reward_per_hash(i, Height[i])
	#print("chain " i " has rewards of " X)
	if(X > max){
	    max = X
	    max_counter = i
	}
    }
    return(max_counter)
}
function total_hashrate(Height,      t, i){
    t = 0
    for(i=1; i<=Chains; i++){
	t += Diff[i, Height]
    }
    return(t + Selfish_Hashrate)
}
function simulate(N,       SHWinner, i) {
    #each cycle of the simulator is 1 second, because it takes about 1 second for blocks to propagate, so smaller resolution isn't useful. When things happen in the same second, different participants find out about the two events in different orders, so it is effectively simultanious. 
    if((N % 100000) == 0){
	print("simulate round " N)
    }
    if(N < 1){
	print("simulate ended")
	return(0)}
    SHWinner = selfish_hashrate_winner(Now)
    #print(SHWinner " has the best returns.")
    for(i=1; i<=Chains; i++){
	if(i == SHWinner){
	    search_block(i, LoyalHashrate[i] + SelfishHashrate, Diff[i, Height[i]])
	} else {
	    search_block(i, LoyalHashrate[i], Diff[i, Height[i]])
	}
    }
    Now += 1
    return(simulate(N-1))
}

function found_block(Hashrate, Diff){
    #If the blockchain would have found more than 1 block in a cycle, this simulation counts that as only 1 block. this makes the simulation simpler and faster, without significant sacrificing accuracy, as long the rate of block production is slower than the cycle length.
    R = rand()
    #print("looking for block " R " " Diff " " Hashrate " " (1 - (1/Diff)) " " ((1 - (1/Diff)) ^ Hashrate) " " (R > ((1 - (1/Diff)) ^ Hashrate)))
    return(R > ((1 - (1/Diff)) ^ Hashrate))
    #return(R < math:pow(1 - (1/Diff), Hashrate))
}

function search_block(N, Hashrate, D,      R) {
    if(found_block(Hashrate, D)){
	#print("found block " N)
	Height[N] += 1
	Time[N, Height[N]] = Now
	Diff[N, Height[N]] = next_diff(Chain[N], Diff[N, Height[N]-1], Height[N], N)
    } else {
	#print("no block found")
    }
}
function max(a, b){
    if(a > b){return(a)}
    else{return(b)}
}
function min(a, b){
    if(a < b){return(a)}
    else{return(b)}
}
function next_diff(Chain, PrevDiff, H, N){
    if(Chain == "satoshi"){
	if((H % 2016) == 0){
	    DT = Time[N, Height[N]] - Time[N, Height[N]-2016]
	    #NextDiff = Target[N] * 100000000 / DT #
	    NextDiff = PrevDiff * Target[N] * 2016 / DT # 
	    NextDiff = max(NextDiff, Diff[N, H-1]/4)
	    NextDiff = min(NextDiff, Diff[N, H-1]*4)
	    #print("next diff satoshi Now: " Now " H: " H " N: " N " diff1: " Diff[N, H-1] " diff2: " NextDiff " target: " Target[N] " dt: " DT)
	    return(NextDiff)
	} else {
	    return(Diff[N, H-1])
	}
    } else if(Chain == "etc"){

    } else if(Chain == "bcash"){

    } else if(Chain == "amoveo"){

    }
}


BEGIN {
    srand()
    Now = 0

    Chains = 2

    Chain[1] = "satoshi" #100-coin reward 2016 blocks per period, targetting 600 seconds per block
    #Chain[2] = "etc" #
    Chain[2] = "satoshi" #
    Chain[3] = "bcash" #block-time of 600,
    Chain[4] = "amoveo" #block-time of 600, exponential weighting factor of 20

    for(i=1; i<=Chains; i++){
	Reward[i] = 100
	#Diff[i, 0] = 1000000
	Diff[i, 0] = 20000
	Height[i] = 0
	LoyalHashrate[i] = 10
	Target[i] = 600
	Time[i, 0] = 0
    }
    Reward[1] = 1000
    
    SelfishHashrate = 100
    #SelfishHashrate = 0
    
    TotalHashrate = total_hashrate(0)

    Cycles = 600*2016*5
    
    simulate(Cycles)
    for(i=1; i<=Chains; i++){
	print("chain number " i " with rule " Chain[i] " finished at height " Height[i] " and difficulty: " Diff[i, Height[i]])
    }
    #for(i=1; i<=(max(Height[1],  Height[2])/2016); i++){
    #X = i*2016
	#print(X " " Diff[1, X] " " Time[1, X])
    #}
    print((Time[1, Height[1]] - Time[1, Height[1]-2016])/ 2016 " cycles per block  on chain 1")
    print((Time[2, Height[2]] - Time[2, Height[2]-2016])/ 2016 " cycles per block  on chain 2")
    #print(Time[2, Height[2]] / Height[2] " cycles per block  on chain 2")
}


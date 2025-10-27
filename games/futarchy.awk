#!/usr/bin/awk -f

BEGIN{
    srand()
    slow_print("Bob programmed an update to make the Amoveo blockchain better")
    slow_print("We aren't sure if including his update is a good idea or not.")
    slow_print("Currently, the price of VEO is $4, but Bob says his upgrade will make the price of VEO increase.")
    slow_print("A futarchy market has already been created. It says the price of VEO without Bob's upgrade is $4, and the price of VEO with Bob's upgrde is $5.")
    slow_print("You have 4 possible bets available to you. ")
    slow_print("1) long-VEO conditional on Bob's upgrade not happening.")
    slow_print("2) short-VEO conditional on Bob's upgrade not happening.")
    slow_print("3) long-VEO conditional on Bob's upgrade happening.")
    slow_print("4) go short-VEO conditional on Bob's upgrade happening.")
    slow_print("your current balance of VEO is 100 (worth $400). How many VEO do you want to bet for each of the 4 choices? type the 4 numbers, and click 'ENTER'")
    receive_helper()
    slow_print("you have " veo " VEO, ")
    slow_print(LN " bet on long-VEO conditional on bob failing, ")
    slow_print(SN " bet on short-VEO conditional on bob failing, ")
    slow_print(LB " bet on long-VEO conditional on bob succeeding, and ")
    slow_print(SB " bet on short-VEO conditional on bob succeeding.")
    slow_print("to find out if Bob succeeds, press 'ENTER'")
    getline input < "/dev/stdin"
    if(rand() > 0.5){
        slow_print("Bob succeeded. His upgrade was put into amoveo. so, any bets you made that were conditional on bob failing, those bets have been reverted.")
        if(LN > 0)
            slow_print("your " LN " shares of long-VEO conditional on bob failing, are reverted back into " LN " of VEO.")
        if(SN > 0)
            slow_print("your " SN " shares of long-VEO conditional on bob failing, are reverted back into " SN " of VEO.")
        strike_price = 5
        veo = veo + LN + SN
        L = LB
        S = SB
    } else {
        slow_print("Bob failed. His upgrade was rejected from amoveo. so, any bets you made that were conditional on bob succeeding, those bets have been reverted.")
        if(LB > 0)
            slow_print("your " LB " shares of long-VEO conditional on bob failing, are reverted back into " LB " of VEO.")
        if(SB > 0)
            slow_print("your " SB " shares of long-VEO conditional on bob failing, are reverted back into " SB " of VEO.")
        strike_price = 4
        veo = veo + LB + SB
        L = LN
        S = SN
    }
    slow_print("you have " veo " VEO, \n" L " bet on long-VEO, \n" S " bet on short-VEO.")
    slow_print("to find out the final price of VEO, press 'ENTER'")
    getline input < "/dev/stdin"
    veo_price = 2 + (5*(rand()))
    slow_print("the final price of VEO is $" veo_price )
    if(veo_price > strike_price){
        slow_print("since this is bigger than the starting price of " strike_price ", long-VEO contracts grew in value, and short-VEO contracts fell in value.")
    } else {
        slow_print("since this is smaller than the starting price of " strike_price", short-VEO contracts grew in value, and long-VEO contracts fell in value.")
    }
    rat = veo_price / strike_price
    if(L > 0)
        slow_print("your " L " in long-VEO are converted into " (L*rat) " VEO")
    if(S > 0)
        slow_print("your " S " in short-VEO are converted into " (S / rat) " VEO")
    veo = veo + (L*rat) + (S/rat)
    slow_print("your final VEO balance is: " veo" VEO, and it is worth $" (veo * veo_price))
}

function receive_helper(){
    receive_4()
    LN = V[1]
    SN = V[2]
    LB = V[3]
    SB = V[4]
    veo = 100 - LN - SN - LB - SB
    if(veo < 0){
       slow_print("error. ran out of funds. you only have 100 VEO to bet. try again.")
       return(receive_helper())
    }
}

function receive_4() {
    getline input < "/dev/stdin"
    i = 1
    while(match(input, "[0-9]+[.]?[0-9]*")){
        s = substr(input, RSTART, RLENGTH)
        V[i] = s+0
        input = substr(input, RSTART+RLENGTH)
        i++
    } 
} 

function slow_print(x){
    print(x)
    system("sleep 0.1")
}

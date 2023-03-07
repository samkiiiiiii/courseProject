(* data type *)
datatype rank = Jack | Queen | King | Ace | Num of int;

(* basic version: the point of Ace is 1 *)
(* magic version: the point of Ace is 1 or 11*)

fun get_basic_point (card)=
    case card of 
            Jack => 13
        |   Queen => 12
        |   King => 11
        |   Ace => 1
        |   Num x => x;

fun cal_TP x:int = if (x mod 21) = 0 andalso x>0
    then 21
    else (x mod 21);

fun get_basic_TP ([]:rank list)= 0
    | get_basic_TP(x::xs) = cal_TP(get_basic_point(x)+ get_basic_TP(xs));

fun get_TP([]:rank list)= 0
    | get_TP(x::xs) =
        let 
            fun get_new (card)=
	        case card of 
    			Jack => 13
    		|	Queen => 12
    		|   King => 11
    		|   Ace => 11
    		|   Num x => x;	        
        val score_1 = cal_TP(get_basic_point(x)+ get_TP(xs))
            val score_2 = cal_TP(get_new(x)+ get_TP(xs))
        in 
            if(score_1>score_2) then score_1
            else score_2
        end;

fun judge_winner_basic(player1_list:rank list,player2_list:rank list) = 
    let val player1 = get_basic_TP(player1_list)
        val player2 = get_basic_TP(player2_list)
    in
        if(player1 > player2) then 1 
        else if(player2 > player1) then 2
        else 0
    end;

fun judge_winner(player1_list:rank list,player2_list:rank list) = 
    let val player1 = get_TP(player1_list)
        val player2 = get_TP(player2_list)
    in
        if(player1 > player2) then 1 
        else if(player2 > player1) then 2
        else 0
    end;


use strict;
use warnings;

package Tournament;
use base_version::Team;
use base_version::Fighter;

sub new{
	my $class = shift;
	my $self = {
		_team1 => undef,
		_team2 => undef,
		_round_cnt => 1,
	};
	return bless $self, $class;
	
}

sub set_teams{
	my($self,$team1,$team2) = @_;
	$self -> {_team1} = $team1;
	$self -> {_team2} = $team2;
}

sub play_one_round{
	my($self) = @_;
	my $fight_cnt = 1;
	print("Round $self->{_round_cnt}\n");
	my $team1_fighter = undef;
	my $team2_fighter = undef;
	while (1){
		$team1_fighter = $self->{_team1}->get_next_fighter();
		$team2_fighter = $self->{_team2}->get_next_fighter();
		


		if (not defined $team1_fighter or not defined $team2_fighter){
			last;
		}

		my $fighter_first = $team1_fighter;
		my $fighter_second = $team2_fighter;

		if($team1_fighter->get_properties() ->{speed} <$team2_fighter->get_properties() ->{speed}){
			$fighter_first = $team2_fighter;
			$fighter_second = $team1_fighter;
		}
		
		my $properties_first = $fighter_first->get_properties();
		my $properties_second = $fighter_second->get_properties();
		
		my $damage_first = $properties_first ->{attack} - $properties_second ->{defense};
		if($damage_first < 1){
			$damage_first = 1;
		}

		$fighter_second->reduce_HP($damage_first);

		my $damage_second = undef;
		if  (not $fighter_second->check_defeated()){
			$damage_second = $properties_second ->{attack} - $properties_first ->{defense};
			if($damage_second < 1){
				$damage_second = 1;
			}
			$fighter_first-> reduce_HP($damage_second);
		}
		my $winner_info = "tie";
		# print($damage_second);
				
		if (not defined $damage_second) {			
			$winner_info = "Fighter ".$fighter_first->get_properties()->{NO}." wins";
		}else{
			if ($damage_first > $damage_second){
				$winner_info = "Fighter ".$fighter_first->get_properties()->{NO}." wins";
			}
			elsif($damage_second > $damage_first){
				$winner_info = "Fighter ".$fighter_second->get_properties()->{NO}." wins";				
			}
		}
		
		print("Duel ".$fight_cnt.": Fighter ".$team1_fighter->get_properties()->{NO}." VS Fighter".$team2_fighter->get_properties()->{NO}. ", ".$winner_info);
		print("\n");
		# print($team1_fighter );
		$team1_fighter -> print_info();
		$team2_fighter -> print_info();
		$fight_cnt += 1;
	}
	print("Fighters at rest:");
	print("\n");
	my $team = $self->{_team1};
	my $team_fighter = $team1_fighter;
	while (1) {
		if (defined $team_fighter) {
			$team_fighter->print_info();
		}
		else{
			last;
		}
		$team_fighter = $team->get_next_fighter();
	}
	
	$team = $self->{_team2};
	$team_fighter = $team2_fighter;
	# print()
	while (1) {
		if (defined $team_fighter) {
			$team_fighter->print_info();
		}
		else{
			last;
		}
		$team_fighter = $team->get_next_fighter();
	}


	$self ->{_round_cnt} += 1;
	
	
}

sub check_winner(){
	my($self) = @_;
	my $team1_defeated = 1;
	my $team2_defeated = 1;

	my $fighter_list1 = $self->{_team1}->{_fighter_list};
	my $fighter_list2 = $self->{_team2}->{_fighter_list};

	for (my $i = 0 ; $i < scalar @$fighter_list1;$i++){
		if (not ${$fighter_list1}[$i] -> check_defeated()){
			$team1_defeated = 0;
			last;
		}
	}
	for (my $i = 0 ; $i < scalar @$fighter_list2;$i++){
		if (not ${$fighter_list2}[$i] -> check_defeated()){
			$team2_defeated = 0;
			last;
		}
	}

	my $stop = 0;
	my $winner = 0;
	if($team1_defeated){
		$stop = 1;
		$winner = 2;
		$stop = 1;
	}

	elsif($team2_defeated){
		$winner = 1;
		$stop = 1;
	}

	return $stop, $winner;
}

 sub input_fighters{
 	my ($team_NO) = @_;
 	print("Please input properties for fighers in Team $team_NO\n");
 	my @fight_list_team =();
 	for(my $fighter_idx = 4*($team_NO-1)+1; $fighter_idx<4*($team_NO - 1) +5; $fighter_idx++){
 		while (1){
 			my $properties = <>;
 			our @properties = split(' ',$properties);
 			my $HP = int($properties[0]);
 			my $attack = int($properties[1]);
 			my $defence = int($properties[2]);
 			my $speed = int($properties[3]);
 			# print($fighter_idx);
 			# print($HP);
 			# print($attack);
 			# print($defence);
 			# print($speed);
 			if($HP + 10*($attack+$defence+$speed) <= 500){
 				# reference
 				my $fighter =new Fighter($fighter_idx,$HP,$attack,$defence,$speed);
 				
 				push(@fight_list_team,$fighter);

 				last;

 			}

 			print("Properties violate the constraint\n");
 		}
 	}

 	return \@fight_list_team;
 }

sub play_game{
	my($self) = @_;
	my $fighter_list_team1 =  $self->input_fighters(1);
	my $fighter_list_team2 =  $self ->input_fighters(2);

	my $team1 =new Team(1);
	my $team2 =new Team(2);

	# print($fighter_list_team1);
	# foreach my $i(@$fighter_list_team1){

	# 	print($i);
	# }
	$team1 ->set_fighter_list($fighter_list_team1);
	$team2->set_fighter_list($fighter_list_team2);


	$self -> set_teams($team1,$team2);

	# print(${@{$self->{_team1} -> get_fighter_list()}}[0]);
	# print(${$self->{_team1} -> get_fighter_list()}[0]->check_defeated());
 	# foreach my $i(@{$self->{_team1} -> get_fighter_list()}){
 	# 	print ($i);
 	# 	print("\n");
 	# }
	print("===========\n");
	print("Game Begins\n");
	print("===========\n");
	my $order1;
	my $order2;
	my($stop,$winner) = (0,0);
	while (1){
		print("Team 1: Please input order\n");
		while (1){
			$order1 = <>;
 			my @order1 = split(' ',$order1);
 			my $flag_vaild = 1;
 			my $undefeated_number = 0;
	 		# print(${@{$self->{_team1}->get_fighter_list()}}[0]);
 			for my $order(@order1){
 				if(not($order >= 1 and $order <=5)){
 					# print("i am test in A\n");
 					$flag_vaild = 0;
 				}
 				elsif(${$self->{_team1} -> get_fighter_list()}[$order-1]->check_defeated()){
 					
 					$flag_vaild = 0;
 				}

 			}

 			for (my $var = 0; $var < @order1; $var++) {
 				for (my $j = 0; $j < @order1; $j++) {
 					if($var != $j && $order1[$var] ==$order1[$j]){
 						$flag_vaild = 0;
 						
 					}
 				}
 			}

 			for(my $i = 0; $i <4 ;$i++){
 				if (not ${$self->{_team1} -> get_fighter_list()}[$i] ->check_defeated()){
 					$undefeated_number += 1;
 				}
 			}
 			if ($undefeated_number != scalar @order1){
 				# print("i am test in A\n");
 				$flag_vaild = 0;
 			}
 			if ($flag_vaild){
 				# print("i am test in B\n");
 				last;
 			}
 			else{
 				print("Invalid input order\n");
 			}
 		}
 		print("Team 2: Please input order\n");
 		while (1){
			$order2 = <>;
 			my @order2 = split(' ',$order2); 
 			my $flag_vaild = 1;
 			my $undefeated_number = 0;	
 			for my $order(@order2){
 				if(not($order >= 5 and $order <=9)){
 					$flag_vaild = 0;
 				}
 				elsif(${$self->{_team2} -> get_fighter_list()}[$order -1 -4] ->check_defeated()){
 					$flag_vaild = 0;
 				}

 			}
 			for (my $var = 0; $var < @order2; $var++) {
 				for (my $j = 0; $j < @order2; $j++) {
 					if($var != $j && $order2[$var] ==$order2[$j]){
 						$flag_vaild = 0;
 						
 					}
 				}
 			}

 			for(my $i = 0; $i <4 ;$i++){
 				if (not ${$self->{_team2} -> get_fighter_list()}[$i] ->check_defeated()){
 					$undefeated_number += 1;
 				}
 			}
 			if ($undefeated_number != scalar @order2){
 				$flag_vaild = 0;
 			}
 			if ($flag_vaild){
 				last;
 			}
 			else{
 				print("Invalid input order\n");
 			} 				 							
 		}
	$self ->{_team1} -> set_order($order1);		
	$self ->{_team2} -> set_order($order2);	
	$self -> play_one_round();

	($stop,$winner) = $self-> check_winner();

	if ($stop){
		last;
	}
	


	}
	print("Team ". $winner." wins\n");

}
1;
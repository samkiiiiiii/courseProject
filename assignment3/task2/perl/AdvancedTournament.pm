use strict;
use warnings;

package AdvancedTournament;
use base_version::Team;
use advanced_version::AdvancedFighter;
use base_version::Tournament;
use List::Util qw(sum);

our @ISA = qw(Tournament); 


sub new{
	my ($class) = @_;
	my $self = $class->SUPER::new($_[1],$_[2],$_[3]);

	$self -> {defeated_record} = ();
	# print($self->{_round_cnt});
  	return bless $self, $class;
}

sub play_one_round{

	my($self) = @_;
	my $fight_cnt = 1;
	our $fighter_one_defeat = 0;
	our $fighter_two_defeat = 0;
	print("Round ".$self->{_round_cnt}."\n");
	my $team1_fighter = undef;
	my $team2_fighter = undef;
	while (1){
		$team1_fighter = $self->{_team1}->get_next_fighter();
		$team2_fighter = $self->{_team2}->get_next_fighter();
		# $team1_fighter ->buy_prop_upgrade();


		if (not defined $team1_fighter or not defined $team2_fighter){
			last;
		}

		$team1_fighter -> buy_prop_upgrade();
		$team2_fighter-> buy_prop_upgrade();

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
		if($fighter_second->check_defeated()){
			$fighter_one_defeat = 1;
		}

		my $damage_second = undef;
		if  (not $fighter_second->check_defeated()){
			$damage_second = $properties_second ->{attack} - $properties_first ->{defense};
			if($damage_second < 1){
				$damage_second = 1;
			}
			$fighter_first-> reduce_HP($damage_second);
			if($fighter_first->check_defeated()){
				$fighter_two_defeat = 1;
			}
		}




		my $winner_info = "tie";
		# print($damage_second);
				
		if (not defined $damage_second) {			
			$winner_info = "Fighter ".$fighter_first->get_properties()->{NO}." wins";
			$fighter_first ->record_fight("W");
			$fighter_second ->record_fight("L");

		}else{
			if ($damage_first > $damage_second){
				$winner_info = "Fighter ".$fighter_first->get_properties()->{NO}." wins";
				$fighter_first ->record_fight("W");
				$fighter_second ->record_fight("L");
			}
			elsif($damage_second > $damage_first){
				$winner_info = "Fighter ".$fighter_second->get_properties()->{NO}." wins";				
				$fighter_first ->record_fight("L");
				$fighter_second ->record_fight("W");		

			}
		}
		
		print("Duel ".$fight_cnt.": Fighter ".$team1_fighter->get_properties()->{NO}." VS Fighter".$team2_fighter->get_properties()->{NO}. ", ".$winner_info);
		print("\n");
		# print($team1_fighter );
		$team1_fighter -> print_info();
		$team2_fighter -> print_info();
		$fight_cnt += 1;
		# print("\n");
		# print("outside");
		# print("\n");

		# print($fighter_first);
		# print("\n");

		$self->update_fighter_properties_and_award_coins($fighter_first,$fighter_one_defeat,0);
		$self->update_fighter_properties_and_award_coins($fighter_second,$fighter_two_defeat,0);

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
			$team_fighter->record_fight("R");
			$team_fighter->print_info();
			$self->update_fighter_properties_and_award_coins($team_fighter,0,1);

		}
		else{
			last;
		}
		$team_fighter = $team->get_next_fighter();
	}


	$self ->{_round_cnt} += 1;
	
}

sub update_fighter_properties_and_award_coins{
	my ($self,$fighter,$flag_defeat,$flag_rest) = @_;

	if($flag_rest){
		$fighter->{_coins} = $fighter->{_coins} +$fighter ->obtain_coins() * 0.5;
		$AdvancedFighter::delta_attack = 1;
		$AdvancedFighter::delta_defense = 1;
		$AdvancedFighter::delta_speed = 1;
	}
	elsif($flag_defeat){
		
		$fighter->{_coins} = $fighter->{_coins} +$fighter ->obtain_coins() * 2;
		# if(not defined $self -> {defeated_record}){
		# 	@{$self -> {defeated_record}} = ();
		# }

		$AdvancedFighter::delta_attack =  1;
		$AdvancedFighter::delta_defense =  -1;
		$AdvancedFighter::delta_speed =-1;	


	}
	# elsif(defined ${$self -> {defeated_record}}[0]){
	# 	print("outside: hasdhashd\n\n\n");
	# 	if(ord(${$self -> {defeated_record}}[0]) eq "yes"){
	# 		print("inside: hasdhashd\n\n\n");
			
	# 	}		
	# }
	else{
		$fighter->{_coins} = $fighter->{_coins} +$fighter ->obtain_coins() ;

	}
	$fighter->update_properties();

	$AdvancedFighter::delta_attack = -1;
	$AdvancedFighter::delta_defense = -1;
	$AdvancedFighter::delta_speed = -1;

	# print("fighter no: ".$fighter->get_properties() ->{NO}."coins: ".$fighter->{_coins}."\n");
}

sub input_fighters{
	my($self,$team_NO) =@_;
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
 				my $fighter =new AdvancedFighter($fighter_idx,$HP,$attack,$defence,$speed);
 				
 				push(@fight_list_team,$fighter);

 				last;

 			}

 			print("Properties violate the constraint\n");
 		}
 	}

 	return \@fight_list_team;

}


1;
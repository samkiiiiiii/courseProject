use strict;
use warnings;

package AdvancedFighter;

use base_version::Fighter;
use List::Util qw(sum);

our @ISA = qw(Fighter); 

our $coins_to_obtain = 20;
our $delta_attack = -1;
our $delta_defense = -1;
our $delta_speed = -1;


sub new{
	my ($class) = @_;
	my $self = $class -> SUPER::new( $_[1],$_[2],$_[3],$_[4],$_[5]);
	$self->{_coins} = 0;
	$self -> {_history_record} = undef;
	



  	return bless $self, $class;	
}

sub obtain_coins{
	my ($self) = @_;
	if(defined $self->{_history_record}){
		if (scalar @{$self->{_history_record}} == 3){
			if(${$self->{_history_record}}[0] eq 'W' and ${$self->{_history_record}}[1] eq 'W'
			 	and ${$self->{_history_record}}[2] eq 'W'){
				return $coins_to_obtain * 1.1;
			}
			elsif(${$self->{_history_record}}[0] eq 'L' and ${$self->{_history_record}}[1] eq 'L'
			 and ${$self->{_history_record}}[2] eq 'L'){
				return $coins_to_obtain * 1.1;
			}

		}
			
	}
	
	return $coins_to_obtain;
	


}

sub buy_prop_upgrade{
	my ($self) =  @_;
	while($self->{_coins} >= 50){
		print("Do you want to upgrade for Fighter");
		print($self ->{NO});
		print("? A for attack.D for defense. S for speed.N for no.");
		my $choice = <>;
		if(ord($choice) eq 65) {

			$self->{attack} = $self->{attack} + 1;
			$self -> {_coins} = $self -> {_coins} - 50;
		}
		elsif (ord($choice) eq 68){

			$self->{defense} = $self->{defense} + 1;
			$self -> {_coins} = $self -> {_coins} - 50;		
		}
		elsif (ord($choice) eq 83){
		
			$self->{speed} = $self->{speed} + 1;
			$self -> {_coins} = $self -> {_coins} - 50;		
		}
		elsif(ord($choice) eq 78){
			
			last;
		}		
	
	}

	return 1;
}

sub record_fight{
	my ($self,$fight_result) = @_;
	# print("hihihiii");
	# print($fight_result);
	# print("\n");
	if(not defined $self-> {_history_record}){
		@{$self ->{_history_record}} = ();
	}
	push(@{$self-> {_history_record}},$fight_result);
	return 1;
}


sub update_properties{
	my ($self) = @_;
	if (defined $self->{_history_record}) {
		if (scalar @{$self->{_history_record}} == 3){
			if(${$self->{_history_record}}[0] eq 'W' and ${$self->{_history_record}}[1] eq 'W'
			 and ${$self->{_history_record}}[2] eq 'W'){
				if($delta_attack == 1){
					$delta_attack = $delta_attack +1;
				}
				else{
					$delta_attack = 1;

				}

				$delta_speed = 1;
				$delta_defense = -2;
				@{$self->{_history_record}} = ();
				
			}
			elsif(${$self->{_history_record}}[0] eq 'L' and ${$self->{_history_record}}[1] eq 'L'
			 and ${$self->{_history_record}}[2] eq 'L'){
				$delta_attack = -2;
				$delta_defense = 2;
				$delta_speed = 2;
				@{$self->{_history_record}} = ();
			}
			else{
				${$self->{_history_record}}[0] = ${$self->{_history_record}}[1];
				${$self->{_history_record}}[1] = ${$self->{_history_record}}[2];

			}

		}		
	}


	if($self->{attack} + $delta_attack > 1){
		$self->{attack} = $self->{attack} + $delta_attack;
	}else{
		$self->{attack} = 1;
	}

	if($self->{defense} + $delta_defense > 1){
		$self->{defense} = $self->{defense} + $delta_defense;
	}else{
		$self->{defense} = 1;
	}

	if($self->{speed} + $delta_speed > 1){
		$self->{speed} = $self->{speed} + $delta_speed;
	}else{
		$self->{speed} = 1;
	}
	return 1;
}

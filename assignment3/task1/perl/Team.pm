use strict;
use warnings;


package Team;

sub new {
	my $class = shift;
	my $self ={
    	_NO => shift,
    	_fighter_list => undef,
    	_order => undef,
    	_fight_cnt => 0,
  	};
  	return bless $self, $class;
};

sub set_fighter_list{
	my $self = shift @_;
	my $fighter_list = shift @_;
	$self -> {_fighter_list} = $fighter_list;
	# print($self -> {_fighter_list}."\n");
	return 1;
}

sub get_fighter_list{
	my $self = shift @_;
	#a scalar (4 in this case)
	
	return $self->{_fighter_list};
}

sub set_order{
	my $self = shift @_;
	my $order = shift @_;
 	my @order = split(' ',$order);
	@{$self ->{_order}} = ();
	for my $i(@order){
		# print("\n");
		# print($i);
		push(@{$self ->{_order}},$i);
	}
	$self ->{_fight_cnt} = 0;
}
	

sub get_next_fighter{
	my($self) = @_;
	# modify
	if ($self -> {_fight_cnt} >= scalar @{$self ->{_order}} ){
		return;
	}


	# print(scalar @{$self ->{_order}});
	my $prev_fighter_idx = ${$self ->{_order}}[$self -> {_fight_cnt}];
	my $fighter = undef;
	foreach my $_figher(@{$self ->{_fighter_list}}){	
		# print("i am first".$_figher-> get_properties() ->{NO});
		# print("i am second".$prev_fighter_idx);
		# print("\n")	;
		if($_figher-> get_properties() ->{NO} == $prev_fighter_idx){
			$fighter = $_figher;
			last;
		}

	}
	$self ->{_fight_cnt} = $self ->{_fight_cnt} +1;
	return $fighter;
}

1;


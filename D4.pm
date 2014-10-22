package Chemistry::PointGroup::D4;

use 5.008001;
use strict;
use warnings;

our $VERSION = '0.01';

my $h  = 8; # number of group elements
my @R  = qw( E C4 C2 C2f C2s ); # symmetry elements of D4
my @hi = qw( 1 2 1 2 2 ); # number of elements in the i-th class
my @I  = qw( A1 A2 B1 B2 E ); # irreducible representations
my %R;
@R{@R}=@hi;

# characters of the irreducible representations of D4
my @A1 = qw( 1  1  1  1  1 );
my @A2 = qw( 1  1  1 -1 -1 );
my @B1 = qw( 1 -1  1  1 -1 );
my @B2 = qw( 1 -1  1 -1  1 );
my @E  = qw( 2  0 -2  0  0 );

# my (%A1, %A2, %B1, %B2, %E);
# @A1{@R} = @A1; # A1
# @A2{@R} = @A2; # A2
# @B1{@R} = @B1; # B1
# @B2{@R} = @B2; # B2
# @E{@R}  = @E; # E


sub new {
	my $type = shift;
	$type = ref($type) || $type;
	my %Ur   = @_;
	return bless \%Ur, $type;
}

sub character_tables {
return <<'TABLE';
+----+----------------------------+------+
| D4 |  E   2C4   C2   2C2'  2C2" |      |
+----+----------------------------+------+
| A1 |  1    1    1     1     1   |      |
| A2 |  1    1    1    -1    -1   |  z   |
| B1 |  1   -1    1     1    -1   |      |
| B2 |  1   -1    1    -1     1   |      |
|  E |  2    0   -2     0     0   |  x,y |
+----+----------------------------+------+  
TABLE
}

sub symmetry_elements {
	return @R;
}

sub normal_modes {
	my $self = shift;
	return (3 * $self->{E} - 6);
}

sub irr {
	my $self = shift;
	
	# proper operations   ( Ur - 2 ) (1 + 2 cos(r))
	my $X_E   = sprintf "%0.f",  ($self->{E}   - 2) * (1  + 2 * 1);
	my $X_C4  = sprintf "%0.f",  ($self->{C4}  - 2) * (1  + 2 * (0));
	my $X_C2  = sprintf "%0.f",  ($self->{C2}  - 2) * (1  + 2 * (-1));
	my $X_C2f = sprintf "%0.f",  ($self->{C2f} - 2) * (1  + 2 * (-1));
	my $X_C2s = sprintf "%0.f",  ($self->{C2s} - 2) * (1  + 2 * (-1));
	
	# in the same order of @hi
	my @rr = ($X_E, $X_C4, $X_C2, $X_C2f, $X_C2s);
	
	# Irreducible representation
	my $s = 0;
	my $n_A1 = sprintf"%0.f", 
	(1/$h)*(map { [ $s += $hi[$_] * $rr[$_] * $A1[$_] , $s] } (0..$#hi))[-1]->[1];

	$s = 0;
	my $n_A2 = sprintf"%0.f", 
	(1/$h)*(map { [ $s += $hi[$_] * $rr[$_] * $A2[$_] , $s] } (0..$#hi))[-1]->[1];

	$s = 0;
	my $n_B1 = sprintf"%0.f", 
	(1/$h)*(map { [ $s += $hi[$_] * $rr[$_] * $B1[$_] , $s] } (0..$#hi))[-1]->[1];

	$s = 0;
	my $n_B2 = sprintf"%0.f", 
	(1/$h)*(map { [ $s += $hi[$_] * $rr[$_] * $B2[$_] , $s] } (0..$#hi))[-1]->[1];

	$s = 0;
	my $n_E = sprintf"%0.f", 
	(1/$h)*(map { [ $s += $hi[$_] * $rr[$_] * $E[$_] , $s] } (0..$#hi))[-1]->[1];

	my @ri = ($n_A, $n_B, $n_E);
	my %ri = ();
	@ri{@I} = @ri;
	return %ri;
}
1;

__END__

=head1 NAME

Chemistry::PointGroup::D4 - Point group D4

=head1 SYNOPSIS

see L<Chemistry::PointGroup>

=head1 DESCRIPTION

see L<Chemistry::PointGroup>

=head1 SEE ALSO

L<Chemistry::PointGroup>

=head1 AUTHOR

Leo Manfredi, E<lt>manfredi@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2006 by Leo Manfredi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

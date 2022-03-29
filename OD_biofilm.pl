#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use 5.010;

# Input file
my ( $dir, $DEBUG, $filename );
GetOptions(
	'f|file=s' => \$filename,
	'db|debug' => \$DEBUG
);
if ( !defined $filename ) {
	say "No filename passed.";
	exit;
}

open( my $fh, "<", $filename ) || die "Cannot open $filename";
say "id\tbiofilm_production";
while ( my $line = <$fh> ) {
	next if !$line;    #Ignore empty lines.
	next
	  if $line =~ /^\D/
	  ; #Ignore lines that start with a non numeric character (like the header).
		# Result
	my ( $isolate_id, $OD_neg_control, $OD_neg_control_SD, $OD_sample ) =
	  split /\t/, $line;
	my $biofilm_production =
	  biofilm_production( $OD_neg_control, $OD_neg_control_SD, $OD_sample );

	# Output
	say "$isolate_id\t$biofilm_production";
}

##SUBROUTINES##
# ODc formula
sub ODc_formula {
	my ( $OD_neg_control, $OD_neg_control_SD ) =
	  @_;    #Pass the fields to another place (biofilm_production subroutine)
	my $ODc = $OD_neg_control + ( 3 * $OD_neg_control_SD );
	return $ODc;
}

# Biofilm production conditions
sub biofilm_production {
	my ( $OD_neg_control, $OD_neg_control_SD, $OD_sample ) =
	  @_;
	my $ODc = ODc_formula( $OD_neg_control, $OD_neg_control_SD );
	if ( $OD_sample <= $ODc ) {
		return "none";
	}

	if ( $ODc < $OD_sample and $OD_sample <= 2 * $ODc ) {
		return "low";
	}

	if ( 2 * $ODc < $OD_sample and $OD_sample <= 4 * $ODc ) {
		return "medium";
	}

	if ( 4 * $ODc < $OD_sample ) {
		return "high";
	}

	else {
		return "null";
	}
}

#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;


# Input file
my ( $dir, $DEBUG, $filename );

GetOptions(
    'd|dir|directory=s'  => \$dir,
    'db|debug'   => \$DEBUG
);
if (!defined $dir){
	$dir = '.';
	
}


my @file = glob("$dir/*");

foreach my $file (@file) {
	say $file;
}


# Values
my $id = 7376;
my $OD_neg_control = -0.000514644;
my $OD_neg_control_SD = 0.002276625;
my $OD_sample = 0.042475897;


# Result
my $ODc = ODc_formula();
my $biofilm_production = biofilm_production();


# Output
say "id\tbiofilm_production\n$id\t$biofilm_production";



                            ##SUBROUTINES##
# ODc formula 
sub ODc_formula {
    my $ODc = $OD_neg_control + (3 * $OD_neg_control_SD);
    return $ODc;
}


# Biofilm production conditions
sub biofilm_production {
    if ($OD_sample <= $ODc){
        return "none";
    }

    if ($ODc < $OD_sample and $OD_sample <= 2*$ODc){
        return "low";
    }

    if (2*$ODc < $OD_sample and $OD_sample <= 4*$ODc){
        return "medium";
    }

    if (4*$ODc < $OD_sample){
        return "high";
    }

    else {
        return "null";
    }
}

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


open (my $fh, "<", $filename) || die "Cannot open $filename";
while (my $line = <$fh>){
	next if !$line; #Ignore empty lines.
	# Result
    my ($isolate_id, $OD_neg_control, $OD_neg_control_SD, $OD_sample) = split/\t/,$line;
	my $biofilm_production = biofilm_production($OD_neg_control, $OD_neg_control_SD, $OD_sample);
# Output
say "id\tbiofilm_production\n$isolate_id\t$biofilm_production";
}



                            ##SUBROUTINES##
# ODc formula 
sub ODc_formula {
    my $ODc = $OD_neg_control + (3 * $OD_neg_control_SD);
    return $ODc;
}


# Biofilm production conditions
sub biofilm_production {
    my ($OD_neg_control, $OD_neg_control_SD, $OD_sample) = @_;
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

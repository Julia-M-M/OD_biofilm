#!/usr/bin/env perl


#Select input file
my ( $dir, $DEBUG, $filename );

GetOptions(
    'd|dir|directory=s'  => \$dir,
    'db|debug'   => \$DEBUG
);
if (!defined $dir){
	$dir = '.';
	
}


# Output a tab-delimited text in format:    ID   biofilm_production
say "ID\tbiofilm_production";



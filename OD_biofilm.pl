#Select input file
my ( $dir, $DEBUG, $filename );
GetOptions(
    'd|dir|directory=s'  => \$dir,
    'db|debug'   => \$DEBUG
);
if (!defined $dir){
	$dir = '.';
	
}


# Output a tab-delimited text in format: locus	allele_id	sequence
say "locus\tallele_id\tsequence\tstatus";
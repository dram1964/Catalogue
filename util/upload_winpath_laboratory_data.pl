#!/usr/bin/perl
use strict;
use warnings;

use Catalogue::Importer::Winpath::Laboratory;
use Text::CSV;

my @rows;
my $line = 1;

my $csv = Text::CSV->new( {binary => 0} ) or die "Cannot use CSV: " . Text::CSV->error_diag();
open my $fh, "<:encoding(utf8)", "/home/dr00/Catalogue/data/winpath/laboratory.csv" or die $!;

while (my $row = $csv->getline( $fh) ) {
  push @rows, $row; 
}

$csv->eof or $csv->error_diag();
close $fh;

print join(":\t", qw/Row Code Discipline Cluster Specialty/), "\n";

my $test_run = 1;
&load_data($test_run);
&load_data();

sub load_data {
	my $data;
	my $limit = $test_run ? 15 : (scalar @rows) - 1;
	for my $row (1..$limit ) {
    		$data = {
			'code' => $rows[$row]->[0],
			'discipline' => $rows[$row]->[1],
			'cluster' => $rows[$row]->[2],
			'specialty' => $rows[$row]->[4],
        	};
		my $import = Catalogue::Importer::Winpath::Laboratory->new($data);
		print join(":\t", "($row of $limit)", $import->code, 
		  $import->discipline, $import->cluster, 
		  $import->specialty), "\n";
		$import->update_or_add unless $test_run;
		$data = ();
	}
	if ($test_run) {
		 print "Adding Records above to the database. Really continue? (y|N)";
		my $response = <STDIN>;
		die "Aborting update at user request" unless $response =~ /^y/i;
	} 
	print "Records Inserted\n" unless $test_run;
	$test_run = 0;
}

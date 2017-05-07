#!/usr/bin/perl
use strict;
use warnings;
use Catalogue::Schema;

my $dsn = "dbi:mysql:catalogue_test";
my $connection = Catalogue::Schema->connect($dsn, 'tutorial', 'thispassword');

use Catalogue::Importer::Winpath::Fact;
use Text::CSV;

my @rows;
my $line = 1;

my $csv = Text::CSV->new( {binary => 1} ) or die "Cannot use CSV: " . Text::CSV->error_diag();
open my $fh, "<:encoding(utf-8)", "/home/dr00/Catalogue/data/winpath/facts.csv" or die $!;

while (my $row = $csv->getline( $fh) ) {
  push @rows, $row; 
}

$csv->eof or $csv->error_diag();
close $fh;

print join(":\t", qw/Row Order Test Lab Cluster BirthYear RequestYear Gender Requests/), "\n";

my $test_run = 1;
&load_data();
&load_data();

sub load_data {
	my $data;
	my $limit = $test_run ? 15 : (scalar @rows) - 1;
	for my $row (1..$limit ) {
    		$data = {
			'order_code' => $rows[$row]->[3],
			'test_code' => $rows[$row]->[2],
			'cluster_name' => $rows[$row]->[6],
			'year_of_birth' => $rows[$row]->[1] || 1800,
			'year_of_result' => $rows[$row]->[7]|| 1800,
			'gender' => $rows[$row]->[0],
			'requests' => $rows[$row]->[8],
        	};
		$data->{laboratory_code} = &lookup_lab_code($rows[$row]->[5]);
		my $import = Catalogue::Importer::Winpath::Fact->new($data);
		print join(":\t", "($row of $limit)", $import->order_code, 
		  $import->test_code, $import->laboratory_code, 
		  $import->cluster_name, $import->year_of_birth, 
		  $import->year_of_result, $import->gender, 
		  $import->requests ), "\n";
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

sub lookup_lab_code() {
    my $lab_name = shift;
    my $lab_code; 
	
    my $fact_rs = $connection->resultset('WpLaboratory')->search({
	discipline => $lab_name});
    return (defined($fact_rs->first)) ? $fact_rs->first->code : 'B';

}

#!/usr/bin/perl
use strict;
use warnings;

use Catalogue::Importer::Winpath::TestCode;
use Text::CSV;

my @rows;
my $line = 1;

my $csv = Text::CSV->new( {binary => 0} ) or die "Cannot use CSV: " . Text::CSV->error_diag();
open my $fh, "<:encoding(utf8)", "/home/dr00/Catalogue/data/winpath/test_code.csv" or die $!;

while (my $row = $csv->getline( $fh) ) {
  next if $row->[0] eq 'testcode';
  next if $row->[0] =~ /---/;
  next if $row->[0] =~ /^\s*$/;
  push @rows, $row; 
}

$csv->eof or $csv->error_diag();
close $fh;

print join(":\t", qw/Row Code Name LabCode Units Function Flags RepSection LineNo/), "\n";

my $test_run = 1;
&load_data($test_run);
&load_data();

sub load_data {
	my $data;
	my $limit = $test_run ? 15 : (scalar @rows) - 1;
	for my $row (1..$limit ) {
    		$data = {
			'code' => $rows[$row]->[0],
			'name' => $rows[$row]->[2],
			'laboratory_code' => $rows[$row]->[1],
			'units' => $rows[$row]->[3],
			'function' => $rows[$row]->[4],
			'flags' => $rows[$row]->[6],
			'report_section' => $rows[$row]->[7],
			'line_number' => $rows[$row]->[8],
        	};
		$data->{code} =~ s/\s*$//g;
		$data->{name} =~ s/\s*$//g;
		$data->{laboratory_code} =~ s/\s*$//g;
		$data->{laboratory_code} =~ s/\d$//g;
		$data->{units} =~ s/\s*$//g;
		$data->{function} =~ s/\s*$//g;
		$data->{flags} =~ s/\s*$//g;
		$data->{report_section} =~ s/\s*$//g;
		$data->{line_number} =~ s/\s*$//g;
		my $import = Catalogue::Importer::Winpath::TestCode->new($data);
		print join(":\t", "($row of $limit)", $import->code, 
		  $import->name, $import->laboratory_code, 
		  $import->units, $import->function, 
		  $import->flags, $import->report_section, 
		  $import->line_number ), "\n";
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

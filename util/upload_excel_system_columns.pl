#!/usr/bin/perl
use strict;
use warnings;

use Catalogue::Systems::Importer;
use Spreadsheet::XLSX;
use Text::Iconv;

my $converter = Text::Iconv->new("utf-8", "windows-1251");

my $excel = Spreadsheet::XLSX->new('/home/dr00/Downloads/UWHSLIVE Metadata Dump.xlsx', $converter);

my $hic = $excel->{Worksheet}->[0];
my $system_name = $hic->{Name};
print "Loading data from $system_name\n";

my ( $row_min, $row_max ) = $hic->row_range();
my ( $col_min, $col_max ) = $hic->col_range();

print join(":", qw/Row System Database Schema Table Column Type Size/), "\n";

my $test_run = 1;
&load_data($test_run);
&load_data();

sub load_data {
	my $data;
	my $rows = $test_run ? 5 : $row_max;
	for my $row (1..$rows ) {
    	my @record;
    	for my $col ( $col_min .. $col_max ) {
			my $cell = $hic->get_cell( $row, $col );
        	next unless $cell;
			push (@record, $cell->value());
    	}
    	$data = {'system_name' => $record[0],
			'database_name' => $record[1],
			'schema_name' => $record[2],
			'table_name' => $record[3],
			'column_name' => $record[4],
			'column_type' => $record[8],
			'column_size' => $record[9],
    	};
		my $import = Catalogue::Systems::Importer->new($data);
		print join(":", "($row of $row_max)", $data->{system_name}, 
		  $data->{database_name}, $data->{schema_name}, 
		  $data->{table_name}, $data->{column_name}, 
		  $data->{column_type}, $data->{column_size}), "\n";
		$import->add_or_update_system unless $test_run;
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

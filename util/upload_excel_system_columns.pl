#!/usr/bin/perl
use strict;
use warnings;

use Catalogue::Systems::Importer;
use Spreadsheet::XLSX;
use Text::Iconv;

my $converter = Text::Iconv->new("utf-8", "windows-1251");

my $excel = Spreadsheet::XLSX->new('/home/dr00/Downloads/USQL2vDWH_Aardvark_live.xlsx', $converter);

my $hic = $excel->{Worksheet}->[0];
my $system_name = $hic->{Name};
print "Loading data from $system_name\n";

my ( $row_min, $row_max ) = $hic->row_range();
my ( $col_min, $col_max ) = $hic->col_range();

my @header;
for my $col ( $col_min .. $col_max ) {
    my $cell = $hic->get_cell( 0, $col );
    next unless $cell;
    push (@header, $cell->value());
}
print join(":", "Row:System Name", @header[0,1,2,3,7,8]), "\n";

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
    	$data = {'system_name' => $system_name,
			'database_name' => $record[0],
			'schema_name' => $record[1],
			'table_name' => $record[2],
			'column_name' => $record[3],
			'column_type' => $record[7],
			'column_size' => $record[8],
    	};
		my $import = Catalogue::Systems::Importer->new($data);
		print join(":", "($row of $row_max)", $system_name, @record[0,1,2,3,7,8]), "\n";
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

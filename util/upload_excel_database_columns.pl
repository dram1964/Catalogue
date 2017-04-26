#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Simple;
use Spreadsheet::XLSX;
use Text::Iconv;

use Catalogue::Systems::Importer;

my($options) = {
	help => {
		type => '',
		env => '-', 
		default => '',
		verbose => '',
		order => 1,
	},
	server => {
		type => '=s',
		env => '-', 
		default => '',
		verbose => 'Specify the server name to be used during upload',
		order => 2,
	},
	worksheet => {
		type => '=i',
		env => '-', 
		default => '',
		verbose => 'Specify the worksheet number starting from 0',
		order => 3,
	},
	data_from => {
		type => '=i',
		env => '-', 
		default => '',
		verbose => 'Specify number of header rows to skip',
		order => 4,
	},
};

my($option) = Getopt::Simple->new();

if (! $option -> getOptions($options, "Usage: perl -Ilib util/upload_excel_database_columns.pl [options]"))
{
	exit(-1); 
}



my $server_name = $$option{'switch'}{'server'};
my $sheet_number = $$option{'switch'}{'worksheet'};
my $first_data_row = $$option{'switch'}{'data_from'};
print "server: $server_name\n";
print "worksheet: $sheet_number\n";
print "skip rows: $first_data_row\n";

my $converter = Text::Iconv->new("utf-8", "windows-1251");
my $excel = Spreadsheet::XLSX->new("/home/dr00/Catalogue/data/$server_name.xlsx", $converter);
my $sheet = $excel->{Worksheet}->[$sheet_number];
my ( $row_min, $row_max ) = $sheet->row_range();
my ( $col_min, $col_max ) = $sheet->col_range();

print join(":\t", qw/Row Server Database Schema Table Column Type Size/), "\n";

my $test_run = 1;
&load_data($test_run);
&load_data();

sub load_data {
	my $data;
	my $rows = $test_run ? 15 : $row_max;
	for my $row ($first_data_row..$rows ) {
    	my @record;
    	for my $col ( $col_min .. $col_max ) {
			my $cell = $sheet->get_cell( $row, $col );
        	next unless $cell;
			push (@record, $cell->value());
    	}
    	$data = {'server_name' => $server_name,
			'database_name' => $record[0],
			'schema_name' => $record[1],
			'table_name' => $record[2],
			'column_name' => $record[3],
			'column_type' => $record[7],
			'column_size' => $record[8],
    	};
		my $import = Catalogue::Systems::Importer->new($data);
		print join(":", "($row of $row_max)", $data->{server_name}, 
		  $data->{database_name}, $data->{schema_name}, 
		  $data->{table_name}, $data->{column_name}, 
		  $data->{column_type}, $data->{column_size}), "\n";
		$import->add_or_update_database unless $test_run;
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

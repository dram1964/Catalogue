#!/usr/bin/perl
use strict;
use warnings;

use Catalogue::Systems::Importer;
use Spreadsheet::XLSX;
use Text::Iconv;

my $converter = Text::Iconv->new("utf-8", "windows-1251");

my $excel = Spreadsheet::XLSX->new('/home/dr00/Catalogue/data/kpe.xlsx', $converter);

my $kpe = $excel->{Worksheet}->[0];

my ( $row_min, $row_max ) = $kpe->row_range();
my ( $col_min, $col_max ) = $kpe->col_range();

print join(":", qw/Row KPE ERID Category2 Supplier Application ApplicationDescription/), "\n";

my $test_run = 1;
&load_data($test_run);
&load_data();

sub load_data {
	my $data;
	my $rows = $test_run ? 5 : $row_max;
	for my $row (1..$rows ) {
		my @record;
	    	for my $col ( $col_min .. $col_max ) {
				my $cell = $kpe->get_cell( $row, $col );
			next unless $cell;
				push (@record, $cell->value());
	    	}
		$data = {'kpe' => $record[0],
				'erid' => $record[1],
				'category2' => $record[2],
				'supplier' => $record[3],
				'application' => $record[4],
				'application_desc' => $record[5],
		};
		my $import = Catalogue::Systems::Importer->new($data);
		print join(":", "($row of $row_max)", $data->{kpe}, 
		  $data->{erid}, $data->{category2}, 
		  $data->{supplier}, $data->{application}, 
		  $data->{application_desc}), "\n";
                if (!$data->{kpe}) {
		    print "skipping row $row: no kpe name\n" unless $data->{kpe};
		    next;
		}
                if (!$data->{erid}) {
		    print "skipping row $row: no erid name\n" unless $data->{erid};
		    next;
		}
                if (!$data->{category2}) {
		    print "skipping row $row: no category2 name\n" unless $data->{category2};
		    next;
		}
                if (!$data->{supplier}) {
		    print "skipping row $row: no supplier name\n" unless $data->{supplier};
		    next;
		}
                if (!$data->{application}) {
		    print "skipping row $row: no application name\n" unless $data->{application};
		    next;
		}
                if (!$data->{application_desc}) {
		    print "skipping row $row: no application_desc\n" unless $data->{application_desc};
		    next;
		}
		$import->add_or_update_kpe unless $test_run;
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

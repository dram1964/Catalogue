package Catalogue::Util;

use strict;
use warnings;

use Catalogue::Schema;

sub new {
	my $self = {};
	bless $self, "Catalogue::Util";
	return $self;
}

my $schema = Catalogue::Schema->connect('dbi:mysql:catalogue', 'tutorial', 'thispassword');

sub walk_catalogue() {
	my ($self) = @_;
	my @systems = $schema->resultset('CatalogueSystem')->all;

	for my $system (@systems) {
	    print $system->name,"\n"; 
		for my $database ($system->system_databases) {
		    print "\t", $database->name, $database->description, "\n";
			for my $schema ($database->database_schemas) {
			    print "\t\t", $schema->name, $schema->description, "\n";
			    for my $table ($schema->schema_tables) {
				print "\t\t\t", $table->name, $table->description, "\n";
				for my $column ($table->table_columns) {
				    print "\t\t\t\t", $column->name, "\n";
				}
			    }
			}
		}
		
	}
}

sub add_catalogue() {
	my ($self) = @_;
	my $systems_rs = $schema->resultset('CatalogueSystem')->find_or_create({name => $self->{data}->{system}});

	my $database_rs = $systems_rs->system_databases->find_or_create(
		{name => $self->{data}->{database}->{name},
		 description => $self->{data}->{database}->{description},
		}
	);
	my $schema_rs = $database_rs->database_schemas->find_or_create(
		{name => $self->{data}->{schema}->{name},
		description => $self->{data}->{schema}->{description},
		}
	);
	my $table_rs = $schema_rs->schema_tables->find_or_create(
		{name => $self->{data}->{table}->{name},
		description => $self->{data}->{table}->{description},
		}
	);
	my $column_rs = $table_rs->table_columns->find_or_create(
		{ name => $self->{data}->{column}->{name},
		col_type => $self->{data}->{column}->{col_type},
		col_size => $self->{data}->{column}->{col_size},
		col_enum => $self->{data}->{column}->{col_enum},
		col_pattern => $self->{data}->{column}->{col_pattern},
		completion_rate => $self->{data}->{column}->{completion_rate},
		}
	);

}

=header2

load_data : requires a hash with the following structure:
	{system => '',
	database => {name => '', description => ''},
	schema => { name => '', description => ''},
	table => { name => '', description => ''},
	column => { name => '', col_type => '',
		col_size => '', col_enum => '',
		col_pattern => '', completion_rate => '',
		first_record_date => '', last_record_date => ''}
	}
=cut

sub load_data() {
	my ($self, $data) = @_;
	$self->{data} = $data;
}


1;

use strict;
use warnings;
use Test::More;
use Catalogue::Schema;
use Data::Dumper;

my $dsn = "dbi:mysql:catalogue_test";
my $schema = Catalogue::Schema->connect($dsn, 'tutorial', 'thispassword');

my $id = 769;

ok(my $column = $schema->resultset('TableColumn')->find($id), "Column Requested");
my $column_name = $column->name; 
my $table_name = $column->table_rel->name;
my $schema_name = $column->table_rel->schema->name;
my $database_name = $column->table_rel->schema->database->name;
my $system_name = $column->table_rel->schema->database->system->name;

my $query_rs = $schema->resultset('TableColumn')->search({'me.id' => $id},
  {
    select => [qw(me.name me.col_type me.col_size 
	table_rel.name db_schema.name sys_database.name system.name)],
    as => [qw(col_name col_type col_size 
	table_name schema_name database_name system_name)],
    join => {'table_rel' => {'db_schema' => {'sys_database' => 'system'}}},
    prefetch => {'table_rel' => {'db_schema' => {'sys_database' => 'system'}}}
  }
);
my $query = $query_rs->first;

is($query->get_column('col_name'), $column_name, "Column Name matched");
is($query->get_column('table_name'),  $table_name, "Table Name matched");
is($query->get_column('schema_name'),  $schema_name, "Schema Name matched");
is($query->get_column('database_name'),  $database_name, "Database Name matched");
is($query->get_column('system_name'), $system_name, "System Name matched");
done_testing();



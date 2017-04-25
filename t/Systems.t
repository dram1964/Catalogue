use Test::More tests => 32;
use Catalogue::Systems;

ok(my $system = Catalogue::Systems->new);
isa_ok($system, 'Catalogue::Systems');

ok(!$system->server_name, "No value set for Server Name");
ok(!$system->database_name, "No value set for Database Name");
ok(!$system->database_description, "No value set for Database Description");
ok(!$system->schema_name, "No value set for Schema Name");
ok(!$system->schema_description, "No value set for Schema Description");
ok(!$system->table_name, "No value set for Table Name");
ok(!$system->table_description, "No value set for Table Description");
ok(!$system->column_name, "No value set for Column Name");
ok(!$system->column_type, "No value set for Column Type");
ok(!$system->column_size, "No value set for Column Size");

my @values = qw/TestServer2 DB2 TestDB Schema2 SchemaDesc Table1 TableDesc
	Col1 varchar 7/;

ok($system->server_name($values[0]), 'server_name Mutator');
ok($system->database_name($values[0]), 'database_name Mutator');
ok($system->database_description($values[0]), 'database_description Mutator');
ok($system->schema_name($values[0]), 'schema_name Mutator');
ok($system->schema_description($values[0]), 'schema_description Mutator');
ok($system->table_name($values[0]), 'table_name Mutator');
ok($system->table_description($values[0]), 'table_description Mutator');
ok($system->column_name($values[0]), 'column_name Mutator');
ok($system->column_type($values[0]), 'column_type Mutator');
ok($system->column_size($values[0]), 'column_size Mutator');

my $system1 = Catalogue::Systems->new({
	server_name => $values[0],
	database_name => $values[1],
	database_description => $values[2],
	schema_name => $values[3],
	schema_description => $values[4],
	table_name => $values[5],
	table_description => $values[6],
	column_name => $values[7],
	column_type => $values[8],
	column_size => $values[9],
	});

cmp_ok($system1->server_name, 'eq', $values[0], 'server_name set at create');
cmp_ok($system1->database_name, 'eq', $values[1], 'database_name set at create');
cmp_ok($system1->database_description, 'eq', $values[2], 'database_description set at create');
cmp_ok($system1->schema_name, 'eq', $values[3], 'schema_name set at create');
cmp_ok($system1->schema_description, 'eq', $values[4], 'schema_description set at create');
cmp_ok($system1->table_name, 'eq', $values[5], 'table_name set at create');
cmp_ok($system1->table_description, 'eq', $values[6], 'table_description set at create');
cmp_ok($system1->column_name, 'eq', $values[7], 'column_name set at create');
cmp_ok($system1->column_type, 'eq', $values[8], 'column_type set at create');
cmp_ok($system1->column_size, 'eq', $values[9], 'column_size set at create');

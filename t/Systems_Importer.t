use Test::More tests => 32;
use Catalogue::Systems::Importer;

ok(my $system = Catalogue::Systems::Importer->new);
isa_ok($system, 'Catalogue::Systems::Importer');

ok(!$system->system_name, "Inherits Catalogue::Systems->system_name");
ok(!$system->database_name, "Inherits Catalogue::System->database_name");

my @values = qw/TestServer DB2 TestDB Schema2 SchemaDesc Table1 TableDesc
	Col1 varchar 7/;

ok($system->system_name($values[0]), 'inherits system_name Mutator');
ok($system->database_name($values[0]), 'inherits database_name Mutator');
ok($system->database_description($values[0]), 'inherits database_description Mutator');
ok($system->schema_name($values[0]), 'inherits schema_name Mutator');
ok($system->schema_description($values[0]), 'inherits schema_description Mutator');
ok($system->table_name($values[0]), 'inherits table_name Mutator');
ok($system->table_description($values[0]), 'inherits table_description Mutator');
ok($system->column_name($values[0]), 'inherits column_name Mutator');
ok($system->column_type($values[0]), 'inherits column_type Mutator');
ok($system->column_size($values[0]), 'inherits column_size Mutator');

my $system1 = Catalogue::Systems::Importer->new(system_name => 'TestServer');
cmp_ok($system1->system_name, 'eq', 'TestServer', "Set System name at create");
ok(!$system1->add_or_update_system, "Can't add System");
cmp_ok($system1->error_msg, 'eq', 'No database name provided', "No DB name Error");

my $system2 = Catalogue::Systems::Importer->new({
	system_name => 'TestServer',
	database_name => 'DBName'});
cmp_ok($system2->database_name, 'eq', 'DBName', "Set DB name at create");
cmp_ok($system2->system_name, 'eq', 'TestServer', "Set System name at create");
ok(!$system2->add_or_update_system, "Can't add System");
cmp_ok($system2->error_msg, 'eq', 'No schema name provided', "No Schema name Error");

my $system3 = Catalogue::Systems::Importer->new(
	system_name => 'TestServer',
	database_name => 'DBName',
	schema_name => 'SchemaName');
cmp_ok($system3->schema_name, 'eq', 'SchemaName', "Set Schema name at create");
ok(!$system3->add_or_update_system, "Can't add System");
cmp_ok($system3->error_msg, 'eq', 'No table name provided', "No Table name Error");

my $system4 = Catalogue::Systems::Importer->new(
	system_name => 'TestServer',
	database_name => 'DBName',
	schema_name => 'SchemaName',
	table_name => 'TableName');
cmp_ok($system4->table_name, 'eq', 'TableName', "Set Table name at create");
ok(!$system4->add_or_update_system, "Can't add System");
cmp_ok($system4->error_msg, 'eq', 'No column name provided', "No Column name Error");

my $system5 = Catalogue::Systems::Importer->new(
	system_name => 'TestServer',
	database_name => 'DBName',
	schema_name => 'SchemaName',
	table_name => 'TableName',
	column_name => 'Column1');
ok($system5->add_or_update_system, "Can add System");
ok(!$system5->error_msg, "No Error Message Set");
ok($system5->delete_all, "Removed all traces of Inserted Record");

my $system6 = Catalogue::Systems::Importer->new(
	system_name => 'TestServer2',
	database_name => 'DBName',
	schema_name => 'SchemaName',
	table_name => 'TableName',
	column_name => 'Column1');
ok($system6->add_or_update_system, "Can update System");
ok(!$system6->error_msg, "No Error Message Set");

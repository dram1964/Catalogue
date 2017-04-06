use strict;
use warnings;
use Test::More;
use Catalogue::Schema;

my $dsn = "dbi:mysql:catalogue_test";
my $schema = Catalogue::Schema->connect($dsn, 'tutorial', 'thispassword');

plan skip_all => 'set MYAPP_DSN to enable this test' 
	unless ($ENV{MYAPP_DSN} eq $dsn);

ok(my $column_rs = $schema->resultset('TableColumn'), "ResultSet Requested");
ok(my $column = $column_rs->single, "Single row requested");
diag("column name: " . $column->name);
diag("table name: " . $column->table_rel->name);
diag("schema name: " . $column->table_rel->schema->name);
diag("database name: " . $column->table_rel->schema->database->name);
diag("system name: " . $column->table_rel->schema->database->system->name);

done_testing();

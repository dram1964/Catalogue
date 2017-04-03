use strict;
use warnings;
use Test::More;

use Catalogue::Model::DB;

my $model = Catalogue::Model::DB->new();

my $sources = $model->schema->source_registrations;
my @tables = qw(User SystemKpe SystemDatabase DatabaseSchema SystemCategory2 Supplier
	Category2 KpeClass DbType SystemSupplier DatasetFact Application UserRole
	Erid CatalogueSystem SystemDbType SchemaTable TableColumn SystemClass
	Dataset SystemErid Todolist);
for my $table (@tables) {
  ok($sources->{$table}, "$table resultsource Defined");
}

for my $source (keys %$sources) {
  ok(grep( $source, @tables), "Expected $source");
}

done_testing();

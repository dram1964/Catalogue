use strict;
use warnings;
use Test::More;

use Catalogue::Model::DB;

my $model = Catalogue::Model::DB->new();

my $sources = $model->schema->source_registrations;
my @tables = qw(
	CAppDb
	CApplication
	CColumn
	CDatabase
	CDbServer
	CSchema
	CServer
	CTable
	DatasetFact
	Dataset
	DbType
	Role
	Todolist
	UserRole
	User
);
my @old_tables = qw(
	SystemKpe 
	SystemDatabase 
	DatabaseSchema 
	SystemCategory2 
	Supplier
	Category2 
	KpeClass 
	SystemSupplier 
	Application 
	Erid 
	CatalogueSystem 
	SystemDbType 
	SchemaTable 
	TableColumn 
	SystemClass
	SystemErid 
);
for my $table (@tables) {
  ok($sources->{$table}, "$table resultsource Defined");
}
for my $table (@old_tables) {
  ok(!$sources->{$table}, "$table resultsource Not Defined");
}

for my $source (keys %$sources) {
  my $result = grep { $source eq $_ } @tables; 
  cmp_ok( $result, '==', 1, "$source expected");
}

done_testing();

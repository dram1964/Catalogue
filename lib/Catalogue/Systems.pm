package Catalogue::Systems;

use Moose;

=head1 NAME

Catalogue::Systems

=head1 Description

Used as Base Class for Catalogue::Systems::* Utility Modules

=head1 Synopsis

use Catalogue::Systems

my $db_record = {
	server_name => 'TestServer',
	database_name => 'DBName',
	database_description => 'DB Description',
	schema_name => 'SchemaName',
	schema_description => 'Schema Description',
	table_name => 'TableName',
	table_description => 'Table Description',
	column_name => 'Column1',
	column_type => 'integer',
	column_size => '11',
}
my $record = Catalogue::Systems::Importer->new($db);


$record->system_name # prints 'TestServer'
$record->system_name('testserver') # set system_name

=cut

has 'server_name' => ( is => 'rw');
has 'database_name' => ( is => 'rw');
has 'database_description' => ( is => 'rw');
has 'schema_name' => ( is => 'rw');
has 'schema_description' => ( is => 'rw');
has 'table_name' => ( is => 'rw');
has 'table_description' => ( is => 'rw');
has 'column_name' => ( is => 'rw');
has 'column_type' => ( is => 'rw');
has 'column_size' => ( is => 'rw');
has 'error_msg' => ( is => 'rw');
has 'kpe' => ( is => 'rw');
has 'erid' => ( is => 'rw'); 
has 'category2' =>  ( is => 'rw');
has 'supplier' =>  ( is => 'rw');
has 'application' => ( is => 'rw');
has 'application_desc' =>  ( is => 'rw');

no Moose;

__PACKAGE__->meta->make_immutable;


1;

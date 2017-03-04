package Catalogue::Systems::Importer;

use parent 'Catalogue::Systems';

=head1 NAME

Catalogue::Systems::Importer - used to import data to Catalogue Database

=head1 SYNOPSIS

use Catalogue::Schema::Importer

my $data = {
	system_name => 'TestServer',
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
my $record = Catalogue::Systems::Importer->new($data);
$record->table_name; # prints 'TableName'
$record->add_or_update_system;
$record->column_name('Column2');
$record->column_type('varchar');
$record->column_size(50);
$record->add_or_update_system;

$record->delete_all; # deletes all records for system_name 

=cut

use Catalogue::Schema;

my $schema = Catalogue::Schema->connect('dbi:mysql:catalogue', 'tutorial', 'thispassword');


=head1 METHODS

=head2 delete_all

Deletes Catalogue System and all child records (Databases, Schemas, Tables and columns associated with the system

=cut

sub delete_all {
    my ($self) = @_;
    my $rs = $schema->resultset('CatalogueSystem')->find({name => $self->system_name});
    if (!$rs) {
		print $self->system_name, " not found: nothing to delete\n";
    } else {
		$rs->delete;
    }
}

=head2 add_or_update_kpe

Checks that the record has all the required elements, and then updates or adds the Catalogue System and child records

=cut

sub add_or_update_kpe () {
    my ($self) = @_;
    my $category2_rs = $schema->resultset('Category2')->find_or_create({name => $self->category2});
    my $category2_id = $category2_rs->id;
    my $erid_rs = $schema->resultset('Erid')->find_or_create({name => $self->erid});
    my $erid = $erid_rs->id;
    my $supplier_rs = $schema->resultset('Supplier')->find_or_create({name => $self->supplier});
    my $supplier_id = $supplier_rs->id;
    my $kpe_rs = $schema->resultset('KpeClass')->find_or_create({name => $self->kpe});
    my $kpe_id = $kpe_rs->id;
    my $application_rs = $schema->resultset('Application')->find_or_create(
	{name => $self->application});
    my $application_id = $application_rs->id;
    $application_rs->update({description => $self->application_desc});
    my $rs = $schema->resultset('CatalogueSystem')->find({name => $self->application});
    if (!$rs) {
	$rs = $schema->resultset('CatalogueSystem')->create({
		name => $self->application,
		cat2_id => $category2_id,
		erid_id => $erid,
		supplier_id => $supplier_id,
		kpe_id => $kpe_id,
		application_id => $applicaiton_id,
	});
    } else {
    $rs->update({
		cat2_id => $category2_id,
		erid_id => $erid,
		supplier_id => $supplier_id,
		kpe_id => $kpe_id,
		application_id => $application_id,
	});
    }
}

=head2 add_or_update_system

Checks that the record has all the required elements, and then updates or adds the Catalogue System and child records

=cut

sub add_or_update_system () {
    my ($self) = @_;
    $self->_check_record;
    return 0 if $self->error_msg;
    my $rs = $schema->resultset('CatalogueSystem')->find({name => $self->system_name});
    if (!$rs) {
	$rs = $schema->resultset('CatalogueSystem')->create({
		name => $self->system_name});
    } 
    my $db_rs = $rs->system_databases->find({name => $self->database_name});
    if (!$db_rs) {
	$db_rs = $rs->system_databases->create({
	    name => $self->database_name,
	    description => $self->database_description});
    } else {
	my $update = $db_rs->update({
		description => $self->database_description});
    }
    my $schema_rs = $db_rs->database_schemas->find({
	name => $self->schema_name});
    if (!$schema_rs) {
	$schema_rs = $db_rs->database_schemas->create({
	    name => $self->schema_name,
	    description => $self->schema_description});
    } else {
	my $update = $schema_rs->update({
	    description => $self->schema_description});
    }
    my $table_rs = $schema_rs->schema_tables->find({
	name => $self->table_name});
    if (!$table_rs) {
	$table_rs = $schema_rs->schema_tables->create({
	    name => $self->table_name,
	    description => $self->table_description});
    } else {
	my $update = $table_rs->update({
	    description => $self->table_name});
    }
    my $column_rs = $table_rs->table_columns->find({
	name => $self->column_name});
    if (!$column_rs) {
	$column_rs = $table_rs->table_columns->create({
	     name => $self->column_name,
	     col_type => $self->column_type,
	     col_size => $self->column_size});
    } else {
	my $update = $column_rs->update({
	     col_type => $self->column_type,
	     col_size => $self->column_size});
    }
}

=head2 _check_record

Checks that the record to be updated has minimal required fields to add a Catalogue System and child records

=cut

sub _check_record {
        my ($self) = @_;
	if (!defined($self->database_name)) {
	    $self->error_msg("No database name provided");
	    return;
	}
	if (!defined($self->schema_name)) {
	    $self->error_msg("No schema name provided");
	    return;
	}
	if (!defined($self->table_name)) {
	    $self->error_msg("No table name provided");
	    return;
	}
	if (!defined($self->column_name)) {
	    $self->error_msg("No column name provided");
	    return;
	}
}

no Moose;

__PACKAGE__->meta->make_immutable;


1;

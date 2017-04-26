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
$record->add_or_update_database;
$record->column_name('Column2');
$record->column_type('varchar');
$record->column_size(50);
$record->add_or_update_application;

$record->delete_db; # deletes all records for system_name 

=cut

use Catalogue::Schema;

my $schema = Catalogue::Schema->connect('dbi:mysql:catalogue_test', 'tutorial', 'thispassword');


=head1 METHODS

=head2 delete_db

Deletes Catalogue Database and all child records (Schemas, Tables and columns associated with the system

=cut

sub delete_db {
    my ($self) = @_;
    my $rs = $schema->resultset('CDatabase')->find({name => $self->database_name});
    if (!$rs) {
		print $self->database_name, " not found: nothing to delete\n";
    } else {
		$rs->delete;
    }
}

=head2 delete_srv

Deletes server record 

=cut

sub delete_srv {
    my ($self) = @_;
    my $rs = $schema->resultset('CServer')->find({name => $self->server_name});
    if (!$rs) {
		print $self->server_name, " not found: nothing to delete\n";
    } else {
		$rs->delete;
    }
}

=head2 add_or_update_application

updates or adds the Application and child records

=cut

sub add_or_update_application () {
    my ($self) = @_;
    my $category2_rs; my $erid_rs; my $supplier_rs; my $kpe_rs;
    my $category2_id; my $erid_id; my $supplier_id; my $kpe_id;
    if ($self->category2) {
	$category2_rs = $schema->resultset('Cat2')->find_or_create({name => $self->category2});
	$category2_id = $category2_rs->id;
    }
    if ($self->erid) {
	$erid_rs = $schema->resultset('Erid')->find_or_create({name => $self->erid});
	$erid_id = $erid_rs->id;
    }
    if ($self->supplier) {
	$supplier_rs = $schema->resultset('Supplier')->find_or_create({name => $self->supplier});
	$supplier_id = $supplier_rs->id;
    }
    if ($self->kpe) {
 	$kpe_rs = $schema->resultset('Kpe')->find_or_create({name => $self->kpe});
	$kpe_id = $kpe_rs->id;
    }
    my $rs = $schema->resultset('CApplication')->find({name => $self->application});
    if (!$rs) {
	$rs = $schema->resultset('CApplication')->create({
		name => $self->application,
		description => $self->application_desc,
		cat2_id => $category2_id,
		erid_id => $erid_id,
		supplier_id => $supplier_id,
		kpe_id => $kpe_id,
	});
    } else {
    $rs->update({
		cat2_id => $category2_id,
		erid_id => $erid_id,
		supplier_id => $supplier_id,
		kpe_id => $kpe_id,
	});
    }
}

=head2 add_or_update_database

Checks that the record has all the required elements, and then updates or adds the database and child/parent records

=cut

sub add_or_update_database () {
    my ($self) = @_;
    $self->_check_db_record;
    return 0 if $self->error_msg;
    my $rs = $schema->resultset('CServer')->find({name => $self->server_name});
    if (!$rs) {
	$rs = $schema->resultset('CServer')->create({
		name => $self->server_name});
    } 
    my $db_rs = $rs->dbs->find({name => $self->database_name});
    if (!$db_rs) {
	$db_rs = $rs->dbs->create({
	    name => $self->database_name,
	    description => $self->database_description});
	my $db_server_rs = $rs->c_db_servers->create({
	    db_id => $db_rs->id,
	    srv_id => $rs->id});
    } else {
	my $update = $db_rs->update({
		description => $self->database_description});
    }
    my $schema_rs = $db_rs->c_schemas->find({
	name => $self->schema_name});
    if (!$schema_rs) {
	$schema_rs = $db_rs->c_schemas->create({
	    name => $self->schema_name,
	    description => $self->schema_description});
    } else {
	my $update = $schema_rs->update({
	    description => $self->schema_description});
    }
    my $table_rs = $schema_rs->c_tables->find({
	name => $self->table_name});
    if (!$table_rs) {
	$table_rs = $schema_rs->c_tables->create({
	    name => $self->table_name,
	    description => $self->table_description});
    } else {
	my $update = $table_rs->update({
	    description => $self->table_name});
    }
    my $column_rs = $table_rs->c_columns->find({
	name => $self->column_name});
    if (!$column_rs) {
	$column_rs = $table_rs->c_columns->create({
	     name => $self->column_name,
	     col_type => $self->column_type,
	     col_size => $self->column_size});
    } else {
	my $update = $column_rs->update({
	     col_type => $self->column_type,
	     col_size => $self->column_size});
    }
}

=head2 _check_db_record

Checks that the record to be updated has minimal required fields to add a Catalogue System and child records

=cut

sub _check_db_record {
        my ($self) = @_;
	if (!defined($self->server_name)) {
	    $self->error_msg("No server name provided");
	    return;
	}
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

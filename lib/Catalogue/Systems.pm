package Catalogue::Systems;

use Moose;

has 'system_name' => ( is => 'rw');
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

no Moose;

__PACKAGE__->meta->make_immutable;


1;

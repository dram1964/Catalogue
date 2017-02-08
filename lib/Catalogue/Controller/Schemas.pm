package Catalogue::Controller::Schemas;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Schemas - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Schemas in Schemas.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('schemas') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::DatabaseSchema'));
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 object

Fetch the specified system object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(2) {
   my ($self, $c, $schema_id, $db_id) = @_;
   $c->stash(object => $c->stash->{resultset}->find(
	{id => $schema_id, 
	database_id => $db_id} 
   ));

   die "Class not found" if !$c->stash->{object};

   $c->log->debug("*** INSIDE OBJECT METHOD for obj schema=$schema_id db=$db_id ***");
}

=head2 list_tables

list tables for specified database

=cut

sub list_tables :Chained('object') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->log->debug("*** INSIDE list_tables method ***");
    my $tables = [$c->stash->{object}->schema_tables->all];
    $c->stash(
	database_schema => $c->stash->{object},
	tables => $tables,
	template => 'tables/list.tt2');
}
=head2 list

Fetch all schema objects and pass to schemas/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    $c->stash(schemas => [$c->model('DB::DatabaseSchema')->all]);
    $c->stash(template => 'schemas/list.tt2');
}



=encoding utf8

=head1 AUTHOR

David Ramlakhan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

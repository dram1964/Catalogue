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

Begin chained dispatch for /shemas and store a DB::DatabasesSchema resultset in the stash

=cut 

sub base :Chained('/') :PathPart('schemas') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::DatabaseSchema'));
}

=head2 object

Chained dispatch for /schemas/id/?/? to store a schema object on the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(2) {
   my ($self, $c, $schema_id, $db_id) = @_;
   $c->stash(object => $c->stash->{resultset}->find(
	{id => $schema_id, 
	database_id => $db_id} 
   ));

   die "Class not found" if !$c->stash->{object};
}

=head2 list

Fetch all schema objects and pass to schemas/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    $c->stash(schemas => [$c->model('DB::DatabaseSchema')->all]);
    $c->stash(template => 'schemas/list.tt2');
}

=head2 list_schemas

Fetch schema objects for a specified database and display in 'schemas/list' template

=cut

sub list_schemas :Path('list') :Args(1) {
    my ($self, $c, $db_id) = @_;
    my $schemas = [$c->model('DB::DatabaseSchema')->search({database_id => $db_id})];
    my $database = $c->model('DB::SystemDatabase')->find({id => $db_id});
    $c->stash(
	database => $database,
	schemas => $schemas,
	template => 'schemas/list.tt2');
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

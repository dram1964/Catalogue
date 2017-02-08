package Catalogue::Controller::Tables;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Tables - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Tables in Tables.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('tables') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::SchemaTable'));
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 object

Fetch the specified system object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $table_id)  = @_;
   $c->stash(object => $c->stash->{resultset}->find(
	{id => $table_id} 
   ));

   die "Class not found" if !$c->stash->{object};

   $c->log->debug("*** INSIDE OBJECT METHOD for obj table=$table_id ***");
}

=head2 list_columns

list columns for specified database

=cut

sub list_columns :Chained('object') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->log->debug("*** INSIDE list_tables method ***");
    my $columns = [$c->stash->{object}->table_columns->all];
    $c->stash(
	table => $c->stash->{object},
	columns => $columns,
	template => 'columns/list.tt2');
}
=head2 list

Fetch all table objects and pass to tables/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    $c->stash(tables => [$c->model('DB::SchemaTable')->all]);
    $c->stash(template => 'tables/list.tt2');
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

package Catalogue::Controller::Databases;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Databases - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Databases in Databases.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('databases') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::SystemDatabase'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified system database object based on the db and system id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(2) {
   my ($self, $c, $db_id, $system_id) = @_;
   $c->stash(object => $c->stash->{resultset}->find(
	{id => $db_id, 
	system_id => $system_id} 
   ));

   die "Class not found" if !$c->stash->{object};
}

=head2 list_databases

Fetch all database objects for a specified system

=cut

sub list_databases :Chained('base') :Pathpart('list_databases') :Args(1) {
    my ($self, $c, $system_id) = @_;
    my $databases = [$c->stash->{resultset}->search({system_id => $system_id})];
    my $system = $c->model('DB::CatalogueSystem')->find($system_id);
    $c->stash(
	system => $system,
	databases => $databases,
	template => 'databases/list.tt2');
}

=head2 list

Fetch all database objects and pass to databases/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    $c->stash(databases => [$c->model('DB::SystemDatabase')->all]);
    $c->stash(template => 'databases/list.tt2');
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

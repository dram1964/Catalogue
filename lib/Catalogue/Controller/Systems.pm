package Catalogue::Controller::Systems;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Systems - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Systems in Systems.');
}

=head2 base

Begin a chained dispatch for /systems to store a DB::Cataloge resultset in the stash

=cut 

sub base :Chained('/') :PathPart('systems') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::CatalogueSystem'));
}

=head2 object

Chained dispatch to /systems/id/? to store a system object in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};
}

=head2 list

Fetch all system objects and pass to systems/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    my $page = $c->request->param('page') || 1;
    my $query = $c->model('DB::CatalogueSystem')->search(
    	{},
    	{
	rows => 30, 
	page => $page});
    my $systems = [$query->all];
    my $pager = $query->pager;
    $c->stash(
	systems => $systems,
	pager => $pager,
	template => 'systems/list.tt2');
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

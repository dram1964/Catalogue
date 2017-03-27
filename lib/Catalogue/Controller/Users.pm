package Catalogue::Controller::Users;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Users in Users.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('users') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::User'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified user object

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};

}

=head2 list 

List all Users 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $users = [$c->stash->{resultset}->all];
    $c->stash(
	users => $users,
	template => 'users/list.tt2');
}


=encoding utf8

=head1 AUTHOR

dr00

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

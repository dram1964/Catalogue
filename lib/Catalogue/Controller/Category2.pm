package Catalogue::Controller::Category2;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Category2 - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Category2 in Category2.');
}

=head2 list 

List all Category2s 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $category2s = [$c->stash->{resultset}->all];
    $c->stash(
	category2s => $category2s,
	template => 'category2s/list.tt2');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('category2') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::Category2'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified category2 object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};

}

=head2 add

Add new Category2

=cut

sub add :Chained('base') :PathPart('add') :Args(0) {
   my ($self, $c) = @_;
   my $name = $c->request->params->{name};
   my $category2 = $c->stash->{resultset}->create({
	name => $name});
   $c->response->redirect($c->uri_for($self->action_for('list'),
	{mid => $c->set_status_msg("Category2 $name added.")}));
}

=head2 delete

Delete the Category2

=cut

sub delete :Chained('object') :PathPart('delete') :Args(0) {
   my ($self, $c) = @_;
   if ($c->check_user_roles('admin')) {
     $c->stash->{object}->delete;
     $c->response->redirect($c->uri_for($self->action_for('list'),
	{mid => $c->set_status_msg("Category2 Deleted.")}));
   } else {
     $c->response->body('Unauthorised');
   }
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

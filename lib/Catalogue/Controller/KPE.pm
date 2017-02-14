package Catalogue::Controller::KPE;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::KPE - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::KPE in KPE.');
}

=head2 list 

List all KPEs 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $kpes = [$c->stash->{resultset}->all];
    $c->stash(
	kpes => $kpes,
	template => 'kpe/list.tt2');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('kpe') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::KpeClass'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified classification object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};

}

=head2 add

Add new KPE

=cut

sub add :Chained('base') :PathPart('add') :Args(0) {
   my ($self, $c) = @_;
   my $description = $c->request->params->{description};
   my $kpe = $c->stash->{resultset}->create({
	description => $description});
   $c->response->redirect($c->uri_for($self->action_for('list'),
	{mid => $c->set_status_msg("KPE $description added.")}));
}

=head2 delete

Delete the classification

=cut

sub delete :Chained('object') :PathPart('delete') :Args(0) {
   my ($self, $c) = @_;
   $c->stash->{object}->delete;
   $c->response->redirect($c->uri_for($self->action_for('list'),
	{mid => $c->set_status_msg("KPE Deleted.")}));
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

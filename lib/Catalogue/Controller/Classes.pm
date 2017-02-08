package Catalogue::Controller::Classes;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Classes - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Classes in Classes.');
}

=head2 list

Fetch all class objects and pass to classes/list.tt2 in stash to be displayed

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(classes => [$c->model('DB::Class')->all]);
    $c->stash(template => 'classes/list.tt2');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('classes') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::Class'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified classification object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};

   $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

=head2 delete

Delete the classification

=cut

sub delete :Chained('object') :PathPart('delete') :Args(0) {
   my ($self, $c) = @_;
   $c->stash->{object}->delete;
   $c->response->redirect($c->uri_for($self->action_for('list'),
	{mid => $c->set_status_msg("Class Deleted.")}));
}

=head2 form_create

Display a form for collecting information on new system classifications

=cut 

sub form_create :Chained('base') :PathPart('form_create') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(template => 'classes/form_create.tt2');
}

=head2 form_create_do

Take information from form and add to the database

=cut

sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;
    my $name = $c->request->params->{name} || 'N/A';
    my $description = $c->request->params->{description} || 'N/A';

    my $classification = $c->model('DB::Class')->create({
	name => $name,
	description => $description,
    });

    $c->response->redirect($c->uri_for($self->action_for('list'),
	{mid => $c->set_status_msg("Class $name: $description Added.")}));
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

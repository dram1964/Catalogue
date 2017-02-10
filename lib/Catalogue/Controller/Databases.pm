package Catalogue::Controller::Databases;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

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

Get a SystemDatabase resultset and load status messages for /databases chain

=cut 

sub base :Chained('/') :PathPart('databases') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::SystemDatabase'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified system database object based on the db and system id and store it in the stash for /datbases/id/?/? chain

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(2) {
   my ($self, $c, $db_id, $system_id) = @_;
   $c->stash(object => $c->stash->{resultset}->find(
	{id => $db_id, 
	system_id => $system_id} 
   ));

   die "Class not found" if !$c->stash->{object};
}

=head2 edit_description

Use HTML::FormFu to update an existing task

=cut

sub edit_description :Chained('object') :PathPart('edit_description') :Args(0) 
	:FormConfig {
    my ($self, $c) = @_;

    my $database = $c->stash->{object};
    unless ($database) {
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_error_msg("Invalid Database -- Cannot edit")}));
	$c->detach;
    }

    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
	$form->model->update($database);
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_status_msg("Description updated")}));
	$c->detach;
    } else {
        my $description = $form->get_element({name => 'description'});
	$description->value($database->description);
    }
    $c->stash(
	database => $database,
	template => 'databases/edit_description.tt2');
}

=head2 list_databases

Fetch all database objects for a specified system from /databases/list_databases/? chain

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

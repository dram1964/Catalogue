package Catalogue::Controller::Systems;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

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
    $c->load_status_msgs;
}

=head2 search

Search for systems

=cut

sub search :Chained('base') :PathPart('search') :Args(0) {
    my ($self, $c) = @_;
    my $search_term = "%" . $c->request->params->{search} . "%";
    $c->log->debug("*** Searching for $search_term ***");
    my $system_rs = $c->stash->{resultset}->search(
		{'me.name' => {like => $search_term}},
    	);
    my $systems = [$system_rs->all];
    $c->stash(
	systems => $systems,
	template => 'systems/list.tt2');
}

=head2 object

Chained dispatch to /systems/id/? to store a system object in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};
}

=head2 edit

Edit the object

=cut

sub edit :Chained('object') :PathPart('edit') :Args(0) 
	:FormConfig('systems/edit.yml') {
    my ($self, $c) = @_;
    $c->detach('/error_noperms') unless 
      $c->stash->{object}->edit_allowed_by($c->user->get_object);
    my $system = $c->stash->{object};
    unless ($system) {
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_error_msg("Invalid system -- Cannot edit")}));
	$c->detach;
    }
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
        $system->update({
		name => $c->request->params->{system_name},
		description => $c->request->params->{system_description},
	}); 
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_status_msg("System updated")}));
	$c->detach;
    } else {
        my $system_name = $form->get_element({name => 'system_name'});
	$system_name->value($system->name);
        my $system_description = $form->get_element({name => 'system_description'}) if $system->description;
	$system_description->value($system->description);
    }
    $c->stash(template => 'systems/edit.tt2');
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

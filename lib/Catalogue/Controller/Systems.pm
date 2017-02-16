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
	:FormConfig('systems/formfu_edit.yml') {
    my ($self, $c) = @_;
    my $system = $c->stash->{object};
    my $application = $system->applications->first;
    my $kpe = $system->kpe;
    my $cat2 = $system->cat2;
    my $erid = $system->erid;
    my $supplier = $system->supplier;
    unless ($system) {
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_error_msg("Invalid system -- Cannot edit")}));
	$c->detach;
    }
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
        my $application_rs = $c->model('DB::Application')->find_or_create({
		name => $c->request->params->{application_name},
		description => $c->request->params->{application_description}
	});
        my $application_id = $application_rs->id;
        $system->update({
		name => $c->request->params->{system_name},
		application_id => $application_id,
		kpe_id => $c->request->params->{kpe_class},
		supplier_id => $c->request->params->{supplier},
		cat2_id => $c->request->params->{category2},
	}); 
	$system->system_applications->find_or_create({
		system_id => $system->id,
		application_id => $application_id,
	});
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_status_msg("System updated")}));
	$c->detach;
    } else {
        my $system_name = $form->get_element({name => 'system_name'});
	$system_name->value($system->name);
        my $application_name = $form->get_element({name => 'application_name'});
	$application_name->value($application->name) if $application;
        my $application_description = $form->get_element({name => 'application_description'});
	$application_description->value($application->description) if $application;
        my @kpe_objs = $c->model('DB::KpeClass')->all();
        my @kpes;
        foreach (sort @kpe_objs) {
	    push(@kpes, [$_->id, $_->name]);
	}
	my $kpe_select = $form->get_element({name => 'kpe_class'});
	$kpe_select->options(\@kpes);
	$kpe_select->value($kpe->id) if $kpe;
        my @cat2_objs = $c->model('DB::Category2')->all();
        my @cat2s;
        foreach (sort @cat2_objs) {
	    push(@cat2s, [$_->id, $_->name]);
	}
	my $cat2_select = $form->get_element({name => 'category2'});
	$cat2_select->options(\@cat2s);
	$cat2_select->value($cat2->id) if $cat2;
        my @supplier_objs = $c->model('DB::Supplier')->all();
        my @suppliers;
        foreach (sort @supplier_objs) {
	    push(@suppliers, [$_->id, $_->name]);
	}
	my $supplier_select = $form->get_element({name => 'supplier'});
	$supplier_select->options(\@suppliers);
	$supplier_select->value($supplier->id) if $supplier;
        my @erid_objs = $c->model('DB::Erid')->all();
        my @erids;
        foreach (sort @erid_objs) {
	    push(@erids, [$_->id, $_->name]);
	}
	my $erid_select = $form->get_element({name => 'erid'});
	$erid_select->options(\@erids);
	$erid_select->value($erid->id) if $erid;
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

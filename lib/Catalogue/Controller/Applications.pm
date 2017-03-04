package Catalogue::Controller::Applications;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

Catalogue::Controller::Applications - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Applications in Applications.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('applications') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::Application'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified application object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};

}

=head2 list 

List all Datasets 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $applications = [$c->stash->{resultset}->all];
    $c->stash(
	applications => $applications,
	template => 'applications/list.tt2');
}

=head2 search

Search for applications

=cut

sub search :Chained('base') :PathPart('search') :Args(0) {
    my ($self, $c) = @_;
    my $search_term = "%" . $c->request->params->{search} . "%";
    my $application_rs = $c->stash->{resultset}->search(
		{'me.name' => {like => $search_term}},
    	);
    my $applications = [$application_rs->all];
    $c->stash(
	applications => $applications,
	template => 'applications/list.tt2');
}

=head2 add

Add new Dataset

=cut

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
   my ($self, $c) = @_;
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
        my $application_name = $c->request->params->{name};
	my $application_description = $c->request->params->{description};
        my $application = $c->model('DB::Application')->new_result({
		name => $application_name,
		description => $application_description,
	});
        $form->model->update($application);
        $c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_status_msg("Dataset Added")}));
        $c->detach;
    }
    $c->stash(template => 'applications/add.tt2');
}

=head2 edit

Edit a application
	my $supplier_select = $form->get_element({name => 'supplier'});
	$supplier_select->options(\@suppliers);
	$supplier_select->value($supplier->id) if $supplier;
        my @erid_objs = $c->model('DB::Erid')->all();
        my @erids;
        foreach (sort @erid_objs) {
	    push(@erids, [$_->id, $_->name]);
	}

=cut


sub edit :Chained('object') :PathPart('edit') :Args(0) :FormConfig() {
    my ($self, $c) = @_;
    $c->detach('/error_noperms') unless 
      $c->stash->{object}->edit_allowed_by($c->user->get_object);

    my $application = $c->stash->{object};
    my $supplier = $application->supplier;
    my $kpe = $application->kpe;
    my $erid = $application->erid;
    my $category2 = $application->cat2;
    unless ($application) {
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_error_msg("Invalid application -- Cannot edit")}));
	$c->detach;
    }
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
	$form->model->update($application);
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_status_msg("Dataset updated")}));
	$c->detach;
    } else {
        my $name = $form->get_element({name => 'application_name'});
	$name->value($application->name);
        my $description = $form->get_element({name => 'application_description'});
	$description->value($application->description);
	$c->stash(application => $application);

        my @kpe_objs = $c->model('DB::KpeClass')->all();
        my @kpes;
        foreach (sort @kpe_objs) {
	    push(@kpes, [$_->id, $_->name]);
	}
	my $kpe_select = $form->get_element({name => 'kpe_class'});
	$kpe_select->options(\@kpes);
	$kpe_select->value($kpe->id) if $kpe;

        my @category2_objs = $c->model('DB::Category2')->all();
        my @category2s;
        foreach (sort @category2_objs) {
	    push(@category2s, [$_->id, $_->name]);
	}
	my $category2_select = $form->get_element({name => 'category2'});
	$category2_select->options(\@category2s);
	$category2_select->value($category2->id) if $category2;

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
    $c->stash(template => 'applications/edit.tt2');
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

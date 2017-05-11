package Catalogue::Controller::DataRequest;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::DataRequest - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::DataRequest in DataRequest.');
}

=head2 request

Displays a form for requesting data

=cut

sub request :Path('request') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
    $c->stash(template => 'datarequest/request.tt2');
}

sub add :Chained('base') :PathPart('add') :Args(0) :FormConfig {
   my ($self, $c) = @_;
    my $form = $c->stash->{form};
    if ($form->submitted_and_valid) {
        my $application_name = $c->request->params->{name};
	my $application_description = $c->request->params->{description};
        my $application = $c->model('DB::CApplication')->new_result({
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



=encoding utf8

=head1 AUTHOR

David Ramlakhan,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

package Catalogue::Controller::DataReview;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::DataReview - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::DataReview in DataReview.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('datareview') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::DataRequest'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified data request object based on the class id and store it in the stash

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};

}

=head2 list 

List all data requests 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $data_requests = [$c->stash->{resultset}->all];
    $c->stash(
	data_requests => $data_requests,
	template => 'datareview/list.tt2');
}

=head2 purpose_verify

verify or add comments to request purpose and request purpose history

=cut 

sub purpose_verify :Chained('object') :PathPart('purpose_verify') :Args(0) {
    my ($self, $c) = @_;
    my $data_request = $c->stash->{object};
    my $parameters = $c->request->body_parameters;

    my $verifier = $c->user->get_object;

    my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
    });
    my $dh = $dh_rs->first;

    my $purpose_verify = {
	request_id => $data_request->id,
	verifier => $verifier->id,
	verification_time => undef,
	area => $dh->area,
	area_comment => $parameters->{area_comment} || undef,
	objective => $dh->objective,
	objective_comment => $parameters->{objective_comment} || undef,
	benefits => $dh->benefits,
	benefits_comment => $parameters->{benefits_comment} || undef,
    };

    my $verification = $c->model('DB::VerifyPurpose')->update_or_create(
	$purpose_verify
    );
    my $verification_history = $c->model('DB::VerifyPurposeHistory')->create(
	$purpose_verify
    );
    $data_request->update({status_id => 4});
    $c->response->redirect($c->uri_for($self->action_for('review'), [$data_request->id]));
    $c->detach;
}

=head2 handling_verify

verify handling for submitted request

Need to add the handling values to the data_handling and data_handling_history tables

=cut 

sub handling_verify :Chained('object') :PathPart('handling_verify') :Args(0) {
    my ($self, $c) = @_;
    my $data_request = $c->stash->{object};
    my $parameters = $c->request->body_parameters;
 
    my $verifier = $c->user->get_object;
    my $handling_verify = {
	request_id => $data_request->id,
	verifier => $verifier->id,
	verification_time => undef,
	rec_comment => $parameters->{rec_comment},
	population_comment => $parameters->{population_comment},
	id_comment => $parameters->{id_comment},
	storing_comment => $parameters->{storing_comment},
	completion_comment => $parameters->{completion_comment},
	publish_comment => $parameters->{publish_comment},
	additional_comment => $parameters->{additional_comment},

    };

    my $verification = $c->model('DB::VerifyHandling')->update_or_create(
	$handling_verify
    );
    my $verification_history = $c->model('DB::VerifyHandlingHistory')->create(
	$handling_verify
    );
    $data_request->update({status_id => 4});
    $c->response->redirect($c->uri_for($self->action_for('review'), [$data_request->id]));
    $c->detach;

}

=head2 review

review selected data request

=cut

sub review :Chained('object') :PathPart('review') :Args(0) {
    my ($self, $c) = @_;
    $c->detach('/error_noperms') unless 
       $c->stash->{object}->edit_allowed_by($c->user->get_object);

    my $data_request = $c->stash->{object};
    unless ($data_request) {
	$c->response->redirect($c->uri_for($self->action_for('list'),
	    {mid => $c->set_error_msg("Invalid Request -- Cannot edit")}));
	$c->detach;
    }
    my $data_items = {};

    my $data_request_details_rs  = $c->model('DB::DataRequestDetail')->search({
	data_request_id => $data_request->id});
    while (my $row = $data_request_details_rs->next) {
        my $friendly_key = $row->data_category->category;
        $friendly_key =~ s/^([a-z])/\u$1/;
        $data_items->{$friendly_key} = $row->detail;

    }

    my $requestor_rs = $c->model('DB::RegistrationRequest')->search({
	email_address => $data_request->user->email_address
    });
    my $requestor = $requestor_rs->first;

    my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
    });
    my $dh = $dh_rs->first;

    my $verify_purpose = $c->model('DB::VerifyPurpose')->find({
	request_id => $data_request->id
    });
    if (defined($verify_purpose)) {
	    $c->stash->{verify}->{area_comment} = $verify_purpose->area_comment;
	    $c->stash->{verify}->{objective_comment} = $verify_purpose->objective_comment;
	    $c->stash->{verify}->{benefits_comment} = $verify_purpose->benefits_comment;
    }
    $c->log->debug("*** Area Comment: " . $c->stash->{verify}->{area_comment} . " ****");
    my $verify_handling = $c->model('DB::VerifyHandling')->find({
	request_id => $data_request->id
    });
    if (defined($verify_handling)) {
	    $c->stash->{verify}->{rec_comment} = $verify_handling->rec_comment;
	    $c->stash->{verify}->{population_comment} = $verify_handling->population_comment;
	    $c->stash->{verify}->{id_comment} = $verify_handling->id_comment;
	    $c->stash->{verify}->{storing_comment} = $verify_handling->storing_comment;
	    $c->stash->{verify}->{completion_comment} = $verify_handling->completion_comment;
	    $c->stash->{verify}->{publish_comment} = $verify_handling->publish_comment;
	    $c->stash->{verify}->{additional_comment} = $verify_handling->additional_comment;
    }
    $c->log->debug("*** REC Comment: " . $c->stash->{verify}->{rec_comment} . " ****");


    $c->stash(
        dh => $dh,
	requestor => $requestor,
	data_items => $data_items,
	request => $data_request,
	template => 'datareview/review.tt2');
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

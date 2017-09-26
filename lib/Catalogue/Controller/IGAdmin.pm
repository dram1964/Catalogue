package Catalogue::Controller::IGAdmin;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::IGAdmin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::IGAdmin in IGAdmin.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('igadmin') :CaptureArgs(0) {
    my ($self, $c) = @_;
    my $approval_rs = $c->model('DB::DataRequest')->search(
	{status_id => 6});
    $c->stash(resultset => $approval_rs);
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
	template => 'igadmin/list.tt2');
}

=head2 request

Fetch the full request object based on the class id

=cut 

sub request :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));

   die "Class not found" if !$c->stash->{object};
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

    my $verify_data = $c->model('DB::VerifyData')->find({
	request_id => $data_request->id
    });
    if (defined($verify_data)) {
	    $c->stash->{verify}->{cardiology_comment} = $verify_data->cardiology_comment;
	    $c->stash->{verify}->{diagnosis_comment} = $verify_data->diagnosis_comment;
	    $c->stash->{verify}->{episode_comment} = $verify_data->episode_comment;
	    $c->stash->{verify}->{other_comment} = $verify_data->other_comment;
	    $c->stash->{verify}->{pathology_comment} = $verify_data->pathology_comment;
	    $c->stash->{verify}->{pharmacy_comment} = $verify_data->pharmacy_comment;
	    $c->stash->{verify}->{radiology_comment} = $verify_data->radiology_comment;
	    $c->stash->{verify}->{theatre_comment} = $verify_data->theatre_comment;
    }


    $c->stash(
        dh => $dh,
	requestor => $requestor,
	data_items => $data_items,
	request => $data_request,
    );
}

=head2 review

review selected data request

=cut

sub review :Chained('request') :PathPart('review') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(
	template => 'igadmin/review.tt2'
    );
}

=head2 display

displays selected data request

=cut 

sub display :Chained('request') :PathPart('display') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(
	template => 'igadmin/display.tt2'
    );
}



=encoding utf8

=head1 AUTHOR

Ubuntu

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

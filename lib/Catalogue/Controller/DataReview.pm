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

=head2 requestor_approve

approve requestor details for submitted request

=cut 

sub requestor_approve :Chained('object') :PathPart('requestor_approve') :Args(0) {
    my ($self, $c) = @_;
    my $data_request = $c->stash->{object};
   my $parameters = $c->request->body_parameters;
    my $requestor_approval = {
	notes => $parameters->{requestorNotes},
    	validated => $parameters->{requestorValid},
    	verification_method => $parameters->{verificationMethod},
	request_id => $data_request->id,
    };
    $c->log->debug("***Request ID: " . $requestor_approval->{request_id} .  " ***");
    $c->log->debug("***Validated " . $requestor_approval->{validated} . " ***");
    $c->log->debug("***Verification Method " . $requestor_approval->{verification_method} . " ***");
    $c->log->debug("***Verification Notes " . $requestor_approval->{notes} . " ***");

    my $approval = $c->model('DB::ApprovalRequestor')->update_or_create(
	$requestor_approval);
    my $approval_history = $c->model('DB::ApprovalRequestorHistory')->create(
	$requestor_approval);

    my $data_items = {};
    my @columns = $data_request->columns;
    for my $key (@columns) {
      if ($key =~ /_details/) {
	if ($data_request->$key) {
	  my $friendly_key = $key;
	  $friendly_key =~ s/^([a-z])/\u$1/;
	  $friendly_key =~ s/_details//;
	  $data_items->{$friendly_key} = $data_request->$key;
	}
      }
    }

   my $requestor_rs = $c->model('DB::RegistrationRequest')->search({
	email_address => $data_request->user->email_address
   });
   my $requestor = $requestor_rs->first;

   my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
   });
   my $dh = $dh_rs->first;

   $c->stash(
        dh => $dh,
	requestor => $requestor,
	data_items => $data_items,
	request => $data_request,
	template => 'datareview/review.tt2');

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
    my @columns = $data_request->columns;
    for my $key (@columns) {
      if ($key =~ /_details/) {
	if ($data_request->$key) {
	  my $friendly_key = $key;
	  $friendly_key =~ s/^([a-z])/\u$1/;
	  $friendly_key =~ s/_details//;
	  $data_items->{$friendly_key} = $data_request->$key;
	}
      }
    }

   my $requestor_rs = $c->model('DB::RegistrationRequest')->search({
	email_address => $data_request->user->email_address
   });
   my $requestor = $requestor_rs->first;

   my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
   });
   my $dh = $dh_rs->first;

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

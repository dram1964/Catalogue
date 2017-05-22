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

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('datarequest') :CaptureArgs(0) {
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

List all data requests for current user 

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $user = $c->user->get_object;
    $c->detach('/login') unless defined($user);
    my $data_requests = [$c->stash->{resultset}->search({user_id => $user->id})];
    $c->stash(
	data_requests => $data_requests,
	template => 'datarequest/list.tt2');
}

=head2 review

review selected data request

=cut

sub review :Chained('object') :PathPart('review') :Args(0) {
    my ($self, $c) = @_;
    my $data_request = $c->stash->{object};
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

   $c->stash(
	requestor => $requestor,
	data_items => $data_items,
	request => $data_request,
	template => 'datarequest/review.tt2');
}

=head2 request

Displays a form for requesting data

=cut

sub request :Path('request') :Args(0) {
    my ( $self, $c ) = @_;
    my $user = $c->user->get_object;
    $c->stash->{requestor} = {
	firstName => $user->first_name,
	lastName => $user->last_name,
    };
    $c->detach('/error_noperms') unless 
      $c->model('DB::DataRequest')->new({})->request_allowed_by($user);
    my $request_types = [$c->model('DB::RequestType')->all];
    $c->stash(
      request_types => $request_types,
      template => 'datarequest/request.tt2');
}

=head2 ng_request_submitted

Submits data request to database

=cut

sub ng_request_submitted :Path('ng_request_submitted') :Args() {
   my ( $self, $c ) = @_;

   my $requestor = $c->user->get_object;
   my $parameters = $c->request->body_parameters;
   my $data_request = $c->model('DB::DataRequest')->create({
	user_id => $requestor->id,
	cardiology_details => $parameters->{cardiologyDetails},
	chemotherapy_details => $parameters->{chemotherapyDetails},
	diagnosis_details => $parameters->{diagnosisDetails},
	episode_details => $parameters->{episodeDetails},
	other_details => $parameters->{otherDetails},
	pathology_details => $parameters->{pathologyDetails} ,
	pharmacy_details => $parameters->{pharmacyDetails},
	radiology_details => $parameters->{radiologyDetails},
	theatre_details => $parameters->{theatreDetails},
	request_type_id => $parameters->{requestType},
	status_id => $parameters->{Submit},
	
   });

   my $data_requests = [$c->model('DB::DataRequest')->search({user_id => $requestor->id})];

   $c->stash(
     data_requests => $data_requests,
     parameters => $parameters,
     template => 'datarequest/list.tt2');
}

=head2 update_request

submit request update

=cut


sub update_request :Chained('object') :Args() {
    my ($self, $c) = @_;
   my $requestor = $c->user->get_object;
   my $parameters = $c->request->body_parameters;
   my $data_request = $c->stash->{object};
   my $data = {
	user_id => $requestor->id,
	cardiology_details => $parameters->{cardiologyDetails},
	chemotherapy_details => $parameters->{chemotherapyDetails},
	diagnosis_details => $parameters->{diagnosisDetails},
	episode_details => $parameters->{episodeDetails},
	other_details => $parameters->{otherDetails},
	pathology_details => $parameters->{pathologyDetails},
	pharmacy_details => $parameters->{pharmacyDetails},
	radiology_details => $parameters->{radiologyDetails},
	theatre_details => $parameters->{theatreDetails},
	request_type_id => $parameters->{requestType},
	status_id => $parameters->{Submit},
	
   };
   $data->{cardiology_details} = '' unless defined($parameters->{cardiology});
   $data->{chemotherapy_details} = '' unless defined($parameters->{chemotherapy});
   $data->{diagnosis_details} = '' unless defined($parameters->{diagnosis});
   $data->{episode_details} = '' unless defined($parameters->{episode});
   $data->{other_details} = '' unless defined($parameters->{other});
   $data->{pathology_details} = '' unless defined($parameters->{pathology});
   $data->{pharmacy_details} = '' unless defined($parameters->{pharmacy});
   $data->{radiology_details} = '' unless defined($parameters->{radiology});
   $data->{theatre_details} = '' unless defined($parameters->{theatre});
   $data_request->update($data);

   my $data_requests = [$c->model('DB::DataRequest')->search({user_id => $requestor->id})];

   $c->stash(
     status_msg => "Request " . $data_request->id . " updated",
     data_requests => $data_requests,
     parameters => $parameters,
     template => 'datarequest/list.tt2');
}


=head2 request_edit

Edit an open request

=cut

sub request_edit :Chained('object') :Args() {
    my ($self, $c) = @_;
    my $data_request = $c->stash->{object};
    my $user = $data_request->user;
    my $request = { 
	id => $data_request->id,
	user => {firstName => $user->first_name,
	    lastName => $user->last_name
	},
	data => { pathologyDetails => $data_request->pathology_details,
	    diagnosisDetails => $data_request->diagnosis_details,
	    radiologyDetails => $data_request->radiology_details,
	    pharmacyDetails => $data_request->pharmacy_details,
	    episodeDetails => $data_request->episode_details,
	    theatreDetails => $data_request->theatre_details,
	    cardiologyDetails => $data_request->cardiology_details,
	    chemotherapyDetails => $data_request->chemotherapy_details,
	    otherDetails => $data_request->other_details,
	    requestType => $data_request->request_type_id,
	},
    };
    my $request_types = [$c->model('DB::RequestType')->all];

    $c->stash(
      request_types => $request_types,
      request => $request,
      template => 'datarequest/request.tt2');
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

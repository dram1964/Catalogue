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
   my $user = $c->user->get_object;
   $c->stash(object => $c->stash->{resultset}->find($id));
   $c->detach('/error_noperms') unless 
      $c->stash->{object}->user_id eq $user->id;

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

allow current user to view data request submitted by self

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

   my $requestor_rs = $c->model('DB::User')->search({
	username => $data_request->user->username
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
	template => 'datarequest/review.tt2');
}

=head2 request

Displays a form for requesting data

=cut

sub request :Path('request') :Args(0) {
    my ( $self, $c ) = @_;
    $c->detach('/error_noperms') unless 
      $c->model('DB::DataRequest')->new({})->request_allowed_by($c->user->get_object);
    my $user = $c->user->get_object;
    my $requestor = $c->model('DB::User')->find({
	id => $user->id,
    });

    my $request_types = [$c->model('DB::RequestType')->all];
    $c->stash(
      requestor => $requestor,
      request_types => $request_types,
      template => 'datarequest/request.tt2');
}

=head2 ng_request_submitted

Submits data request to database

=cut

=head2 _identifiers

Method to retrieve unique elements of identifiers array parameter to string value

=cut


sub _identifiers () {
   my $self = shift;
   if (ref $self->{identifiers} eq "ARRAY") {
       my %hash = map { $_, 1 } @{$self->{identifiers}};
       $self->{identifiers} = join(", ", keys(%hash));
   }
   return $self->{identifiers};
}

sub ng_request_submitted :Path('ng_request_submitted') :Args() {
   my ( $self, $c ) = @_;

   my $requestor = $c->user->get_object;
   my $parameters = $c->request->body_parameters;
   $self->{identifiers} = $parameters->{identifiers};
   my $dr = {
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
   };
   my $data_request = $c->model('DB::DataRequest')->create(
	$dr
   );

   my $request_type = $data_request->request_type_id;
   my $dh = {
	  request_id => $data_request->id,
	  identifiers => $self->_identifiers,
	  service_area => $parameters->{serviceArea},
	  research_area => $parameters->{researchArea},
          rec_approval => $parameters->{recApproval},
	  consent => $parameters->{consent},
	  identifiable => $parameters->{"identifiable" . $request_type},
	  additional_identifiers => $parameters->{"identifiableSpecification" . $request_type},
	  publish => $parameters->{"publish" . $request_type},
	  publish_to => $parameters->{"publishIdSpecification" . $request_type},
	  storing => $parameters->{"storing" . $request_type},
	  completion => $parameters->{"completion" . $request_type},
	  additional_info => $parameters->{"additional" . $request_type},
          objective => $parameters->{"objective" . $request_type},
	  population => $parameters->{"population" . $request_type},
   };

   my $data_handling = $c->model('DB::DataHandling')->create($dh);

   my $request_history = $c->model('DB::RequestHistory')->create({
	  request_id => $data_request->id,
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
        status_date => $data_request->status_date,
	  identifiers => $self->_identifiers,
	  service_area => $parameters->{serviceArea},
	  research_area => $parameters->{researchArea},
          rec_approval => $parameters->{recApproval},
	  consent => $parameters->{consent},
	  identifiable => $parameters->{"identifiable" . $request_type},
	  additional_identifiers => $parameters->{"identifiableSpecification" . $request_type},
	  publish => $parameters->{"publish" . $request_type},
	  publish_to => $parameters->{"publishIdSpecification" . $request_type},
	  storing => $parameters->{"storing" . $request_type},
	  completion => $parameters->{"completion" . $request_type},
	  additional_info => $parameters->{"additional" . $request_type},
          objective => $parameters->{"objective" . $request_type},
	  population => $parameters->{"population" . $request_type},
   });
	

   my $data_requests = [$c->model('DB::DataRequest')->search({user_id => $requestor->id})];

   if ($parameters->{Submit} == 2) {
	$c->response->redirect($c->uri_for($self->action_for('request_edit'), [$data_request->id]));
   } else {
   	$c->stash(
     		data_requests => $data_requests,
     		parameters => $parameters,
     		template => 'datarequest/list.tt2');
   }
}

=head2 update_request

submit request update

=cut


sub update_request :Chained('object') :Args() {
    my ($self, $c) = @_;
   my $requestor = $c->user->get_object;
   my $parameters = $c->request->body_parameters;
   $self->{identifiers} = $parameters->{identifiers};
   my $data_request = $c->stash->{object};
   my $dr = {
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
        status_date => undef,
	
   };
   $data_request->update($dr);

   my $request_type = $data_request->request_type_id;
   my $dh = {
     request_id => $data_request->id,
     service_area => $parameters->{serviceArea},
     research_area => $parameters->{researchArea},
     rec_approval => $parameters->{recApproval},
     consent => $parameters->{consent},
     identifiable => $parameters->{"identifiable" . $request_type},
     publish => $parameters->{"publish" . $request_type},
     storing => $parameters->{"storing" . $request_type},
     completion => $parameters->{"completion" . $request_type},
     additional_info => $parameters->{"additional" . $request_type},
     objective => $parameters->{"objective" . $request_type},
     population => $parameters->{"population" . $request_type},
   };

   if ($dh->{identifiable} eq "1") {
     $dh->{identifiers} = $self->_identifiers;
     $dh->{additional_identifiers} = $parameters->{"identifiableSpecification" . $request_type};
   } else {
     $dh->{identifiers} = '';
     $dh->{additional_identifiers} = '';
   } 
   if ($dh->{publish} eq "1") {
     $dh->{publish_to} = $parameters->{"publishIdSpecification" . $request_type};
   } else {
     $dh->{publish_to} = '';
   }

   my $data_handling_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
   });
   my $data_handling = $data_handling_rs->first;
   if (defined $data_handling) {
       # update values
       $data_handling->update($dh);
   } else {
       # insert values
       $data_handling = $c->model->('DB::DataHandling')->create($dh);
   }
   my $request_history = $c->model('DB::RequestHistory')->create({
	request_id => $data_request->id,
	user_id => $requestor->id,
	cardiology_details => $dr->{cardiology_details},
	chemotherapy_details => $dr->{chemotherapy_details},
	diagnosis_details => $dr->{diagnosis_details},
	episode_details => $dr->{episode_details},
	other_details => $dr->{other_details},
	pathology_details => $dr->{pathology_details} ,
	pharmacy_details => $dr->{pharmacy_details},
	radiology_details => $dr->{radiology_details},
	theatre_details => $dr->{theatre_details},
	request_type_id => $dr->{request_type_id},
	status_id => $dr->{status_id},
        status_date => undef,
	  identifiers => $dh->{identifiers},
	  service_area => $dh->{service_area},
	  research_area => $dh->{research_area},
          rec_approval => $dh->{rec_approval},
	  consent => $dh->{consent},
	  identifiable => $dh->{identifiable},
	  additional_identifiers => $dh->{additional_identifiers},
	  publish => $dh->{publish},
	  publish_to => $dh->{publish_to},
	  storing => $dh->{storing},
	  completion => $dh->{completion},
	  additional_info => $dh->{additional_info},
          objective => $dh->{objective},
	  population => $dh->{population},
   });
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

    my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
    }); 
    my $dh = $dh_rs->first;

    my $request_type = $data_request->request_type_id;
    if (defined $dh) {
	$request->{data}->{"identifiable" . $request_type} = $dh->identifiable;
	if ($dh->identifiers =~ /, /) {
	my @ids = split /, /, $dh->identifiers;
	for my $id (@ids) {
	  $request->{data}->{identifiers}->{$id} = 1;
	}
	} elsif ( $dh->identifiers =~ /(\w+)/g) {
	  $request->{data}->{identifiers}->{$1} = 1;
	}
	$request->{data}->{"identifiableSpecification" . $request_type} = $dh->additional_identifiers;
	$request->{data}->{"publish" . $request_type} = $dh->publish;
	$request->{data}->{"publishIdSpecification" . $request_type} = $dh->publish_to;
	$request->{data}->{"storing" . $request_type} = $dh->storing;
	$request->{data}->{"completion" . $request_type} = $dh->completion;
	$request->{data}->{"additional" . $request_type} = $dh->additional_info;
	$request->{data}->{"objective" . $request_type} = $dh->objective;
	$request->{data}->{"population" . $request_type} = $dh->population;
	  $request->{data}->{serviceArea} = $dh->service_area;
	  $request->{data}->{researchArea} = $dh->research_area;
	  $request->{data}->{recApproval} = $dh->rec_approval;
	  $request->{data}->{consent} = $dh->consent;
    }

    $c->stash(
      requestor => $user,
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

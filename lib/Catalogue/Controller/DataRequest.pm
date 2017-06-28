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

   if ($data_request->request_type_id == 2) {
        my $identifiers;
	if (ref $parameters->{identifiers} eq "ARRAY") {
	  $identifiers = join(", ", @{$parameters->{identifiers}});
	} else {
	  $identifiers = $parameters->{identifiers};
	}
	my $data_handling = $c->model('DB::DataHandling')->create({
	  request_id => $data_request->id,
	  identifiable => $parameters->{identifiable},
	  identifiers => $identifiers,
	  additional_identifiers => $parameters->{identifiableSpecification},
	  publish => $parameters->{publish},
	  publish_to => $parameters->{publishIdSpecification},
	  storing => $parameters->{storing},
	  completion => $parameters->{completion},
	  additional_info => $parameters->{additional},
          objective => $parameters->{objective},
	  service_area => $parameters->{serviceArea},
	  population => $parameters->{population},
        });
   } elsif ($data_request->request_type_id == 1) {
        my $identifiers;
	if (ref $parameters->{identifiers} eq "ARRAY") {
	  $identifiers = join(", ", @{$parameters->{identifiers}});
	} else {
	  $identifiers = $parameters->{identifiers};
	}
       my $data_handling = $c->model('DB::DataHandling')->create({
	  request_id => $data_request->id,
	  identifiable => $parameters->{identifiable1},
	  identifiers => $identifiers,
	  additional_identifiers => $parameters->{identifiableSpecification1},
          rec_approval => $parameters->{recApproval},
	  consent => $parameters->{consent},
	  publish => $parameters->{publish1},
	  publish_to => $parameters->{publishIdSpecification1},
	  storing => $parameters->{storing1},
	  completion => $parameters->{completion1},
	  additional_info => $parameters->{additional1},
          objective => $parameters->{objective1},
	  research_area => $parameters->{researchArea},
	  population => $parameters->{population1},
       });
   }

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

   my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
   });
   my $dh = $dh_rs->first;

   if (defined $dh) {
       if ($data_request->request_type_id == 2) {
           my $identifiers;
	   if (ref $parameters->{identifiers} eq "ARRAY") {
	     $identifiers = join(", ", @{$parameters->{identifiers}});
	   } else {
	     $identifiers = $parameters->{identifiers};
	   }
           $dh->update({
	      identifiers => $identifiers,
              identifiable => $parameters->{identifiable},
	      additional_identifiers => $parameters->{identifiableSpecification},
	      publish => $parameters->{publish},
	      publish_to => $parameters->{publishIdSpecification},
	      storing => $parameters->{storing},
	      completion => $parameters->{completion},
	      additional_info => $parameters->{additional},
          objective => $parameters->{objective},
	  service_area => $parameters->{serviceArea},
	  population => $parameters->{population},
	   });
       } elsif ($data_request->request_type_id == 1) {
           my $identifiers;
	   if (ref $parameters->{identifiers} eq "ARRAY") {
	     $identifiers = join(", ", @{$parameters->{identifiers}});
	   } else {
	     $identifiers = $parameters->{identifiers};
	   }
           $dh->update({
	      identifiers => $identifiers,
              identifiable => $parameters->{identifiable1},
	      additional_identifiers => $parameters->{identifiableSpecification1},
	      publish => $parameters->{publish1},
	      publish_to => $parameters->{publishIdSpecification1},
	      storing => $parameters->{storing1},
	      completion => $parameters->{completion1},
	      additional_info => $parameters->{additional1},
          objective => $parameters->{objective1},
	  research_area => $parameters->{researchArea},
	  population => $parameters->{population1},
	  consent => $parameters->{consent},
	  rec_approval => $parameters->{recApproval},
	   });
       }
   } else {
       if ($data_request->request_type_id == 2) {
           my $identifiers;
	   if (ref $parameters->{identifiers} eq "ARRAY") {
	     $identifiers = join(", ", @{$parameters->{identifiers}});
	   } else {
	     $identifiers = $parameters->{identifiers};
	   }
	   my $data_handling = $c->model('DB::DataHandling')->create({
	     request_id => $data_request->id,
          rec_approval => $parameters->{recApproval},
	  consent => $parameters->{consent},
	     identifiable => $parameters->{identifiable},
	     identifiers => $identifiers,
	     additional_identifiers => $parameters->{identifiableSpecification},
	     publish => $parameters->{publish},
	     publish_to => $parameters->{publishIdSpecification},
	     storing => $parameters->{storing},
	     completion => $parameters->{completion},
	     additional_info => $parameters->{additional},
          objective => $parameters->{objective},
	  service_area => $parameters->{serviceArea},
	  population => $parameters->{population},
           });
      } elsif ($data_request->request_type_id == 1) {
           my $identifiers;
	   if (ref $parameters->{identifiers} eq "ARRAY") {
	     $identifiers = join(", ", @{$parameters->{identifiers}});
	   } else {
	     $identifiers = $parameters->{identifiers};
	   }
	   my $data_handling = $c->model('DB::DataHandling')->create({
	     request_id => $data_request->id,
          rec_approval => $parameters->{recApproval},
	  consent => $parameters->{consent},
	     identifiable => $parameters->{identifiable1},
	     identifiers => $identifiers,
	     additional_identifiers => $parameters->{identifiableSpecification1},
	     publish => $parameters->{publish1},
	     publish_to => $parameters->{publishIdSpecification1},
	     storing => $parameters->{storing1},
	     completion => $parameters->{completion1},
	     additional_info => $parameters->{additional1},
          objective => $parameters->{objective1},
	  research_area => $parameters->{researchArea},
	  population => $parameters->{population1},
           });
      } 
   }

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

    if (defined $dh) {
        if ($data_request->request_type_id == 2) {

		$request->{data}->{identifiable} = $dh->identifiable;
		if ($dh->identifiers =~ /, /) {
		my @ids = split /, /, $dh->identifiers;
		for my $id (@ids) {
		  $request->{data}->{identifiers}->{$id} = 1;
		}
		} elsif ( $dh->identifiers =~ /(\w+)/g) {
		  $request->{data}->{identifiers}->{$1} = 1;
		}
		$c->log->debug("*** " . $dh->identifiers . " ***");
		$request->{data}->{identifiableSpecification} = $dh->additional_identifiers;
		$request->{data}->{publish} = $dh->publish;
		$request->{data}->{publishIdSpecification} = $dh->publish_to;
		$request->{data}->{storing} = $dh->storing;
		$request->{data}->{completion} = $dh->completion;
		$request->{data}->{additional} = $dh->additional_info;
		$request->{data}->{objective} = $dh->objective;
		$request->{data}->{serviceArea} = $dh->service_area;
		$request->{data}->{population} = $dh->population;
        } elsif ($data_request->request_type_id == 1) {
		$request->{data}->{identifiable1} = $dh->identifiable;
		if ($dh->identifiers =~ /, /) {
		my @ids = split /, /, $dh->identifiers;
		for my $id (@ids) {
		  $request->{data}->{identifiers}->{$id} = 1;
		}
		} elsif ( $dh->identifiers =~ /(\w+)/g) {
		  $request->{data}->{identifiers}->{$1} = 1;
		}
		$c->log->debug("*** " . $dh->identifiers . " ***");
		$request->{data}->{identifiableSpecification1} = $dh->additional_identifiers;
		$request->{data}->{publish1} = $dh->publish;
		$request->{data}->{publishIdSpecification1} = $dh->publish_to;
		$request->{data}->{storing1} = $dh->storing;
		$request->{data}->{completion1} = $dh->completion;
		$request->{data}->{additional1} = $dh->additional_info;
		  $request->{data}->{objective1} = $dh->objective;
		  $request->{data}->{researchArea} = $dh->research_area;
		  $request->{data}->{population1} = $dh->population;
          	  $request->{data}->{recApproval} = $dh->rec_approval;
	          $request->{data}->{consent} = $dh->consent;
        }
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

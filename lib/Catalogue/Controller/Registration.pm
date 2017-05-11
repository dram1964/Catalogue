package Catalogue::Controller::Registration;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Registration - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Registration in Registration.');
}

=head2 new_account

displays page for new users to register their details


sub new_account :Path('new_account') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
    $c->stash(template => 'registration/new_account.tt2');
}
=cut

=head2 ng_new

displays page for new users to register their details on angularised form

=cut

sub ng_new :Path('ng_new') :Args(0) {
    my ( $self, $c ) = @_;
  

    $c->stash(
	test_data => 'Some random text',
	template => 'registration/new.tt2');
}

sub ng_new_submitted :Path('ng_new_submitted') :Args(0) {
    my ( $self, $c, $user ) = @_;
    my $details = {
    	 last_name => $c->request->params->{lastName},
    	 first_name => $c->request->params->{firstName},
    	 email_address => $c->request->params->{email1},
    	 password => $c->request->params->{password1},
    	 job_title => $c->request->params->{jobTitle},
    	 department => $c->request->params->{department},
    	 organisation => $c->request->params->{organisation},
    	 address1 => $c->request->params->{address1},
    	 address2 => $c->request->params->{address2},
    	 address3 => $c->request->params->{address3},
    	 postcode => $c->request->params->{postcode},
    	 city => $c->request->params->{city},
    	 telephone => $c->request->params->{telephone},
    	 mobile => $c->request->params->{mobile},
    	 agree1 => $c->request->params->{agree1},
    	 agree2 => $c->request->params->{agree2},
    	 agree3 => $c->request->params->{agree3},
   };
    	 my $password2 => $c->request->params->{password2},
    	 my $email2 => $c->request->params->{email2},
   my $user_check = $c->model('DB::RegistrationRequest')->find($details->{email_address});
   if (defined $user_check) {
	$c->stash(error_msg => 'User ' . $details->{email_address} . 'already in use'); 
	$c->log->debug("*** " . $c->stash->{error_msg} . " ***");
   } else {
	my $reg = $c->model('DB::RegistrationRequest')->create($details);
   }

    $c->stash(
	details => $details,
	template => 'registration/new_submitted.tt2');
    $c->detach;
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

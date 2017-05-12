package Catalogue::Controller::DataRequest;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

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

sub request :Path('request') :Args(0) {
    my ( $self, $c ) = @_;
    my $user = $c->user->get_object;
    $c->stash(
      user => $user, 
      template => 'datarequest/request.tt2');
}

sub ng_request_submitted :Path('ng_request_submitted') :Args() {
   my ( $self, $c ) = @_;

   my $parameters = $c->request->body_parameters;


   $c->stash(
     parameters => $parameters,
     template => 'datarequest/submitted.tt2');
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

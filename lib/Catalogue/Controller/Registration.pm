package Catalogue::Controller::Registration;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

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

=cut

sub new_account :Path('new_account') :Args(0) :FormConfig {
    my ( $self, $c ) = @_;
    my $form = $c->stash->{form};
    $c->stash(template => 'registration/new_account.tt2');
}

=head2 new_account

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
    $c->log->debug("*** User: $user ***");
    $c->stash(
	test_data => 'Thanks for sending that data',
	template => 'registration/new.tt2');
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

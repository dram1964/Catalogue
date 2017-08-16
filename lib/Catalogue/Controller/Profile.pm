package Catalogue::Controller::Profile;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Profile - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Profile in Profile.');
}


=head2 show

Shows current users profile data in form

=cut

sub show :Path('show') :Args(0) {
    my ($self, $c) = @_;
    my $user = $c->user->get_object;
    my $profile = $c->model('DB::User')->find($user->id);
    $c->stash(template => 'profile/show.tt2',
	user => $profile);
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

package Catalogue::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

Login logic

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};

    if ($username && $password) {
	if ($c->authenticate({ username => $username,
				password => $password }) ) {
            my $original_path = $c->flash->{original_path};
            if (defined $original_path) {
	      $c->response->redirect($c->uri_for($original_path));
            } else {
	      $c->response->redirect($c->uri_for('/welcome'));
	    }
	} else {
	    $c->stash(error_msg => "Bad username or password");
	}
    } else {
	$c->stash(error_msg => "Empty username or password") 
	    unless ($c->user_exists);
    }
	    
    $c->stash(template => 'login.tt2');
}


=encoding utf8

=head1 AUTHOR

David Ramlakhan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

package Catalogue::Controller::Winpath;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Winpath - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Winpath in Winpath.');
}

=head2 list

Fetch all Winpath Data pass to winpath/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    my $page = $c->request->param('page') || 1;
    my $query = $c->model('DB::WpFact')->search({},
      {
    join => ['laboratory_code', 'order_code', 'test_code'],
    prefetch => ['laboratory_code', 'order_code', 'test_code'],
	rows => 30,
	page => $page,
      });
    my $wp_data = [$query->all];
    my $pager = $query->pager;
    $c->stash(pager => $pager, 
	wp_data => $wp_data,
	template => 'winpath/list.tt2');
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

package Catalogue::Controller::IGAdmin;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::IGAdmin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::IGAdmin in IGAdmin.');
}

=head2 base

Can place common logic to start a chained dispatch here

=cut 

sub base :Chained('/') :PathPart('igadmin') :CaptureArgs(0) {
    my ($self, $c) = @_;
    my $approval_rs = $c->model('DB::DataRequest')->search(
	{status_id => 6});
    $c->stash(resultset => $approval_rs);
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
	template => 'igadmin/list.tt2');
}



=encoding utf8

=head1 AUTHOR

Ubuntu

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

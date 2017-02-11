package Catalogue::Controller::Columns;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::Columns - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::Columns in Columns.');
}

=head2 list

Fetch all column objects and pass to columns/list.tt2 in stash to be displayed

=cut

sub list :Local {
    my ($self, $c) = @_;
    my $page = $c->request->param('page') || 1;
    my $query = $c->model('DB::TableColumn')->search({},
      {
        select => [qw(name col_type col_size table_rel.name )],
	join => 'table_rel',
	rows => 30,
	page => $page,
      });
    my $columns = [$query->all];
    my $pager = $query->pager;
    $c->stash(pager => $pager, 
	columns => $columns,
	template => 'columns/list.tt2');
}

=head2 list_columns

Fetch all the columns for the specified table and display in the colums/list template

=cut

sub list_columns :Path('list_columns') :Args(1) {
    my ($self, $c, $table_id) = @_;
    my $columns = [$c->model('DB::TableColumn')->search({table_id => $table_id})];
    my $table = $c->model('DB::SchemaTable')->find({id => $table_id});
    $c->stash(
	table => $table,
	columns => $columns,
	template => 'columns/list.tt2'
    );
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

package Catalogue::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    INCLUDE_PATH => [
	Catalogue->path_to('root', 'src'),
    ],
    TIMER => 0,
    WRAPPER => 'wrapper.tt2',
    render_die => 1,
);

=head1 NAME

Catalogue::View::HTML - TT View for Catalogue

=head1 DESCRIPTION

TT View for Catalogue.

=head1 SEE ALSO

L<Catalogue>

=head1 AUTHOR

David Ramlakhan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

use utf8;
package Catalogue::Schema::Result::Erid;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::Erid

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<erid>

=cut

__PACKAGE__->table("erid");

=head1 ACCESSORS

=head2 erid_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=cut

__PACKAGE__->add_columns(
  "erid_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</erid_id>

=back

=cut

__PACKAGE__->set_primary_key("erid_id");

=head1 RELATIONS

=head2 c_applications

Type: has_many

Related object: L<Catalogue::Schema::Result::CApplication>

=cut

__PACKAGE__->has_many(
  "c_applications",
  "Catalogue::Schema::Result::CApplication",
  { "foreign.erid_id" => "self.erid_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-04-26 16:49:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tSE76Mn+xrE0aSDSm33laA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

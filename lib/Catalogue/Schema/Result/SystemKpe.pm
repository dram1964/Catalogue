use utf8;
package Catalogue::Schema::Result::SystemKpe;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::SystemKpe

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

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<system_kpe>

=cut

__PACKAGE__->table("system_kpe");

=head1 ACCESSORS

=head2 system_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 kpe_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "system_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "kpe_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</system_id>

=item * L</kpe_id>

=back

=cut

__PACKAGE__->set_primary_key("system_id", "kpe_id");

=head1 RELATIONS

=head2 kpe

Type: belongs_to

Related object: L<Catalogue::Schema::Result::KpeClass>

=cut

__PACKAGE__->belongs_to(
  "kpe",
  "Catalogue::Schema::Result::KpeClass",
  { id => "kpe_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 system

Type: belongs_to

Related object: L<Catalogue::Schema::Result::CatalogueSystem>

=cut

__PACKAGE__->belongs_to(
  "system",
  "Catalogue::Schema::Result::CatalogueSystem",
  { id => "system_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-14 20:15:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UTob4uNpyPwKYjEEcbWwCQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

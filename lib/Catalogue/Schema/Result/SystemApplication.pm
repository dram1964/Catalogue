use utf8;
package Catalogue::Schema::Result::SystemApplication;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::SystemApplication

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

=head1 TABLE: C<system_applications>

=cut

__PACKAGE__->table("system_applications");

=head1 ACCESSORS

=head2 system_id

  data_type: 'integer'
  default_value: 170
  is_foreign_key: 1
  is_nullable: 0

=head2 application_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "system_id",
  {
    data_type      => "integer",
    default_value  => 170,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "application_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</system_id>

=item * L</application_id>

=back

=cut

__PACKAGE__->set_primary_key("system_id", "application_id");

=head1 RELATIONS

=head2 application

Type: belongs_to

Related object: L<Catalogue::Schema::Result::Application>

=cut

__PACKAGE__->belongs_to(
  "application",
  "Catalogue::Schema::Result::Application",
  { id => "application_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-16 17:36:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:v0vWeJo7kZhBe/ZG45AAhw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
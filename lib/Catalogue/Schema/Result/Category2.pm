use utf8;
package Catalogue::Schema::Result::Category2;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::Category2

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

=head1 TABLE: C<category2>

=cut

__PACKAGE__->table("category2");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<erid_name_uni>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("erid_name_uni", ["name"]);

=head1 RELATIONS

=head2 catalogue_systems

Type: has_many

Related object: L<Catalogue::Schema::Result::CatalogueSystem>

=cut

__PACKAGE__->has_many(
  "catalogue_systems",
  "Catalogue::Schema::Result::CatalogueSystem",
  { "foreign.cat2_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-16 17:14:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JHlKhELKJwi1SVfM21IP5A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

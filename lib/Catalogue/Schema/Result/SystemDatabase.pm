use utf8;
package Catalogue::Schema::Result::SystemDatabase;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::SystemDatabase

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

=head1 TABLE: C<system_database>

=cut

__PACKAGE__->table("system_database");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 system_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "system_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</system_id>

=back

=cut

__PACKAGE__->set_primary_key("id", "system_id");

=head1 RELATIONS

=head2 database_schemas

Type: has_many

Related object: L<Catalogue::Schema::Result::DatabaseSchema>

=cut

__PACKAGE__->has_many(
  "database_schemas",
  "Catalogue::Schema::Result::DatabaseSchema",
  { "foreign.database_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-06 16:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O6XO6tIVztalprR9ml1bAQ

=head2 edit_allowed_by

Can the specified user edit the current Database?

=cut

sub edit_allowed_by {
  my ($self, $user) = @_;
  return $user->has_role('curator');
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

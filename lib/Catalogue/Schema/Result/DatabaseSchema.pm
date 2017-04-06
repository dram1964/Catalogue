use utf8;
package Catalogue::Schema::Result::DatabaseSchema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::DatabaseSchema

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

=head1 TABLE: C<database_schema>

=cut

__PACKAGE__->table("database_schema");

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

=head2 database_id

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
  "database_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</database_id>

=back

=cut

__PACKAGE__->set_primary_key("id", "database_id");

=head1 RELATIONS

=head2 database

Type: belongs_to

Related object: L<Catalogue::Schema::Result::SystemDatabase>

=cut

__PACKAGE__->belongs_to(
  "database",
  "Catalogue::Schema::Result::SystemDatabase",
  { id => "database_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 schema_tables

Type: has_many

Related object: L<Catalogue::Schema::Result::SchemaTable>

=cut

__PACKAGE__->has_many(
  "schema_tables",
  "Catalogue::Schema::Result::SchemaTable",
  { "foreign.schema_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-03-29 16:29:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xBu9KCetbKkyE5fPQCKGlw

=head2 edit_allowed_by

Can the specified user edit the current Schema?

=cut

sub edit_allowed_by {
  my ($self, $user) = @_;
  return $user->has_role('curator');
}

=head2 sys_database

Type: overridden belongs_to relation to avoid name clashes in DBIC joins

Related object: L<Catalogue::Schema::Result::SystemDatabase>

=cut

__PACKAGE__->belongs_to(
  "sys_database",
  "Catalogue::Schema::Result::SystemDatabase",
  { id => "database_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

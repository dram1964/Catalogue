use utf8;
package Catalogue::Schema::Result::SchemaTable;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::SchemaTable

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

=head1 TABLE: C<schema_table>

=cut

__PACKAGE__->table("schema_table");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 1000

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 schema_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 1000 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "schema_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</schema_id>

=back

=cut

__PACKAGE__->set_primary_key("id", "schema_id");

=head1 RELATIONS

=head2 schema

Type: belongs_to

Related object: L<Catalogue::Schema::Result::DatabaseSchema>

=cut

__PACKAGE__->belongs_to(
  "schema",
  "Catalogue::Schema::Result::DatabaseSchema",
  { id => "schema_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 table_columns

Type: has_many

Related object: L<Catalogue::Schema::Result::TableColumn>

=cut

__PACKAGE__->has_many(
  "table_columns",
  "Catalogue::Schema::Result::TableColumn",
  { "foreign.table_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-05 18:26:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SIdVAPOcR6ZpoGdmU1STlg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

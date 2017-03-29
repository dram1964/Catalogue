use utf8;
package Catalogue::Schema::Result::TableColumn;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::TableColumn

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

=head1 TABLE: C<table_column>

=cut

__PACKAGE__->table("table_column");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 1000

=head2 col_type

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 col_size

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 col_enum

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 col_pattern

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 completion_rate

  data_type: 'integer'
  is_nullable: 1

=head2 first_record_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 last_record_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 table_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 1000 },
  "col_type",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "col_size",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "col_enum",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "col_pattern",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "completion_rate",
  { data_type => "integer", is_nullable => 1 },
  "first_record_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "last_record_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "table_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 table_rel

Type: belongs_to

Related object: L<Catalogue::Schema::Result::SchemaTable>

=cut

__PACKAGE__->belongs_to(
  "table_rel",
  "Catalogue::Schema::Result::SchemaTable",
  { id => "table_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-03-29 16:29:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kGz2E9wN4Ok1fmws85gxIw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

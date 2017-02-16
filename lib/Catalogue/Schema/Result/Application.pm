use utf8;
package Catalogue::Schema::Result::Application;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::Application

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

=head1 TABLE: C<application>

=cut

__PACKAGE__->table("application");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name", ["name"]);

=head1 RELATIONS

=head2 system_applications

Type: has_many

Related object: L<Catalogue::Schema::Result::SystemApplication>

=cut

__PACKAGE__->has_many(
  "system_applications",
  "Catalogue::Schema::Result::SystemApplication",
  { "foreign.application_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 systems

Type: many_to_many

Composing rels: L</system_applications> -> system

=cut

__PACKAGE__->many_to_many("systems", "system_applications", "system");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-16 04:49:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zrQK6w/WLPfWvFGzkjNQgg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

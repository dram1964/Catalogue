use utf8;
package Catalogue::Schema::Result::CatalogueSystem;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::CatalogueSystem

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

=head1 TABLE: C<catalogue_system>

=cut

__PACKAGE__->table("catalogue_system");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 system_classes

Type: has_many

Related object: L<Catalogue::Schema::Result::SystemClass>

=cut

__PACKAGE__->has_many(
  "system_classes",
  "Catalogue::Schema::Result::SystemClass",
  { "foreign.system_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 system_databases

Type: has_many

Related object: L<Catalogue::Schema::Result::SystemDatabase>

=cut

__PACKAGE__->has_many(
  "system_databases",
  "Catalogue::Schema::Result::SystemDatabase",
  { "foreign.system_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 system_db_types

Type: has_many

Related object: L<Catalogue::Schema::Result::SystemDbType>

=cut

__PACKAGE__->has_many(
  "system_db_types",
  "Catalogue::Schema::Result::SystemDbType",
  { "foreign.system_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 system_kpes

Type: has_many

Related object: L<Catalogue::Schema::Result::SystemKpe>

=cut

__PACKAGE__->has_many(
  "system_kpes",
  "Catalogue::Schema::Result::SystemKpe",
  { "foreign.system_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 classes

Type: many_to_many

Composing rels: L</system_classes> -> class

=cut

__PACKAGE__->many_to_many("classes", "system_classes", "class");

=head2 db_types

Type: many_to_many

Composing rels: L</system_db_types> -> db_type

=cut

__PACKAGE__->many_to_many("db_types", "system_db_types", "db_type");

=head2 kpes

Type: many_to_many

Composing rels: L</system_kpes> -> kpe

=cut

__PACKAGE__->many_to_many("kpes", "system_kpes", "kpe");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-14 20:15:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Mq9YWpM1+v5z9xeV2hG6/A


=head2 system_class_list

Return a comma-separated list of classes for the current system

=cut

sub system_class_list {
    my ($self) = @_;
    my @classes;
    foreach my $class ($self->classes) {
	push(@classes, $class->name);
    }
    return join(', ', @classes);
}

=head2 system_database_list

Return a comma-separated list of databases for the current system

=cut 

sub system_database_list {
    my ($self) = @_;
    my @databases;
    foreach my $database ($self->db_types) {
	push(@databases, $database->name);
    }
    return join(', ', @databases);
}
__PACKAGE__->meta->make_immutable;
1;

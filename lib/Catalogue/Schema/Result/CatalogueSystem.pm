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
  size: 100

=head2 application_id

  data_type: 'integer'
  is_nullable: 1

=head2 erid_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=head2 kpe_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=head2 supplier_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=head2 cat2_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "application_id",
  { data_type => "integer", is_nullable => 1 },
  "erid_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "kpe_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "supplier_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "cat2_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
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

=head2 cat2

Type: belongs_to

Related object: L<Catalogue::Schema::Result::Category2>

=cut

__PACKAGE__->belongs_to(
  "cat2",
  "Catalogue::Schema::Result::Category2",
  { id => "cat2_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 erid

Type: belongs_to

Related object: L<Catalogue::Schema::Result::Erid>

=cut

__PACKAGE__->belongs_to(
  "erid",
  "Catalogue::Schema::Result::Erid",
  { id => "erid_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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

=head2 supplier

Type: belongs_to

Related object: L<Catalogue::Schema::Result::Supplier>

=cut

__PACKAGE__->belongs_to(
  "supplier",
  "Catalogue::Schema::Result::Supplier",
  { id => "supplier_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 system_applications

Type: has_many

Related object: L<Catalogue::Schema::Result::SystemApplication>

=cut

__PACKAGE__->has_many(
  "system_applications",
  "Catalogue::Schema::Result::SystemApplication",
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

=head2 applications

Type: many_to_many

Composing rels: L</system_applications> -> application

=cut

__PACKAGE__->many_to_many("applications", "system_applications", "application");

=head2 db_types

Type: many_to_many

Composing rels: L</system_db_types> -> db_type

=cut

__PACKAGE__->many_to_many("db_types", "system_db_types", "db_type");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-16 17:36:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ByNH9XGzkzLk1hlSaTyblA


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

=head2 system_application_names

Return a comma-separated list of system application names for the current system

=cut 

sub system_application_names {
    my ($self) = @_;
    my @applications;
    foreach my $application ($self->applications) {
	push(@applications, $application->name);
    }
    return join(', ', @applications);
}

=head2 system_application_descriptions

Return a comma-separated list of system application descriptions for the current system

=cut 

sub system_application_descriptions {
    my ($self) = @_;
    my @applications;
    foreach my $application ($self->applications) {
	push(@applications, $application->description);
    }
    return join(', ', @applications);
}

=head2 edit_allowed_by

Can the specified user edit the current System?

=cut

sub edit_allowed_by {
  my ($self, $user) = @_;
  return $user->has_role('curator');
}


__PACKAGE__->meta->make_immutable;
1;

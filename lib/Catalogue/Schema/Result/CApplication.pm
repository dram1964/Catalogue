use utf8;
package Catalogue::Schema::Result::CApplication;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::CApplication

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

=head1 TABLE: C<c_application>

=cut

__PACKAGE__->table("c_application");

=head1 ACCESSORS

=head2 app_id

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
  "app_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</app_id>

=back

=cut

__PACKAGE__->set_primary_key("app_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<application_name_uni>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("application_name_uni", ["name"]);

=head1 RELATIONS

=head2 c_app_dbs

Type: has_many

Related object: L<Catalogue::Schema::Result::CAppDb>

=cut

__PACKAGE__->has_many(
  "c_app_dbs",
  "Catalogue::Schema::Result::CAppDb",
  { "foreign.app_id" => "self.app_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbs

Type: many_to_many

Composing rels: L</c_app_dbs> -> db

=cut

__PACKAGE__->many_to_many("dbs", "c_app_dbs", "db");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-04-25 07:52:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uJvjdshaa2EBxRS1Kq3r/w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

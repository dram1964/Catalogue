use utf8;
package Catalogue::Schema::Result::CServer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::CServer

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

=head1 TABLE: C<c_server>

=cut

__PACKAGE__->table("c_server");

=head1 ACCESSORS

=head2 srv_id

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
  "srv_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</srv_id>

=back

=cut

__PACKAGE__->set_primary_key("srv_id");

=head1 RELATIONS

=head2 c_db_servers

Type: has_many

Related object: L<Catalogue::Schema::Result::CDbServer>

=cut

__PACKAGE__->has_many(
  "c_db_servers",
  "Catalogue::Schema::Result::CDbServer",
  { "foreign.srv_id" => "self.srv_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbs

Type: many_to_many

Composing rels: L</c_db_servers> -> db

=cut

__PACKAGE__->many_to_many("dbs", "c_db_servers", "db");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-04-25 09:47:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0Gag4s4psGv9S/NI6hkctA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

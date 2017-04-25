use utf8;
package Catalogue::Schema::Result::CDatabase;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::CDatabase

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

=head1 TABLE: C<c_database>

=cut

__PACKAGE__->table("c_database");

=head1 ACCESSORS

=head2 db_id

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
  "db_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</db_id>

=back

=cut

__PACKAGE__->set_primary_key("db_id");

=head1 RELATIONS

=head2 c_app_dbs

Type: has_many

Related object: L<Catalogue::Schema::Result::CAppDb>

=cut

__PACKAGE__->has_many(
  "c_app_dbs",
  "Catalogue::Schema::Result::CAppDb",
  { "foreign.db_id" => "self.db_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 c_db_servers

Type: has_many

Related object: L<Catalogue::Schema::Result::CDbServer>

=cut

__PACKAGE__->has_many(
  "c_db_servers",
  "Catalogue::Schema::Result::CDbServer",
  { "foreign.db_id" => "self.db_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 c_schemas

Type: has_many

Related object: L<Catalogue::Schema::Result::CSchema>

=cut

__PACKAGE__->has_many(
  "c_schemas",
  "Catalogue::Schema::Result::CSchema",
  { "foreign.db_id" => "self.db_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 apps

Type: many_to_many

Composing rels: L</c_app_dbs> -> app

=cut

__PACKAGE__->many_to_many("apps", "c_app_dbs", "app");

=head2 srvs

Type: many_to_many

Composing rels: L</c_db_servers> -> srv

=cut

__PACKAGE__->many_to_many("srvs", "c_db_servers", "srv");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-04-25 09:47:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5LG6eogIaIMXKwc8DTmBvA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head2 server_name_list

Return a comma-separated list of servers for the current database

=cut 

sub server_name_list {
    my ($self) = @_;
    my @servers;
    foreach my $server ($self->srvs) {
	push(@servers, $server->name);
    }
    return join(', ', @servers);
}

=head2 edit_allowed_by

Can the specified user edit the current Database?

=cut

sub edit_allowed_by {
  my ($self, $user) = @_;
  return $user->has_role('curator');
}

__PACKAGE__->meta->make_immutable;
1;

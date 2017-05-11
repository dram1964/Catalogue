use utf8;
package Catalogue::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 email_address

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 active

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "email_address",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "active",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<ux_username>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("ux_username", ["username"]);

=head1 RELATIONS

=head2 registration_requests

Type: has_many

Related object: L<Catalogue::Schema::Result::RegistrationRequest>

=cut

__PACKAGE__->has_many(
  "registration_requests",
  "Catalogue::Schema::Result::RegistrationRequest",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<Catalogue::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "Catalogue::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 roles

Type: many_to_many

Composing rels: L</user_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "user_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-05-11 21:29:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:K2LEqpQ9x2esR7upxXuCEg

=head2 has_role

Check if a user has the specified role

=cut 

use Perl6::Junction qw/any/;
sub has_role {
  my ($self, $role) = @_;
  return any(map { $_->role } $self->roles ) eq $role;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->add_columns(
  'password' => {
    passphrase		=> 'rfc2307',
    passphrase_class 	=> 'SaltedDigest',
    passphrase_args	=> {
	algorithm	=> 'SHA-1',
	salt_random	=> 20.
    },
    passphrase_check_method => 'check_password',
  },
);

=head2 access_allowed_to

Can the specified user access the current Schema?

=cut

sub access_allowed_to {
  my ($self, $user) = @_;
  return $user->has_role('admin');
}

__PACKAGE__->meta->make_immutable;
1;

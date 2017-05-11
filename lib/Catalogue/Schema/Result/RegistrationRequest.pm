use utf8;
package Catalogue::Schema::Result::RegistrationRequest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::RegistrationRequest

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

=head1 TABLE: C<registration_request>

=cut

__PACKAGE__->table("registration_request");

=head1 ACCESSORS

=head2 email_address

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 30

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 30

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 job_title

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 department

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 organisation

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 address1

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 address2

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 address3

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 postcode

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 city

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 telephone

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 agree1

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 agree2

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 agree3

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 request_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "email_address",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 30 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 30 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "job_title",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "department",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "organisation",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "address1",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "address2",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "address3",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "postcode",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "city",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "telephone",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "agree1",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "agree2",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "agree3",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "request_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</email_address>

=back

=cut

__PACKAGE__->set_primary_key("email_address");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-05-11 11:48:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1w6mWSaY3TG78NCcgchTKA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

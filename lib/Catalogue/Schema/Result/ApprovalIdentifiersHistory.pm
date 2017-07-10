use utf8;
package Catalogue::Schema::Result::ApprovalIdentifiersHistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::ApprovalIdentifiersHistory

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

=head1 TABLE: C<approval_identifiers_history>

=cut

__PACKAGE__->table("approval_identifiers_history");

=head1 ACCESSORS

=head2 request_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 ptname

  data_type: 'tinyint'
  is_nullable: 1

=head2 ptnumber

  data_type: 'tinyint'
  is_nullable: 1

=head2 dob

  data_type: 'tinyint'
  is_nullable: 1

=head2 nhsnumber

  data_type: 'tinyint'
  is_nullable: 1

=head2 addr

  data_type: 'tinyint'
  is_nullable: 1

=head2 approval_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 approver

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "request_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ptname",
  { data_type => "tinyint", is_nullable => 1 },
  "ptnumber",
  { data_type => "tinyint", is_nullable => 1 },
  "dob",
  { data_type => "tinyint", is_nullable => 1 },
  "nhsnumber",
  { data_type => "tinyint", is_nullable => 1 },
  "addr",
  { data_type => "tinyint", is_nullable => 1 },
  "approval_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "approver",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</request_id>

=item * L</approval_date>

=back

=cut

__PACKAGE__->set_primary_key("request_id", "approval_date");

=head1 RELATIONS

=head2 request

Type: belongs_to

Related object: L<Catalogue::Schema::Result::ApprovalIdentifier>

=cut

__PACKAGE__->belongs_to(
  "request",
  "Catalogue::Schema::Result::ApprovalIdentifier",
  { request_id => "request_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-10 18:35:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QWfgpUv8ORJN7TwuN6Dqhw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

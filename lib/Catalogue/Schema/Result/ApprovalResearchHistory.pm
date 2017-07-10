use utf8;
package Catalogue::Schema::Result::ApprovalResearchHistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::ApprovalResearchHistory

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

=head1 TABLE: C<approval_research_history>

=cut

__PACKAGE__->table("approval_research_history");

=head1 ACCESSORS

=head2 request_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rec_approval_ref

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 rec_approval_file

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 consent_method

  data_type: 'integer'
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
  "rec_approval_ref",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "rec_approval_file",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "consent_method",
  { data_type => "integer", is_nullable => 1 },
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

Related object: L<Catalogue::Schema::Result::ApprovalResearch>

=cut

__PACKAGE__->belongs_to(
  "request",
  "Catalogue::Schema::Result::ApprovalResearch",
  { request_id => "request_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-10 16:11:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SC0AMqUbiOWqL8isur/DNw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

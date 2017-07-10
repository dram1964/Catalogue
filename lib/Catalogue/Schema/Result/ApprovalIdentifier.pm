use utf8;
package Catalogue::Schema::Result::ApprovalIdentifier;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::ApprovalIdentifier

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

=head1 TABLE: C<approval_identifiers>

=cut

__PACKAGE__->table("approval_identifiers");

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

=head2 other

  data_type: 'text'
  is_nullable: 1

=head2 approver

  data_type: 'integer'
  is_foreign_key: 1
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
  "other",
  { data_type => "text", is_nullable => 1 },
  "approver",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</request_id>

=back

=cut

__PACKAGE__->set_primary_key("request_id");

=head1 RELATIONS

=head2 approval_identifiers_histories

Type: has_many

Related object: L<Catalogue::Schema::Result::ApprovalIdentifiersHistory>

=cut

__PACKAGE__->has_many(
  "approval_identifiers_histories",
  "Catalogue::Schema::Result::ApprovalIdentifiersHistory",
  { "foreign.request_id" => "self.request_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 approver

Type: belongs_to

Related object: L<Catalogue::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "approver",
  "Catalogue::Schema::Result::User",
  { id => "approver" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 request

Type: belongs_to

Related object: L<Catalogue::Schema::Result::DataRequest>

=cut

__PACKAGE__->belongs_to(
  "request",
  "Catalogue::Schema::Result::DataRequest",
  { id => "request_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-10 19:50:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:m0t3DnhVq8XIFtoOljyqcg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

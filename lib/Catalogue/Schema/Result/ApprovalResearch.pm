use utf8;
package Catalogue::Schema::Result::ApprovalResearch;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::ApprovalResearch

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

=head1 TABLE: C<approval_research>

=cut

__PACKAGE__->table("approval_research");

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

=head2 approver

  data_type: 'integer'
  is_foreign_key: 1
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

=head2 approval_research_histories

Type: has_many

Related object: L<Catalogue::Schema::Result::ApprovalResearchHistory>

=cut

__PACKAGE__->has_many(
  "approval_research_histories",
  "Catalogue::Schema::Result::ApprovalResearchHistory",
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-10 16:11:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3DGQCV132VI44sIx5GosAA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

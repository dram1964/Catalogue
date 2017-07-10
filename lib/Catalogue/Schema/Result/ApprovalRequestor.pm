use utf8;
package Catalogue::Schema::Result::ApprovalRequestor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::ApprovalRequestor

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

=head1 TABLE: C<approval_requestor>

=cut

__PACKAGE__->table("approval_requestor");

=head1 ACCESSORS

=head2 request_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 validated

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 verification_method

  data_type: 'integer'
  is_nullable: 1

=head2 notes

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "request_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "validated",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "verification_method",
  { data_type => "integer", is_nullable => 1 },
  "notes",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</request_id>

=back

=cut

__PACKAGE__->set_primary_key("request_id");

=head1 RELATIONS

=head2 approval_requestor_histories

Type: has_many

Related object: L<Catalogue::Schema::Result::ApprovalRequestorHistory>

=cut

__PACKAGE__->has_many(
  "approval_requestor_histories",
  "Catalogue::Schema::Result::ApprovalRequestorHistory",
  { "foreign.request_id" => "self.request_id" },
  { cascade_copy => 0, cascade_delete => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-10 11:14:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LvPX0IySkk3EC8nqUU6uww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

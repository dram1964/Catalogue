use utf8;
package Catalogue::Schema::Result::DataRequest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::DataRequest

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

=head1 TABLE: C<data_request>

=cut

__PACKAGE__->table("data_request");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 cardiology_details

  data_type: 'text'
  is_nullable: 1

=head2 chemotherapy_details

  data_type: 'text'
  is_nullable: 1

=head2 diagnosis_details

  data_type: 'text'
  is_nullable: 1

=head2 episode_details

  data_type: 'text'
  is_nullable: 1

=head2 other_details

  data_type: 'text'
  is_nullable: 1

=head2 pathology_details

  data_type: 'text'
  is_nullable: 1

=head2 pharmacy_details

  data_type: 'text'
  is_nullable: 1

=head2 radiology_details

  data_type: 'text'
  is_nullable: 1

=head2 theatre_details

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "cardiology_details",
  { data_type => "text", is_nullable => 1 },
  "chemotherapy_details",
  { data_type => "text", is_nullable => 1 },
  "diagnosis_details",
  { data_type => "text", is_nullable => 1 },
  "episode_details",
  { data_type => "text", is_nullable => 1 },
  "other_details",
  { data_type => "text", is_nullable => 1 },
  "pathology_details",
  { data_type => "text", is_nullable => 1 },
  "pharmacy_details",
  { data_type => "text", is_nullable => 1 },
  "radiology_details",
  { data_type => "text", is_nullable => 1 },
  "theatre_details",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<Catalogue::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Catalogue::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-05-12 15:09:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xjDgVa49MKfxoq/rhakeEA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
=head2 delete_allowed_by

Can the specified user delete the current Registration Request?

=cut

sub delete_allowed_by {
  my ($self, $user) = @_;
  return $user->has_role('admin');
}

=head2 edit_allowed_by

Can the specified user edit the current Registration Request?

=cut

sub edit_allowed_by {
  my ($self, $user) = @_;
  return $user->has_role('curator');
}

__PACKAGE__->meta->make_immutable;
1;

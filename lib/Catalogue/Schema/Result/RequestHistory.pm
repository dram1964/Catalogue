use utf8;
package Catalogue::Schema::Result::RequestHistory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::RequestHistory

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

=head1 TABLE: C<request_history>

=cut

__PACKAGE__->table("request_history");

=head1 ACCESSORS

=head2 request_id

  data_type: 'integer'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
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

=head2 request_type_id

  data_type: 'integer'
  is_nullable: 1

=head2 status_id

  data_type: 'integer'
  is_nullable: 1

=head2 status_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 identifiable

  data_type: 'integer'
  is_nullable: 1

=head2 identifiers

  data_type: 'text'
  is_nullable: 1

=head2 additional_identifiers

  data_type: 'text'
  is_nullable: 1

=head2 publish

  data_type: 'integer'
  is_nullable: 1

=head2 publish_to

  data_type: 'text'
  is_nullable: 1

=head2 storing

  data_type: 'text'
  is_nullable: 1

=head2 completion

  data_type: 'text'
  is_nullable: 1

=head2 additional_info

  data_type: 'text'
  is_nullable: 1

=head2 objective

  data_type: 'text'
  is_nullable: 1

=head2 service_area

  data_type: 'text'
  is_nullable: 1

=head2 population

  data_type: 'text'
  is_nullable: 1

=head2 research_area

  data_type: 'text'
  is_nullable: 1

=head2 rec_approval

  data_type: 'text'
  is_nullable: 1

=head2 consent

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "request_id",
  { data_type => "integer", is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
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
  "request_type_id",
  { data_type => "integer", is_nullable => 1 },
  "status_id",
  { data_type => "integer", is_nullable => 1 },
  "status_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "identifiable",
  { data_type => "integer", is_nullable => 1 },
  "identifiers",
  { data_type => "text", is_nullable => 1 },
  "additional_identifiers",
  { data_type => "text", is_nullable => 1 },
  "publish",
  { data_type => "integer", is_nullable => 1 },
  "publish_to",
  { data_type => "text", is_nullable => 1 },
  "storing",
  { data_type => "text", is_nullable => 1 },
  "completion",
  { data_type => "text", is_nullable => 1 },
  "additional_info",
  { data_type => "text", is_nullable => 1 },
  "objective",
  { data_type => "text", is_nullable => 1 },
  "service_area",
  { data_type => "text", is_nullable => 1 },
  "population",
  { data_type => "text", is_nullable => 1 },
  "research_area",
  { data_type => "text", is_nullable => 1 },
  "rec_approval",
  { data_type => "text", is_nullable => 1 },
  "consent",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</request_id>

=item * L</status_date>

=back

=cut

__PACKAGE__->set_primary_key("request_id", "status_date");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-10 10:31:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:x90UCi4crxCzkzsR9w3YUQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

use utf8;
package Catalogue::Schema::Result::DataHandling;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Catalogue::Schema::Result::DataHandling

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

=head1 TABLE: C<data_handling>

=cut

__PACKAGE__->table("data_handling");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 request_id

  data_type: 'integer'
  is_foreign_key: 1
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
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "request_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-06-28 11:37:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AIl9Rq62DfjHa0XxoebRtw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

package Catalogue::Controller::DataExtract;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalogue::Controller::DataExtract - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalogue::Controller::DataExtract in DataExtract.');
}

=head2 base

Adds a resultset for DataRequest to the stash for chained dispatch. Also 
uses flash load_status_msg to handle status messages

=cut 

sub base :Chained('/') :PathPart('dataextract') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::DataRequest'));
    $c->load_status_msgs;
}

=head2 object

Fetch the specified data request object based on the request id and store it in the stash. 

=cut 

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
   my ($self, $c, $id) = @_;
   $c->stash(object => $c->stash->{resultset}->find($id));
   die "Class not found" if !$c->stash->{object};
}

=head2 display

Displays the data requested

=cut

sub display_request :Chained('object') :Args() {
   my ($self, $c) = @_;
   my $data_request = $c->stash->{object};

   my $dh_rs = $c->model('DB::DataHandling')->search({
	request_id => $data_request->id
   });
    my $risk_scores_rs = $c->model('DB::RiskScore')->search(
	{ request_id => $data_request->id});
    my $risk_scores;
    while (my $row = $risk_scores_rs->next) {
	my $risk_score = {request_id => $data_request->id, 
	     risk_category => $row->risk_category,
	     rating => $row->rating, 
	     likelihood => $row->likelihood,
	     score => $row->score
	};
	push @$risk_scores, $risk_score;
    }
	
   my $dh = $dh_rs->first;

   my $friendly_identifiers = $dh->friendly_identifiers( $c->model('DB::PtIdentifier'));

   $c->stash(
        dh => $dh,
	risk_scores => $risk_scores,
	request => $data_request,
	identifiers => $friendly_identifiers,
	template => 'dataextract/display_request.tt2');
}

=head2 display_submissions

Displays data submitted for a specified request

=cut 

sub display_submissions :Chained('object') :Args(0) {
    my ($self, $c) = @_;
   my $data_request = $c->stash->{object};
    my $submissions = [
	{
	project_type => 'SSIS',
	project_name => 'HIC_ACS_Deidentified',
	project_location => 'Upathsql: d:\pathreports\SSAS\Projects',
	packages	=> [
		{
		package_name => 'Deidentified_Plain_Data.dtsx',
		extracts => [
		    {
		    source_type	=> 'SQL Server',
		    source_name => 'Upathsql.HIC',
		    extract_name  => 'Biochemistry Data',
		    extract_query => 'select t1.deid, t2.testcode, Pathreports.Winpath.ufn_numeric_or_greater_than_result(t2.result) result, t2.units, t2.rangelo, t2.rangehi, DATEADD(DAY, 33, t2.collectdate) collect_date_skewed, t2.collecttime
		from ACS.tpt_candidates_lookup t1
		join ACS.results_combined t2 on t1.ptnumber = t2.ptnumber
		order by labno, testcode, sort_order',
		    extract_output_location => 'Upathsql: d:\\pathreports\\data\\HIC\\ACS\\deidentified_extract\\',
		    output_type		=> 'CSV: field separator: "comma", text qualifier: "double-quote", include header row, code page 1252, locale en-gb',
		    filename		=> 'biochemistry_data.csv',
		    },
		],
		},
	],
	extract_run_date => '2018-02-14',
	extract_output_file	=> 'hic_acs.zip',
	extract_output_file_location	=> 'Upathsql: D:\pathreports\data\hic\acs\deidentified_extract',
	extract_delivery_method		=> 'file upload to https://www.ucl.ac.uk/dropbox for collection by s.denaxas@ucl.ac.uk within 10 days of upload',
	}
    ];
    
    $c->stash(
	request => $data_request,
	submissions => $submissions,
	template => 'dataextract/display_submissions.tt2',
    );
}

=head2 record

Displays template for recording details of data extract

=cut

sub record :Chained('object') :Args(0) {
	my ( $self, $c ) = @_;
   	my $data_request = $c->stash->{object};
	$c->stash(
	    request => $data_request,
	    template => 'dataextract/record.tt2',
	);
}

=head1 list

Display list of requests that have had IG Review complsted

=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    my $data_requests = [$c->stash->{resultset}->search({status_id => { in => [8, 9, 10]}})];
    $c->stash(
	data_requests => $data_requests,
	template => 'dataextract/list.tt2'
    );
}



=encoding utf8

=head1 AUTHOR

Ubuntu

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

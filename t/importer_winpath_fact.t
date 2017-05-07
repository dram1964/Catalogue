use Test::More;
use Catalogue::Schema;

my $dsn = "dbi:mysql:catalogue_test";
my $connection = Catalogue::Schema->connect($dsn, 'tutorial', 'thispassword');
my $fact_rs = $connection->resultset('WpFact');

BEGIN {use_ok 'Catalogue::Importer::Winpath::Fact'}

ok(my $fact = Catalogue::Importer::Winpath::Fact->new(
	order_code => 'FBC',
	test_code => 'WCC',
	laboratory_code => 'BA',
	cluster_name => 'Haematology',
	year_of_birth => '1964',
	year_of_result => '2010',
	gender => 'U',
	requests => '23'
), "Fact Constructor");


is($fact->order_code, 'FBC', "Order code accessor");
is($fact->test_code, 'WCC', "Test Code accessor");
is($fact->laboratory_code, 'BA', "Laboratory Code accessor");
is($fact->cluster_name, 'Haematology', "Cluster name accessor");
is($fact->year_of_birth, '1964', "Year of birth accessor");
is($fact->year_of_result, '2010', "Year of result accessor");
is($fact->gender, 'U', "Gender accessor");
is($fact->requests, '23', "Requests accessor");

ok($fact->update_or_add, "Can add order record");

ok($fact->requests('21'), "Update the requests");
ok($fact->update_or_add, "Can update the record");

my $count = $fact_rs->search({	
	order_code => 'FBC',
	test_code => 'WCC',
	laboratory_code => 'BA',
	cluster_name => 'Haematology',
	year_of_birth => '1964',
	year_of_result => '2010',
	gender => 'U',})->count();

cmp_ok($count, '==', 1, "Only one record for updated test code");


ok($fact->delete, "Can delete test record");
$count = $fact_rs->search({	
	order_code => 'FBC',
	test_code => 'WCC',
	laboratory_code => 'BA',
	cluster_name => 'Haematology',
	year_of_birth => '1964',
	year_of_result => '2010',
	gender => 'U',})->count();

cmp_ok($count, "==", 0, "Record no longer exists in database");


done_testing();

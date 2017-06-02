use strict;
use warnings;
use Test::More;
use Catalogue::Schema;
use_ok("Test::WWW::Mechanize::Catalyst" => "Catalogue");


my $welcome_msg = "Welcome to the ";
my $page_title = 'The Clinical Research Informatics Data Catalogue';

my $anon_ua = Test::WWW::Mechanize::Catalyst->new;
my $user = Test::WWW::Mechanize::Catalyst->new;
$user->get("/login?username=test01&password=mypass");
my $curator = Test::WWW::Mechanize::Catalyst->new;
$curator->get("/login?username=test02&password=mypass");
my $admin = Test::WWW::Mechanize::Catalyst->new;
$admin->get("/login?username=test03&password=mypass");

my $dsn = "dbi:mysql:catalogue_test";
my $connection = Catalogue::Schema->connect($dsn, 'tutorial', 'thispassword');

my $app = $connection->resultset('CApplication')->first;
my $db = $connection->resultset('CDatabase')->first;
my $table = $connection->resultset('CTable')->first;
my $dataset = $connection->resultset('Dataset')->first;
my $datarequest = $connection->resultset('DataRequest')->first;

my $allowed_anon = {
"/registration/ng_new" => "New User Registration",
"/login" => "Please enter login details",
"/datasets/list" => "Catalogue Datasets",
};

my $user_login_required = {
'/applications/list' => 'List of all Applications on the Metadata Catalogue',
'/applications/search?search=cardiology' => 'Applications matching search term <strong>%cardiology%</strong>', 
'/category2/list' => 'Category2s',
'/columns/list' => 'Table Columns',
'/columns/list_columns/' . $table->id => 'Table Columns',
'/columns/search?search=patient' => 'Table Columns',
'/databases/list' => 'System Databases',
'/datarequest/list' => 'new Request',
'/erid/list' => 'ERIDs',
'/kpe/list' => 'Key Production Environments',
'/schemas/list' => 'Database Schemas',
'/supplier/list' => 'Suppliers',
'/tables/list' => 'Database Tables',
};



my $curator_login_required = {
'/applications/add' => 'Edit Application',
'/applications/id/' . $app->id . '/edit' => 'Edit Application',
'/category2/add' => 'Category2s',
'/databases/id/' . $db->id . '/edit_description' => 'System Databases',
'/databases/download/csv' => 'System Databases',
'/databases/download/text' => 'System Databases',
'/databases/download/html' => 'System Databases',
'/registration/list' => 'Registration Requests',
'/tasks/list' => 'Project Task List',
'/users/list' => 'User Maintenance',
};

my $admin_login_required = {
'/application/delete' => 'Delete Application',
};

my $requestor_login_required = {
'/datarequest/request' => 'First Name',
'/datarequest/id/' . $datarequest->id . '/review' => 'Reviewing Data Request ID: ',
};

while (my ($action, $response) = each %$allowed_anon) {
    $anon_ua->get($action);
    $anon_ua->content_contains($response,  "Anonymous allowed " . $action);
}

for (keys %$user_login_required) {
    my $url_action = $_;
    $anon_ua->get($url_action);
    $anon_ua->content_contains("Please enter login details", "Anonymous denied " . $url_action);
    $anon_ua->content_lacks($user_login_required->{$url_action}, $url_action . " blocked for Anonymous");
    $user->get($url_action);
    $user->content_contains($user_login_required->{$url_action}, $url_action . " allowed for User");
    $curator->get($url_action);
    $curator->content_contains($user_login_required->{$url_action}, $url_action . " allowed for Curator");
    $admin->get($url_action);
    $admin->content_contains($user_login_required->{$url_action}, $url_action . " allowed for Admin");
}

for (keys %$curator_login_required) {
    my $url_action = $_;
    $anon_ua->get($url_action);
    $anon_ua->content_contains("Please enter login details", "Anonymous denied " . $url_action);
    $anon_ua->content_lacks($curator_login_required->{$url_action}, "Requested page blocked for Anonymous");
    $user->get($url_action);
    $user->content_contains("Permission Denied", "User denied " . $url_action);
    $user->content_lacks($curator_login_required->{$url_action}, "Requested page blocked for User");
}

SKIP: {
	skip "Not yet implemented", 1;

my $allowed_with_permission = {
'/datasets/id/' . $dataset->id . '/edit' => 'Catalogue Datasets',
'/datasets/add' => 'Catalogue Datasets',
};

for (keys %$allowed_with_permission) {
    my $url_action = $_;
    $anon_ua->get($url_action);
    $anon_ua->content_contains("Permission Denied",  "Anonymous denied by permissions " . $url_action);
}



	$user->get("/login?username=test01&password=mypass");
	$user->content_contains($welcome_msg, "Test01 logged-in");
	$user->get("/users/list");
	$user->content_contains("Permission Denied", "test01 denied users/list");
	$user->get("/users/add");
	$user->content_contains("Permission Denied", "test01 denied users/add");
	$user->get("/users/search?search=example");
	$user->content_contains("Permission Denied", "test01 denied users/search");
	$user->get("/users/id/1/edit");
	$user->content_contains("Permission Denied", "test01 denied user/edit");
	$user->get("/users/id/1/delete");
	$user->content_contains("Permission Denied", "test01 denied user/delete");

	$user->get("/registration/list");
	$user->content_contains("Permission Denied", "test01 denied registration/list");
	$user->get("/registration/ng_new");
	$user->content_contains("You are already logged-in", "test01 denied registration/ng_new");

	$user->get("/datarequest/list");
	$user->content_contains("Permission Denied", "test01 denied datarequest/list");
	$user->get("/tasks/list");
	$user->content_contains("Permission Denied", "test01 denied tasks/list");


	$curator->get("/login?username=test02&password=mypass");
	$curator->content_contains($welcome_msg, "Test02 logged-in");
	$curator->get("/users/list");
	$curator->content_contains("Permission Denied", "test02 denied users/list");
	$curator->get("/users/add");
	$curator->content_contains("Permission Denied", "test02 denied users/add");
	$curator->get("/users/search?search=example");
	$curator->content_contains("Permission Denied", "test02 denied users/search");
	$curator->get("/users/id/2/edit");
	$curator->content_contains("Permission Denied", "test02 denied user/edit");
	$curator->get("/users/id/2/delete");
	$curator->content_contains("Permission Denied", "test02 denied user/delete");

	my $test_user = {
	    username => 'testaccount',
	    password => 'testing',
	    email_address => 'testaccount@example.com',
	    first_name => 'Test',
	    last_name => 'Account',
	    active => 1
	};
	$admin->get("/login?username=test03&password=mypass");
	$admin->content_contains($welcome_msg, "Test03 logged-in");
	$admin->get_ok("/users/add", "test03 allowed to request add user");
	$admin->content_contains("Editing User", "On user add/edit page");
	$admin->get("/users/list");
	$admin->content_lacks("Permission Denied", "test03 allowed users/list");
	$admin->get("/users/search?search=example");
	$admin->content_lacks("Permission Denied", "test03 allowed users/search");
	$admin->get("/users/id/3/edit");
	$admin->content_lacks("Permission Denied", "test03 allowed user/edit");
	$admin->get("/users/id/3/delete");
	$admin->content_contains("Can't delete own account", "test03 denied delete self");
};

done_testing();

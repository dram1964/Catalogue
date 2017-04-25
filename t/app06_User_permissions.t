use strict;
use warnings;
use Test::More;
use_ok("Test::WWW::Mechanize::Catalyst" => "Catalogue");

my $anon_ua = Test::WWW::Mechanize::Catalyst->new;
my $ua1 = Test::WWW::Mechanize::Catalyst->new;
my $ua2 = Test::WWW::Mechanize::Catalyst->new;
my $ua3 = Test::WWW::Mechanize::Catalyst->new;
$anon_ua->get("/databases/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied databases/list");
$anon_ua->get("/applications/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied applications/list");
$anon_ua->get("/schemas/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied schemas/list");
$anon_ua->get("/tables/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied tables/list");
$anon_ua->get("/columns/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied columns/list");

$ua1->get("/login?username=test01&password=mypass");
$ua1->content_contains("Welcome to the Metadata Catalogue", "Test01 logged-in");
$ua1->get("/users/list");
$ua1->content_contains("Permission Denied", "test01 denied users/list");
$ua1->get("/users/add");
$ua1->content_contains("Permission Denied", "test01 denied users/add");
$ua1->get("/users/search?search=example");
$ua1->content_contains("Permission Denied", "test01 denied users/search");
$ua1->get("/users/id/1/edit");
$ua1->content_contains("Permission Denied", "test01 denied user/edit");
$ua1->get("/users/id/1/delete");
$ua1->content_contains("Permission Denied", "test01 denied user/delete");

$ua2->get("/login?username=test02&password=mypass");
$ua2->content_contains("Welcome to the Metadata Catalogue", "Test02 logged-in");
$ua2->get("/users/list");
$ua2->content_contains("Permission Denied", "test02 denied users/list");
$ua2->get("/users/add");
$ua2->content_contains("Permission Denied", "test02 denied users/add");
$ua2->get("/users/search?search=example");
$ua2->content_contains("Permission Denied", "test02 denied users/search");
$ua2->get("/users/id/2/edit");
$ua2->content_contains("Permission Denied", "test02 denied user/edit");
$ua2->get("/users/id/2/delete");
$ua2->content_contains("Permission Denied", "test02 denied user/delete");

my $test_user = {
    username => 'testaccount',
    password => 'testing',
    email_address => 'testaccount@example.com',
    first_name => 'Test',
    last_name => 'Account',
    active => 1
};
$ua3->get("/login?username=test03&password=mypass");
$ua3->content_contains("Welcome to the Metadata Catalogue", "Test03 logged-in");
$ua3->get_ok("/users/add", "test03 allowed to request add user");
$ua3->content_contains("Editing User", "On user add/edit page");
$ua3->get("/users/list");
$ua3->content_lacks("Permission Denied", "test03 allowed users/list");
$ua3->get("/users/search?search=example");
$ua3->content_lacks("Permission Denied", "test03 allowed users/search");
$ua3->get("/users/id/3/edit");
$ua3->content_lacks("Permission Denied", "test03 allowed user/edit");
$ua3->get("/users/id/3/delete");
$ua3->content_contains("Can't delete own account", "test03 denied delete self");

done_testing();

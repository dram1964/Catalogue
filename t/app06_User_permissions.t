use strict;
use warnings;
use Test::More;
use_ok("Test::WWW::Mechanize::Catalyst" => "Catalogue");

my $welcome_msg = "Welcome to the ";
my $page_title = 'The Clinical Research Informatics Data Catalogue';

my $anon_ua = Test::WWW::Mechanize::Catalyst->new;
my $user = Test::WWW::Mechanize::Catalyst->new;
my $curator = Test::WWW::Mechanize::Catalyst->new;
my $admin = Test::WWW::Mechanize::Catalyst->new;
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
$anon_ua->get("/registration/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied registration/list");
$anon_ua->get("/datarequest/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied datarequest/list");
$anon_ua->get("/datarequest/request");
$anon_ua->content_contains("Please enter login details", "Anonymous denied datarequest/request");
$anon_ua->get("/tasks/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied tasks/list");
$anon_ua->get("/users/list");
$anon_ua->content_contains("Please enter login details", "Anonymous denied users/list");
$anon_ua->get("registration/ng_new");
$anon_ua->content_contains("First Name", "Anonymous allowed registration/ng_new");



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

done_testing();

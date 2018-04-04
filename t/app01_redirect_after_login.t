use strict;
use warnings;
use Test::More;

BEGIN { use_ok( "Test::WWW::Mechanize::Catalyst" => "Catalogue" ) }

my $ua1         = Test::WWW::Mechanize::Catalyst->new;
my $ua2         = Test::WWW::Mechanize::Catalyst->new;
my $welcome_msg = "Welcome to the ";
my $page_title = "BRC Clinical Research Informatics Unit";

$_->get_ok( "/", "Request root page" ) for $ua1, $ua2;
$_->title_is( $page_title, "Check for Welcome page title" ) for $ua1, $ua2;

$ua1->get_ok( "/login?username=test01&password=mypass", "Login test01" );
$ua2->get_ok( "/login?username=test04&password=mypass", "Login test04" );
$_->content_contains( $welcome_msg, "Welcome Page displayed after login" )
  for $ua1, $ua2;

$_->get_ok( "/login", "Return to '/login'" ) for $ua1, $ua2;
$_->title_is( "Metadata Catalogue Login", "Check for login title" )
  for $ua1, $ua2;
$_->content_contains("Username") for $ua1, $ua2;
$_->content_contains("Password") for $ua1, $ua2;
$_->content_contains( "Logout", "Logout link available" ) for $ua1, $ua2;
$_->content_contains( "Already logged-in", "Already logged-in message" )
  for $ua1, $ua2;

$_->get_ok( "/logout", "Logout via URL" ) for $ua1, $ua2;
$_->content_contains( $welcome_msg, "Welcome Page displayed after logout" )
  for $ua1, $ua2;

$ua2->get_ok( "/databases/list", "Request /databases/list for empty user" );
$ua2->content_contains( "You need to logon",
    "Redirect to Login for empty user" );
$ua2->get_ok( "/login?username=test04&password=mypass",
    "Log back in for test04" );
$ua2->content_contains(
    "Showing Databases for all Systems",
    "Redirect to /databases/list after login"
);

$ua2->get_ok('/logout');
$ua2->get_ok( "/applications/list",
    "Request /applications/list for empty user" );
$ua2->content_contains( "You need to logon",
    "Redirect to Login for empty user" );
$ua2->get_ok( "/login?username=test04&password=mypass",
    "Log back in for test04" );
$ua2->content_contains(
    "List of all Applications on the Metadata Catalogue",
    "Redirect to /applications/list after login"
);

$ua2->get_ok('/logout');
$ua2->get_ok( "/schemas/list", "Request /schemas/list for empty user" );
$ua2->content_contains( "You need to logon",
    "Redirect to Login for empty user" );
$ua2->get_ok( "/login?username=test04&password=mypass",
    "Log back in for test04" );
$ua2->content_contains(
    "Showing Schemas for all Databases",
    "Redirect to /schemas/list after login"
);

$ua2->get_ok('/logout');
$ua2->get_ok( "/tables/list", "Request /tables/list for empty user" );
$ua2->content_contains( "You need to logon",
    "Redirect to Login for empty user" );
$ua2->get_ok( "/login?username=test04&password=mypass",
    "Log back in for test04" );
$ua2->content_contains( "Tables for all schemas",
    "Redirect to /tables/list after login" );

$ua2->get_ok('/logout');
$ua2->get_ok( "/columns/list", "Request /columns/list for empty user" );
$ua2->content_contains( "You need to logon",
    "Redirect to Login for empty user" );
$ua2->get_ok( "/login?username=test04&password=mypass",
    "Log back in for test04" );
$ua2->content_contains( "Columns for all tables",
    "Redirect to /columns/list after login" );

$ua2->get_ok('/logout');
$ua2->get_ok( "/datasets/list", "Request /datasets/list for empty user" );
$ua2->content_lacks( "You need to logon",
    "No login redirect for datasets list" );
$ua2->content_contains( "list of datasets available",
    "Datasets list page displayed" );

done_testing;

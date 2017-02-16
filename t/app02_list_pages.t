use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst "Catalogue";

my $ua1 = Test::WWW::Mechanize::Catalyst->new;
my $ua2 = Test::WWW::Mechanize::Catalyst->new;

$ua1->get_ok("http://localhost/login?username=test01&password=mypass", "Login for ua1");
$ua2->get_ok("http://localhost/login?username=test01&password=mypass", "Login for ua2");
$_->title_is("The Metadata Catalogue", "Check for login/index title") for $ua1, $ua2;

$ua1->get_ok("http://localhost/systems/list", "'test01' systems list");
$ua1->content_contains("List of all Systems on the Metadata Catalogue", 
	"Check Systems List content");
$ua1->content_contains("Systems</a>", "Check Systems list has link for Systems");
$ua1->content_lacks("delete</a>", "Check Systems list has no delete link");

$ua1->get_ok("http://localhost/databases/list", "'test01' databases list");
$ua1->content_contains("Showing Databases for all Systems", 
	"Check Databases List content");
$ua1->content_contains("Systems</a>", "Check Database list has link for Systems");

$ua1->get_ok("http://localhost/schemas/list", "'test01' schemas list");
$ua1->content_contains("Showing Schemas for all Databases", 
	"Check Schemas List content");
$ua1->content_contains("Systems</a>", "Check Schemas list has link for Systems");

$ua1->get_ok("http://localhost/tables/list", "'test01' tables list");
$ua1->content_contains("Tables for all schemas",
	"Check Tables List content");
$ua1->content_contains("Systems</a>", "Check Tables list has link for Systems");

$ua1->get_ok("http://localhost/columns/list", "'test01' columns list");
$ua1->title_is("Table Columns",
	"Check Columns List title");
$ua1->content_contains("Systems</a>", "Check Columns list has link for Systems");

$ua1->get_ok("http://localhost/classes/list", "'test01' classes list");
$ua1->title_is("System Classifications", "Check System Classes title");

$ua1->get_ok("http://localhost/tasks/list", "'test01' tasks list");
$ua1->title_is("Project Task List", "Check Task List title");

$ua1->get_ok("http://localhost/systems/list", "Return to systems list");
my @schema_links;

# use 'diag $ua1->content' to see content of current response

done_testing;

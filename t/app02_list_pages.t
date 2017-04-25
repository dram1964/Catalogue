use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst "Catalogue";

my $ua1 = Test::WWW::Mechanize::Catalyst->new;
my $ua2 = Test::WWW::Mechanize::Catalyst->new;

$ua1->get_ok("/login?username=test01&password=mypass", "Login for ua1");
$ua2->get_ok("/login?username=test01&password=mypass", "Login for ua2");
$_->title_is("The Metadata Catalogue", "Check for login/index title") for $ua1, $ua2;


$ua1->get_ok("/databases/list", "'test01' databases list");
$ua1->title_is('System Databases', "test01 databases list title");
$ua1->content_contains("Showing Databases for all Systems", 
	"Check Databases List content");
$ua1->content_contains("Systems</a>", "Check Database list has link for Systems");
$ua1->content_lacks("delete</a>", "Check Database list has no delete link");

$ua1->get_ok("/applications/list", "'test01' applications list");
$ua1->title_is('Application List', "test01 applications list title");
$ua1->content_contains("List of all Applications on the Metadata Catalogue", 
	"Check Applications List content");
$ua1->content_contains("Systems</a>", "Check Applications list has link for Systems");
$ua1->content_lacks("delete</a>", "Check Applications list has no delete link");

$ua1->get_ok("/schemas/list", "'test01' schemas list");
$ua1->title_is('Database Schemas', "test01 schemas list title");
$ua1->content_contains("Showing Schemas for all Databases", 
	"Check Schemas List content");
$ua1->content_contains("Systems</a>", "Check Schemas list has link for Systems");
$ua1->content_lacks("delete</a>", "Check Schemas list has no delete link");

$ua1->get_ok("/tables/list", "'test01' tables list");
$ua1->title_is('Database Tables', "test01 tables list title");
$ua1->content_contains("Tables for all schemas", "Check Tables List content");
$ua1->content_contains("Systems</a>", "Check Tables list has link for Systems");
$ua1->content_lacks("delete</a>", "Check Tables list has no delete link");

$ua1->get_ok("/columns/list", "'test01' columns list");
$ua1->title_is('Table Columns', "test01 columns list title");
$ua1->content_contains("Columns for all tables", "Check Columns List content");
$ua1->content_contains("Systems</a>", "Check Columns list has link for Systems");
$ua1->content_lacks("delete</a>", "Check Columns list has no delete link");

$ua1->get_ok("/tasks/list", "'test01' tasks list");
$ua1->title_is("Project Task List", "Check Task List title");


# use 'diag $ua1->content' to see content of current response

done_testing;

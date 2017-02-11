use strict;
use warnings;
use Test::More;

BEGIN { use_ok("Test::WWW::Mechanize::Catalyst" => "Catalogue") }

my $ua1 = Test::WWW::Mechanize::Catalyst->new;
my $ua2 = Test::WWW::Mechanize::Catalyst->new;

$_->get_ok("http://localhost/", "Check redirect of base URL") for $ua1, $ua2;
$_->title_is("Metadata Catalogue Login", "Check for login title") for $ua1, $ua2;
$_->content_contains("You need to login to use this application", 
	"Check we are NOT logged in") for $ua1, $ua2;

$ua1->get_ok("http://localhost/login?username=test01&password=mypass", "Login test01");
$ua2->submit_form( 
    fields => {
	username => 'test02',
	password => 'mypass',
});

$_->get_ok("http://localhost/login", "Return to '/login'") for $ua1, $ua2;
$_->title_is("Metadata Catalogue Login", "Check for login title") for $ua1, $ua2;
$_->content_contains("Logged in as: ", 
	"Check we are ARE logged in") for $ua1, $ua2;

$_->follow_link_ok({n => 2}, "Logout via first link on page") for $ua1, $ua2;
$_->title_is("Metadata Catalogue Login", "Check for redirect to Login page") for $ua1, $ua2;

$ua1->get_ok("http://localhost/login?username=test01&password=mypass", "Log back in for ua1");
$ua2->get_ok("http://localhost/login?username=test01&password=mypass", "Log back in for ua2");
$_->title_is("The Metadata Catalogue", "Check for login/index title") for $ua1, $ua2;

done_testing;

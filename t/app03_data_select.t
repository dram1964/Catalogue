#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst "Catalogue";


plan skip_all => 'set MYAPP_DSN to enable this test' unless ($ENV{MYAPP_DSN});

ok($ENV{MYAPP_DSN}, "dsn configured");
my $mech = Test::WWW::Mechanize::Catalyst->new;

$mech->get_ok("http://localhost/login?username=test01&password=mypass", 
	"Login test01");
$mech->get_ok("http://localhost:3000/databases/list_databases/1", 
    "Select database_id = 1");

done_testing;

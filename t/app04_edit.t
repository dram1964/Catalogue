#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst "Catalogue";

SKIP : {
	skip "Need to reinsert data to database for these tests to work", 1;

	my $test01 = Test::WWW::Mechanize::Catalyst->new;
	my $test02 = Test::WWW::Mechanize::Catalyst->new;
	my $test03 = Test::WWW::Mechanize::Catalyst->new;

	$test01->get_ok("/login?username=test01&password=mypass", 
		"Login test01");
	$test02->get_ok("/login?username=test02&password=mypass", 
		"Login test01");
	$test03->get_ok("/login?username=test03&password=mypass", 
		"Login test01");

	$test01->get_ok("/databases/id/8/1/edit_description", 
		"test01 request to database edit description");
	$test01->content_contains('Permission Denied', 
		"test01 Denied database edit description");
	$test01->content_lacks('Edit Database Description', 
		"test01 Not allowed database edit description");

	$test02->get_ok("/databases/id/8/1/edit_description", 
		"test02 request to database edit description");
	$test02->content_contains('Edit Database Description', 
		"test02 Allowed database edit description");
	$test02->content_lacks('Permission Denied', 
		"test02 Edit database description not denied ");

	$test03->get_ok("/databases/id/8/1/edit_description", 
		"test03 request to database edit description");
	$test03->content_contains('Edit Database Description', 
		"test03 Allowed database edit description");
	$test03->content_lacks('Permission Denied', 
		"test03 Edit database description not denied");

	$test01->get_ok("/databases/id/8/1/edit_current", 
		"test01 request to database edit current");
	$test01->content_contains('Permission Denied', 
		"test01 Denied database edit current");
	$test01->content_lacks('Edit Database Description', 
		"test01 Not allowed database edit current");

	$test01->get_ok("/datasets/id/1/edit", 
		"test01 request to datasets edit");
	$test01->content_contains('Permission Denied', 
		"test01 Denied datasets edit");

	$test02->get_ok("/datasets/id/1/edit", 
		"test02 request to datasets edit");
	$test02->content_contains('Editing Description for', 
		"test02 Allowed datasets edit");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied datasets edit");

	$test01->get_ok("/schemas/id/13/8/edit_current", 
		"test01 request to schemas edit current");
	$test01->content_contains('Permission Denied', 
		"test01 Denied schemas edit current");

	$test02->get_ok("/schemas/id/13/8/edit_current", 
		"test02 request to schemas edit current");
	$test02->content_contains('Editing Description for', 
		"test02 Allowed schemas edit current");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied schemas edit current");

	$test01->get_ok("/schemas/id/13/8/edit_description", 
		"test01 request to schemas edit description");
	$test01->content_contains('Permission Denied', 
		"test01 Denied schemas edit description");

	$test02->get_ok("/schemas/id/13/8/edit_description", 
		"test02 request to schemas edit description");
	$test02->content_contains('Editing Description for', 
		"test02 Allowed schemas edit description");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied schemas edit description");

	$test01->get_ok("/systems/id/2/edit", 
		"test01 request to systems edit");
	$test01->content_contains('Permission Denied', 
		"test01 Denied systems edit");

	$test02->get_ok("/systems/id/2/edit", 
		"test02 request to systems edit");
	$test02->content_contains('System Name', 
		"test02 Allowed systems edit");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied systems edit");

	$test01->get_ok("/tables/id/38/edit_current", 
		"test01 request to tables edit current");
	$test01->content_contains('Permission Denied', 
		"test01 Denied tables edit current");

	$test02->get_ok("/tables/id/38/edit_current", 
		"test02 request to tables edit current");
	$test02->content_contains('Editing Description for', 
		"test02 Allowed tables edit current");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied tables edit current");

	$test01->get_ok("/tables/id/38/edit_description", 
		"test01 request to tables edit_description");
	$test01->content_contains('Permission Denied', 
		"test01 Denied tables edit_description");

	$test02->get_ok("/tables/id/38/edit_description", 
		"test02 request to tables edit description");
	$test02->content_contains('Editing Description for', 
		"test02 Allowed tables edit description");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied tables edit description");

	$test01->get_ok("/tasks/id/9/edit", 
		"test01 request to tasks edit");
	$test01->content_contains('Permission Denied', 
		"test01 Denied task edit");

	$test02->get_ok("/tasks/id/9/edit", 
		"test02 request to tasks edit");
	$test02->content_contains('Task', 
		"test02 Allowed task edit");
	$test02->content_lacks('Permission Denied', 
		"test02 Not denied task edit");

	$test01->get_ok("/datasets/id/2/edit", 
		"test01 request to datasets edit");
	$test01->content_contains('Permission Denied', 
		"test01 Denied datasets edit");

	$test02->get_ok("/datasets/id/2/edit", 
		"test02 request to datasets edit");
	$test02->content_contains('Dataset Name', 
		"test02 Allowed datasets edit");

	$test03->get_ok("/datasets/id/2/edit", 
		"test03 request to datasets edit");
	$test03->content_contains('Dataset Name', 
		"test03 Allowed datasets edit");

	$test01->get_ok("/users/id/2/edit", 
		"test01 request to users edit");
	$test01->content_contains('Permission Denied', 
		"test01 Denied users edit");

	$test02->get_ok("/users/id/2/edit", 
		"test02 request to users edit");
	$test02->content_contains('Permission Denied', 
		"test02 Denied users edit");

	$test03->get_ok("/users/id/2/edit", 
		"test03 request to users edit");
	$test03->content_contains('Editing User', 
		"test03 Allowed users edit");
	}

done_testing;

use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Systems;

ok( request('/systems')->is_redirect, 'Request should succeed' );
done_testing();

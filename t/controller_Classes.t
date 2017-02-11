use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Classes;

ok( request('/classes')->is_redirect, 'Request should succeed' );
done_testing();

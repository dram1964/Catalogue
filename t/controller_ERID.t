use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::ERID;

ok( request('/erid')->is_success, 'Request should succeed' );
done_testing();

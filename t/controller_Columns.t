use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Columns;

ok( request('/columns')->is_success, 'Request should succeed' );
done_testing();

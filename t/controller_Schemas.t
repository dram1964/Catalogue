use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Schemas;

ok( request('/schemas')->is_success, 'Request should succeed' );
done_testing();

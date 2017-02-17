use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Supplier;

ok( request('/supplier')->is_success, 'Request should succeed' );
done_testing();

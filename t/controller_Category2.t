use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Category2;

ok( request('/category2')->is_success, 'Request should succeed' );
done_testing();

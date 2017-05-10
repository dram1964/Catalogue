use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::DataRequest;

ok( request('/datarequest')->is_success, 'Request should succeed' );
done_testing();

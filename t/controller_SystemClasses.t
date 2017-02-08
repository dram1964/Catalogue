use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::SystemClasses;

ok( request('/systemclasses')->is_success, 'Request should succeed' );
done_testing();

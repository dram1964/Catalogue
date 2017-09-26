use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::IGAdmin;

ok( request('/igadmin')->is_success, 'Request should succeed' );
done_testing();

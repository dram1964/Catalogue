use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::KPE;

ok( request('/kpe')->is_success, 'Request should succeed' );
done_testing();

use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Schemas;

ok( request('/schemas')->is_redirect, 'Request should succeed' );
done_testing();

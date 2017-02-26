use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Datasets;

ok( request('/datasets')->is_redirect, 'Request should succeed' );
done_testing();

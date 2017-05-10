use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Winpath;

ok( request('/winpath')->is_redirect, 'Request should succeed' );
done_testing();

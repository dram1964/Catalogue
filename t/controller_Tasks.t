use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::Tasks;

ok( request('/todolist')->is_redirect, 'Request should succeed' );
done_testing();

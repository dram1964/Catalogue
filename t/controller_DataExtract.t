use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::DataExtract;

ok( request('/dataextract')->is_success, 'Request should succeed' );
done_testing();

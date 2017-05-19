use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalogue';
use Catalogue::Controller::DataReview;

ok( request('/datareview')->is_success, 'Request should succeed' );
done_testing();

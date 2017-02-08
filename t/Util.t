use strict;
use warnings;

use Catalogue::Util;
use Test::More qw/no_plan/;

ok(my $util = Catalogue::Util->new);
isa_ok($util, 'Catalogue::Util');

my @data = ('TestServer',  'Archive', 'Test Database Description', 
	'TestSchema', 'Test Description', 'TestTable', 
	'Test Table Description', 'TestColumn2', 'varchar', 
	'45', '', '', 7, '', '');
$util->load_data(@data);
cmp_ok($util->{data}->{system}, 'eq', $data[0], 'System Name');
cmp_ok($util->{data}->{database}->{name}, 'eq', $data[1], 'Database Name');
cmp_ok($util->{data}->{database}->{description}, 'eq', $data[2], 'Database Description');
ok($util->add_catalogue);

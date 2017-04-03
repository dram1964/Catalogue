use strict;
use warnings;
use Test::More;
use Catalogue::Schema;

my $dsn = "dbi:mysql:catalogue_test";
my $schema = Catalogue::Schema->connect($dsn, 'tutorial', 'thispassword');

plan skip_all => 'set MYAPP_DSN to enable this test' 
	unless ($ENV{MYAPP_DSN} eq $dsn);

my $account01_details = {
	username => "testaccount01",
	password => 'mypassword',
	email_address => 'test@example.com',
	first_name => 'Test',
	last_name => 'Account',
        active => 1,
};

ok(my $user01_rs = $schema->resultset('User'), 'User ResultSet Requested');
isa_ok($user01_rs, 'DBIx::Class::ResultSet', 'ResultSet Type');
ok(my $user01 = $user01_rs->create($account01_details), 'User Create Requested');
isa_ok($user01, 'Catalogue::Schema::Result::User', 'User Object Type');
ok($user01->delete, 'User ' . $user01->username . ' Deleted');

my $account02_details = {
	username => "testaccount02",
	password => 'mypassword',
	email_address => 'test@example.com',
	first_name => 'Test',
	last_name => 'Account',
        active => 1,
	user_roles => [{role_id => 1}, {role_id => 2}, {role_id => 3}],
};

my $user02_rs = $schema->resultset('User');
ok(my $user02 = $user02_rs->create($account02_details), 'User Create with user_roles Requested');
ok($user02->has_role('curator'), 'User has curator Role');
ok($user02->has_role('admin'), 'User has admin Role');
ok($user02->has_role('user'), 'User has user Role');
ok($user02->delete, 'User ' . $user02->username . ' Deleted');

done_testing();

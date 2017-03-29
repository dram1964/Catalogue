use strict;
use warnings;

use Catalogue::Schema;

my $schema = Catalogue::Schema->connect('dbi:mysql:catalogue', 'tutorial', 'thispassword');

my @users = $schema->resultset('User')->all;

foreach my $user (@users) {
  $user->password('mypass');
  $user->update;
}

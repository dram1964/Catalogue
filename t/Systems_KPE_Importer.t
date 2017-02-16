use Test::More tests => 14;
use Catalogue::Systems::Importer;

#plan skip_all => 'set MYAPP_DSN to enable this test' unless ($ENV{MYAPP_DSN});

my $system7 = Catalogue::Systems::Importer->new(
	kpe => 'CDR',
	erid => 'Core',
	category2 => 'Core Clinical',
	supplier => 'CGI',
	application => 'CDR Web',
	application_desc => 'ablaskj'
);
ok($system7->kpe, 'KPE Accessor');
cmp_ok($system7->kpe, 'eq', 'CDR', "KPE Value");
ok($system7->erid, 'ERID Accessor');
cmp_ok($system7->erid, 'eq', 'Core', 'ERID Value');
ok($system7->category2, 'Category2 Accessor');
cmp_ok($system7->category2, 'eq', 'Core Clinical', 'Category2 Value');
ok($system7->supplier, 'Supplier Accessor');
cmp_ok($system7->supplier, 'eq', 'CGI', 'Supplier Value');
ok($system7->application, 'Application Accessor');
cmp_ok($system7->application, 'eq', 'CDR Web', 'Application Value');
ok($system7->application_desc, 'Application Description Accessor');
cmp_ok($system7->application_desc, 'eq', 'ablaskj', 'Application Description Value');
ok($system7->add_or_update_kpe, "Can insert System Application");

ok(!$system7->error_msg, "No Error Message Set");

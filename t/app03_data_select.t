#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst "Catalogue";


plan skip_all => 'set MYAPP_DSN to enable this test' unless ($ENV{MYAPP_DSN});

ok($ENV{MYAPP_DSN}, "dsn configured");
my $mech = Test::WWW::Mechanize::Catalyst->new;

$mech->get_ok("http://localhost/login?username=test01&password=mypass", 
	"Login test01");
$mech->get_ok("http://localhost:3000/databases/list_databases/1", 
    "Select databases for system_id = 1");
$mech->content_contains('HIC', "System 1: HIC database found");
$mech->content_contains('Pathreports', "System 1: Pathreports database found");
$mech->content_contains('CyresCytology', "System 1: CyresCytology database found");
$mech->content_lacks('Aardvark', "System 1: Aardvark database not found");
$mech->content_lacks('DBName', "System 1: DBName database not found");

$mech->get_ok("http://localhost:3000/databases/list_databases/14", 
    "Select databases for system_id = 14");
$mech->content_contains('DBName', "System 14: DBName database found");
$mech->content_lacks('HIC', "System 14: HIC database not found");
$mech->content_lacks('Pathreports', "System 14: Pathreports database not found");
$mech->content_lacks('CyresCytology', "System 14: CyresCytology database not found");
$mech->content_lacks('Aardvark', "System 14: Aardvark database not found");

$mech->get_ok("http://localhost:3000/schemas/list/8", 
	"Select schemas for database_id = 8");
$mech->content_contains("ACS", "DB 8: ACS Schema found");
$mech->content_contains("VH", "DB 8: VH Schema found");
$mech->content_contains("OVC", "DB 8: OVC Schema found");
$mech->content_lacks("HCA", "DB 8: HCA Schema not found");
$mech->content_lacks("BankManager", "DB 8: BankManager Schema not found");
$mech->content_lacks("Winpath", "DB 8: Winpath Schema not found");
$mech->content_lacks("Copath", "DB 8: Copath Schema not found");
$mech->content_lacks("ESKD", "DB 8: ESKD Schema not found");

$mech->get_ok("http://localhost:3000/schemas/list/9", 
	"Select schemas for database_id = 9");
$mech->content_lacks("ACS", "DB 9: ACS Schema not found");
$mech->content_lacks("VH", "DB 9: VH Schema not found");
$mech->content_lacks("OVC", "DB 9: OVC Schema not found");
$mech->content_contains("HCA", "DB 9: HCA Schema found");
$mech->content_contains("BankManager", "DB 9: BankManager Schema found");
$mech->content_contains("Winpath", "DB 9: Winpath Schema found");
$mech->content_contains("Copath", "DB 9: Copath Schema found");
$mech->content_contains("ESKD", "DB 9: ESKD Schema found");

$mech->get_ok("http://localhost:3000/tables/list_tables/17",
	"Select tables for schema_id = 17");
$mech->content_contains("PCTCodes", "Schema 17: PCTCodes table found");
$mech->content_contains("GPNationalCodes", "Schema 17: GPNationalCodes table found");
$mech->content_contains("sysdiagrams", "Schema 17: sysdiagrams table found");
$mech->content_contains("patlist", "Schema 17: patlist table found");
$mech->content_lacks("GFRPatients", "Schema 17: GFRPatients table not found");
$mech->content_lacks("GFRresults", "Schema 17: GFRresults table not found");
$mech->content_lacks("GFRresults_temp", "Schema 17: GFRresults_temp table not found");

$mech->get_ok("http://localhost:3000/tables/list_tables/24",
	"Select tables for schema_id = 24");
$mech->content_lacks("PCTCodes", "Schema 24: PCTCodes table not found");
$mech->content_lacks("GPNationalCodes", "Schema 24: GPNationalCodes table not found");
$mech->content_lacks("sysdiagrams", "Schema 24: sysdiagrams table not found");
$mech->content_lacks("patlist", "Schema 24: patlist table not found");
$mech->content_contains("GFRPatients", "Schema 24: GFRPatients table found");
$mech->content_contains("GFRresults", "Schema 24: GFRresults table found");
$mech->content_contains("GFRresults_temp", "Schema 24: GFRresults_temp table found");

$mech->get_ok("http://localhost:3000/columns/list_columns/145",
	"Select columns for table_id = 145");
$mech->content_contains("ptnumber", "Table 145: ptnumber column found");
$mech->content_contains("reported", "Table 145: reported column found");
$mech->content_lacks("deid_ptnumber", "Table 145: deid_ptnumber column found");

$mech->get_ok("http://localhost:3000/columns/list_columns/44",
	"Select columns for table_id = 44");
$mech->content_contains("ptnumber", "Table 44: ptnumber column found");
$mech->content_contains("deid_ptnumber", "Table 44: deid_ptnumber column found");
$mech->content_lacks("reported", "Table 44: reported column not found");
done_testing;

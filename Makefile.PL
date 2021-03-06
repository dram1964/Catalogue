#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Catalogue';
all_from 'lib/Catalogue.pm';

requires 'Catalyst::Runtime' => '5.90114';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Authentication::Realm::SimpleDB';
requires 'Catalyst::Plugin::Authorization::Roles';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::File';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::StatusMessage';
requires 'Catalyst::View::TT';
requires 'Catalyst::View::Download';
requires 'Spreadsheet::XLSX';
requires 'Text::Iconv';
requires 'HTML::FormFu';
requires 'Catalyst::Controller::HTML::FormFu';
requires 'HTML::FormFu::Model::DBIC';
requires 'Moose';
requires 'MooseX::NonMoose';
requires 'DBD::mysql';
requires 'DBD::SQLite';
requires 'DBIx::Class::Schema::Loader';
requires 'DBIx::Class::TimeStamp';
requires 'DBIx::Class::PassphraseColumn';
requires 'namespace::autoclean';
requires 'DateTime::Format::MySQL';
requires 'Config::General'; # This should reflect the config file format you've chosen
requires 'Perl6::Junction';
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Template::Plugin::JSON';
requires 'DBIx::Class::Timestamp';
test_requires 'Test::More' => '0.88';
test_requires 'Test::Pod';
test_requires 'Test::Pod::Coverage';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;

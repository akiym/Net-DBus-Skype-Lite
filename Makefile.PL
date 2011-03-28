use inc::Module::Install;
use Module::Install::Repository;
use Module::Install::AuthorTests;

all_from 'lib/Net/DBus/Skype/Lite.pm';
license 'perl';

requires(
    'Net::DBus' => '0.33.6',
    'Class::Trigger' => '0.14',
);

tests 't/*.t';
recursive_author_tests('xt');
auto_include;
auto_set_repository;

WriteAll;

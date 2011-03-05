use inc::Module::Install;
use Module::Install::Repository;
use Module::Install::AuthorTests;

all_from 'lib/Net/DBus/Skype/Lite.pm';
license 'perl';

requires(
    'Net::DBus::Skype' => 0.02,
);

tests 't/*.t';
recursive_author_tests('xt');
auto_include;
auto_set_repository;

WriteAll;

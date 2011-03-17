use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Skype::Lite;
use Net::DBus::Reactor;

my $skype = Net::DBus::Skype::Lite->new;

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

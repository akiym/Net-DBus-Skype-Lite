use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Reactor;
use Net::DBus::Skype::Lite;
use Log::Minimal;

my $skype = Net::DBus::Skype::Lite->new();
$skype->user(sub {
    my ($user) = @_;
    if ($user->{property} eq 'ONLINESTATUS' && $user->{value} eq 'ONLINE') {
        infof($user->{id});
        $user->send_message('こんにちワン');
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

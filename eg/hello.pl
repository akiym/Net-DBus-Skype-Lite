use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Reactor;
use Net::DBus::Skype::Lite;
use Log::Minimal;

my $skype = Net::DBus::Skype::Lite->new();
$skype->user(
    onlinestatus => sub {
        my ($user, $onlinestatus) = @_;
        if ($onlinestatus eq 'ONLINE') {
            infof($user->handle);
            $user->send_message('こんにちワン');
        }
    }
);

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

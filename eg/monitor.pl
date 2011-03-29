use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Skype::Lite;
use Net::DBus::Reactor;
use Log::Minimal;

my $skype = Net::DBus::Skype::Lite->new(
    notify => sub { debugf("NOTIFY: $_[1]") },
    invoke => sub { debugf("INVOKE: $_[1]") },
);
$skype->message_received(sub {
    my ($msg) = @_;
    my $dispname = $msg->from_dispname;
    my $body = $msg->body;
    infof("$dispname: $body");
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

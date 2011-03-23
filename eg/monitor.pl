use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Skype::Lite;
use Net::DBus::Reactor;
use Log::Minimal;

my $skype = Net::DBus::Skype::Lite->new;
$skype->trigger(sub {
    my ($self, $res, $notify) = @_;
    debugf($notify);
    if (my $msg = $res->chatmessage) {
        if ($msg->status eq 'RECEIVED') {
            my $dispname = $msg->from_dispname;
            my $body = $msg->body;
            infof("$dispname: $body");
        }
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

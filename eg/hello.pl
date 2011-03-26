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
    my ($self, $res) = @_;
    if ($res->{property} eq 'ONLINESTATUS' && $res->{value} eq 'ONLINE') {
        infof($res->{id});
        $self->create_chat($res->{id})->send_message('こんにちワン');
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

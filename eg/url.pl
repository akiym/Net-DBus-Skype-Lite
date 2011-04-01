use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Reactor;
use Net::DBus::Skype::Lite;
use Encode;
use Encode::Guess qw/euc-jp shiftjis iso-2022-jp/;
use LWP::UserAgent;
use Log::Minimal;

my $ua = LWP::UserAgent->new();

my $skype = Net::DBus::Skype::Lite->new();
$skype->message_received(sub {
    my ($msg) = @_;
    if (my ($url) = $msg->body =~ m{(https?://.+)}) {
        infof($url);
        my $res = $ua->get($url);
        my $title = decode('Guess', $res->header('title')) || 'no title';
        $msg->chat->send_message(encode_utf8($title));
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

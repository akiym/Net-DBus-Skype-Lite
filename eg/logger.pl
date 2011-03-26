use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Reactor;
use Net::DBus::Skype::Lite;
use File::HomeDir;
use Time::Piece;
use Log::Minimal;

my $log = File::Spec->catfile(File::HomeDir->my_home(), 'skype-log.txt');

my $skype = Net::DBus::Skype::Lite->new();
$skype->chatmessage(
    received => sub {
        my ($self, $msg) = @_;
        my $time = Time::Piece->new($msg->timestamp)->strftime('%y/%m/%d %T');
        my $message = sprintf "%s %s: %s", $time, $msg->from_dispname, $msg->body;
        infof($message);
        open my $fh, '>>', $log or return;
        print {$fh} "$message\n";
    }
);
$skype->chatmessage(sub {
    my ($self, $msg) = @_;
    if ($msg->{property} eq 'EDITED_TIMESTAMP') {
        my $time = Time::Piece->new($msg->edited_timestamp)->strftime('%y/%m/%d %T');
        my $message = sprintf "[EDITED] %s %s: %s (%s)", $time, $msg->from_dispname, $msg->body, $msg->edited_by;
        infof($message);
        open my $fh, '>>', $log or return;
        print {$fh} "$message\n";
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

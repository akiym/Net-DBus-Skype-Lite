use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Reactor;
use Net::DBus::Skype::Lite;
use File::Temp qw/tempfile/;
use Log::Minimal;

my $skype = Net::DBus::Skype::Lite->new();
$skype->call(
    status => sub {
        my ($call, $status) = @_;
        if ($status eq 'INPROGRESS') {
            my $id = $call->{id};
            my ($fh, $file) = tempfile(SUFFIX => '.wav');
            infof("log: $file");
            $skype->api(qq{ALTER CALL $id SET_OUTPUT file="$file"});
        } elsif ($status eq 'FINISHED') {
            infof('recorded...');
        }
    },
);

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

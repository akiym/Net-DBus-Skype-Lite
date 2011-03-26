use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Reactor;
use Net::DBus::Skype::Lite;
use LWP::UserAgent;
use XML::Simple;
use Log::Minimal;

my $ua = LWP::UserAgent->new();
sub get_info {
    my ($video_id) = @_;
    my $res = $ua->get("http://ext.nicovideo.jp/api/getthumbinfo/$video_id");
    my $info = XMLin($res->decoded_content);
    return unless $info->{status} eq 'ok';
    my $thumb = $info->{thumb};
    my $message = "$thumb->{title}\n$thumb->{description}";
}

my $skype = Net::DBus::Skype::Lite->new(
    notify => sub {
        my ($self, $notify) = @_;
        debugf($notify);
    }
);
$skype->chatmessage(received => sub {
    my ($self, $msg) = @_;
    if (my ($video_id) = $msg->body =~ /([sn]m\d+)/) {
        my $message = get_info($video_id);
        return unless $message;
        infof($msg->from_dispname . ': ' . $msg->body);
        if ($msg->body =~ /@俺/) {
            $self->create_chat($msg->from_handle)->send_message($message);
        } else {
            $self->send_message($msg->chatname, $message);
        }
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

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
    $info->{status} eq 'ok' ? $info : '';
}

my $skype = Net::DBus::Skype::Lite->new();
$skype->trigger(sub {
    my ($self, $res) = @_;
    if ($res->chatmessage) {
        debugf($res);
    }
});
$skype->message_received(sub {
    my ($self, $msg) = @_;
    if (my ($video_id) = $msg->body =~ /([sn]m\d+)/) {
        my $info = get_info($video_id);
        return unless $info;
        my $thumb = $info->{thumb};
        my $message = "$thumb->{title}\n$thumb->{description}";
        if ($msg->body =~ /@俺/) {
            my $id = $self->create_chat($msg->from_handle)->name;
            $self->send_message($id, $message);
        } else {
            $msg->chatname->send_message($message);
        }
    }
});

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

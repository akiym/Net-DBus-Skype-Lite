package Net::DBus::Skype::Lite::Chat;
use strict;
use warnings;
use Net::DBus::Skype::Lite;
use Log::Minimal;

sub new {
    my ($class, $self) = @_;

    bless { %$self }, $class;
}

sub send_message {
    my ($self, $message) = @_;

    # -> CHATMESSAGE <chat_id> <message>
    my $chat_id = $self->{chat_id};
    my $res = $self->{skype}->raw_skype(qq{CHATMESSAGE $chat_id $message});
    infof($res);

    # <- CHATMESSAGE <id> STATUS SENDING
    my ($id) = $res =~ /CHATMESSAGE\s+(.+)\s+STATUS\s+SENDING/;
    return unless defined $id;

    $id;
}

1;

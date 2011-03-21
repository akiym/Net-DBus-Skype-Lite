package Net::DBus::Skype::Lite::Command;
use strict;
use warnings;
use feature qw/switch/;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::ChatMessage;
use Log::Minimal;

sub parse {
    my ($class, $res) = @_;

    my ($command, $id, $property, $value) = split /\s+/, $res, 4;
    given ($command) {
        when ('CHATMESSAGE') {
            # TODO command('ChatMessage', $res);
            return Net::DBus::Skype::Lite::ChatMessage->new($res);
        }
        default {
            return $class;
        }
    }
}

sub chatmessage {}

1;

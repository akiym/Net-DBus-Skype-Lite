package Net::DBus::Skype::Lite::Command;
use strict;
use warnings;
use feature qw/switch/;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::ChatMessage;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

sub parse {
    my ($class, $res) = @_;

    my ($command, $id, $property, $value) = parse_res($res);
    given ($command) {
        when ('CHATMESSAGE') {
            return cmd_object('ChatMessage', $res);
        }
        default {
            return $class;
        }
    }
}

sub chatmessage {}

1;

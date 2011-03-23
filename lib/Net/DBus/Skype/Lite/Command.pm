package Net::DBus::Skype::Lite::Command;
use strict;
use warnings;
use feature qw/switch/;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Call;
use Net::DBus::Skype::Lite::ChatMessage;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

sub parse {
    my ($class, $res) = @_;

    my ($command, $id, $property, $value) = parse_res($res);
    given ($command) {
        when ('CALL') {
            my $cmd = cmd_object('Call', $id);
            my $call = $cmd->call;
            if ($call->status eq 'INPROGRESS') {
                return c->_call_inprogress($call);
            }
            return $call;
        }
        when ('CHATMESSAGE') {
            my $cmd = cmd_object('ChatMessage', $id);
            my $chatmessage = $cmd->chatmessage;
            if ($chatmessage->status eq 'RECEIVED') {
                return c->_message_received($chatmessage);
            }
            return $chatmessage;
        }
        default {
            return $class;
        }
    }
}

sub call {}
sub chatmessage {}

1;

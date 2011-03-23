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
            c->_trigger($cmd, $res); # NO
            my $call = $cmd->call;
            if ($call->status eq 'INPROGRESS') {
                return c->_call_inprogress($call);
            }
            return $cmd;
        }
        when ('CHATMESSAGE') {
            my $cmd = cmd_object('ChatMessage', $id);
            c->_trigger($cmd, $res); # NO
            my $chatmessage = $cmd->chatmessage;
            if ($chatmessage->status eq 'RECEIVED') {
                return c->_message_received($chatmessage);
            }
            return $cmd;
        }
        default {
            c->_trigger($class, $res); # NO
            return $class;
        }
    }
}

sub call {}
sub chatmessage {}

1;

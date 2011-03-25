package Net::DBus::Skype::Lite::Command;
use strict;
use warnings;
use feature qw/switch/;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::User;
use Net::DBus::Skype::Lite::Profile;
use Net::DBus::Skype::Lite::Call;
use Net::DBus::Skype::Lite::Chat;
use Net::DBus::Skype::Lite::ChatMember;
use Net::DBus::Skype::Lite::ChatMessage;
use Net::DBus::Skype::Lite::VoiceMail;
use Net::DBus::Skype::Lite::SMS;
#use Net::DBus::Skype::Lite::Application;
use Net::DBus::Skype::Lite::Group;
use Net::DBus::Skype::Lite::FileTransfer;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

sub parse {
    my ($class, $notification) = @_;

    my ($command, $id, $property, $value) = parse_res($notification);
    given ($command) {
        when ('CALL') {
            my $cmd = cmd_object('Call', $id);
            c->_trigger($cmd, $notification); # NO
            my $call = $cmd->call;
            if ($call->status eq 'INPROGRESS') {
                return c->_call_inprogress($call);
            }
            return $cmd;
        }
        when ('CHATMESSAGE') {
            my $cmd = cmd_object('ChatMessage', $id);
            c->_trigger($cmd, $notification); # NO
            my $chatmessage = $cmd->chatmessage;
            if ($chatmessage->status eq 'RECEIVED') {
                return c->_message_received($chatmessage);
            }
            return $cmd;
        }
        default {
            c->_trigger($class, $notification); # NO
            return $class;
        }
    }
}

1;

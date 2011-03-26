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
        when ('USER') {
            my $cmd = cmd_object('User', id => $id, property => $property, value => $value);
            c->{trigger}->(c, $cmd, $notification);
            if (ref(c->{user}) eq 'CODE') {
                c->{user}->(c, $cmd);
            }
            return $cmd;
        }
        when ('PROFILE') {
            my $cmd = cmd_object('Profile', property => $id, value => $property);
            c->{trigger}->(c, $cmd, $notification);
            if (ref(c->{profile}) eq 'CODE') {
                c->{profile}->(c, $cmd);
            }
            return $cmd;
        }
        when ('CALL') {
            my $cmd = cmd_object('Call', id => $id, property => $property, value => $value);
            c->{trigger}->(c, $cmd, $notification);
            if (ref(c->{call}) eq 'CODE') {
                c->{call}->(c, $cmd);
            }
            my $call = $cmd->call;
            if ($property eq 'STATUS') {
                if ($value eq 'INPROGRESS' && ref(c->{call_inprogress}) eq 'CODE') {
                    return c->{call_inprogress}->(c, $call);
                } elsif ($value eq 'FINISHED' && ref(c->{call_finished}) eq 'CODE') {
                    return c->{call_finished}->(c, $call);
                }
            }
            return $cmd;
        }
        when ('CHATMESSAGE') {
            my $cmd = cmd_object('ChatMessage', id => $id, property => $property, value => $value);
            c->{trigger}->(c, $cmd, $notification);
            if (ref(c->{chatmessage}) eq 'CODE') {
                c->{chatmessage}->(c, $cmd);
            }
            my $chatmessage = $cmd->chatmessage;
            if ($property eq 'STATUS') {
                if ($value eq 'RECEIVED' && ref(c->{chatmessage_received}) eq 'CODE') {
                    return c->{chatmessage_received}->(c, $chatmessage);
                }
            }
            return $cmd;
        }
        default {
            c->{trigger}->(c, $class, $notification);
            return $class;
        }
    }
}

1;

package Net::DBus::Skype::Lite::Command;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util;

use Net::DBus::Skype::Lite::User;
use Net::DBus::Skype::Lite::Profile;
use Net::DBus::Skype::Lite::Call;
use Net::DBus::Skype::Lite::Chat;
use Net::DBus::Skype::Lite::ChatMember;
use Net::DBus::Skype::Lite::ChatMessage;
#use Net::DBus::Skype::Lite::VoiceMail;
#use Net::DBus::Skype::Lite::SMS;
#use Net::DBus::Skype::Lite::Application;
use Net::DBus::Skype::Lite::Group;
use Net::DBus::Skype::Lite::FileTransfer;

sub parse {
    my ($class, $notification) = @_;

    my ($command, $id, $property, $value) = parse_notification($notification);
    if ($command eq 'USER') {
        my $user = object(
            'User',
            id => $id, property => $property, value => $value,
        );
        $user->call_trigger(user => $notification);
        if ($property eq 'ONLINESTATUS') {
            $user->call_trigger(onlinestatus => $value);
        }
        return $user;
    } elsif ($command eq 'PROFILE') {
        my $profile = object(
            'Profile',
            property => $id, value => $property,
        );
        $profile->call_trigger(profile => $notification);
        return $profile;
    } elsif ($command eq 'CALL') {
        my $call = object(
            'Call',
            id => $id, property => $property, value => $value,
        );
        $call->call_trigger(call => $notification);
        if ($property eq 'STATUS') {
            $call->call_trigger(status => $value);
        }
        return $call;
    } elsif ($command eq 'CHATMESSAGE') {
        my $chatmessage = object(
            'ChatMessage',
            id => $id, property => $property, value => $value,
        );
        $chatmessage->call_trigger(chatmessage => $notification);
        if ($property eq 'STATUS') {
            return $chatmessage->call_trigger(status => $value);
        }
        return $chatmessage;
    } else {
        return $class;
    }
}

1;

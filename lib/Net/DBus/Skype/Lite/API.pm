package Net::DBus::Skype::Lite::API;
use strict;
use warnings;
use parent qw/Net::DBus::Object/;
use Net::DBus;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Command;
use Class::Trigger;

sub new {
    my ($class) = @_;

    my $bus = Net::DBus->session();

    my $notify = $bus->export_service('com.Skype.API');
    my $self = $class->SUPER::new($notify, '/com/Skype/Client', 'com.Skype.API.Client');
    bless $self, $class;

    my $invoke = $bus->get_service('com.Skype.API');
    $self->{invoke} = $invoke->get_object('/com/Skype', 'com.Skype.API');

    my $application_name = c->{name};
    $self->Invoke(qq{NAME $application_name});
    $self->Invoke(qq{PROTOCOL 8});
    $self;
}

sub Notify {
    my ($self, $notification) = @_;

    $self->call_trigger(notify => $notification);
    Net::DBus::Skype::Lite::Command->parse($notification);
    return 0;
}

sub Invoke {
    my ($self, $notification) = @_;

    my $res = $self->{invoke}->Invoke($notification);
    $self->call_trigger(invoke => $notification, $res);
    $res;
}

1;

package Net::DBus::Skype::Lite::API;
use strict;
use warnings;
use parent qw/Net::DBus::Object/;
use Net::DBus;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Command;

sub new {
    my ($class) = @_;

    my $bus = Net::DBus->session();

    my $notify = $bus->export_service('com.Skype.API');
    my $self = $class->SUPER::new($notify, '/com/Skype/Client', 'com.Skype.API.Client');
    bless $self, $class;

    my $invoke = $bus->get_service('com.Skype.API');
    $self->{invoke} = $invoke->get_object('/com/Skype', 'com.Skype.API');
    $self->Invoke('NAME Net::DBus::Skype::Lite');
    $self->Invoke('PROTOCOL 7');

    $self;
}

sub Notify {
    my ($self, $notification) = @_;

    c->{notify}->(c, $notification);
    Net::DBus::Skype::Lite::Command->parse($notification);
    return 0;
}

sub Invoke {
    my ($self, $notification) = @_;

    my $res = $self->{invoke}->Invoke($notification);
    c->{invoke}->(c, $notification, $res);
    $res;
}

1;

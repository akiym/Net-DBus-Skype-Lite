package Net::DBus::Skype::Lite::API;
use strict;
use warnings;
use parent qw/Net::DBus::Object/;
use Net::DBus;
use Log::Minimal;

sub new {
    my ($class) = @_;

    my $bus = Net::DBus->session();

    my $notify = $bus->export_service('com.Skype.API');
    my $self = $class->SUPER::new($notify, '/com/Skype/Client', 'com.Skype.API.Client');
    bless $self, $class;

    $self->{invoke} = $bus->get_service('com.Skype.API')
                          ->get_object('/com/Skype', 'com.Skype.API');
    $self->Invoke('NAME Net::DBus::Skype::Lite');
    $self->Invoke('PROTOCOL 7');

    $self;
}

sub Notify {
    my ($self, $command) = @_;

    debugf("<- $command");
    return 0;
}

sub Invoke {
    my ($self, $command) = @_;

    debugf("-> $command");
    $self->{invoke}->Invoke($command);
}

1;

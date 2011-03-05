package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype;

sub new {
    my ($class, $args) = @_;
    $args ||= {};

    my $skype = Net::DBus::Skype->new($args);
    bless {
        skype => $skype,
    }, $class;
}

sub api { shift->{skype}->raw_skype(@_) }

1;

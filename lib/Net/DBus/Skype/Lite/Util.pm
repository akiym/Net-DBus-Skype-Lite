package Net::DBus::Skype::Lite::Util;
use strict;
use warnings;
use parent qw/Exporter/;
our @EXPORT = qw/parse_notification object/;
our @EXPORT_OK = qw/add_trigger/;

sub parse_notification {
    my ($notification, $limit) = @_;
    $limit = 4 unless defined $limit;

    my @notification = split /\s+/, $notification, $limit;
}

sub object {
    my ($command, %args) = @_;

    "Net::DBus::Skype::Lite::${command}"->new(
        id => $args{id},
        property => $args{property},
        value => $args{value},
    );
}

sub add_trigger {
    my ($command, %args) = @_;

    while (my ($property, $code) = each %args) {
        "Net::DBus::Skype::Lite::${command}"->add_trigger(
            $property => $code
        );
    }
}

1;

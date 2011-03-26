package Net::DBus::Skype::Lite::Util;
use strict;
use warnings;
use parent qw/Exporter/;
our @EXPORT = qw/parse_notification object/;

sub parse_notification {
    my ($notification, $limit) = @_;
    $limit //= 4;

    my @notification = split /\s+/, $notification, $limit;
}

sub object {
    my ($command, %args) = @_;

    "Net::DBus::Skype::Lite::$command"->new(
        id => $args{id},
        property => $args{property},
        value => $args{value},
    );
}

1;

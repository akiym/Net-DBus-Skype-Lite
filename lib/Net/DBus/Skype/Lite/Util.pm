package Net::DBus::Skype::Lite::Util;
use strict;
use warnings;
use parent qw/Exporter/;
our @EXPORT_OK = qw/parse_res cmd_object/;

sub parse_res {
    my ($res, $limit) = @_;
    $limit //= 4;

    my @res = split /\s+/, $res, $limit;
}

sub cmd_object {
    my ($command, $id, $property, $value) = @_;

    "Net::DBus::Skype::Lite::$command"->new(
        id => $id,
        property => $property,
        value => $value,
    );
}

1;

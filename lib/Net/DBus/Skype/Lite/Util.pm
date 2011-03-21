package Net::DBus::Skype::Lite::Util;
use strict;
use warnings;
use parent qw/Exporter/;
our @EXPORT_OK = qw/parse_res cmd_object/;

sub parse_res {
    my ($res) = @_;

    my @res = split /\s+/, $res, 4;
}

sub cmd_object {
    my ($command, $res) = @_;

    "Net::DBus::Skype::Lite::$command"->new($res);
}

1;

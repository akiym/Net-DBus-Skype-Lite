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
    my ($command, %args) = @_;

    "Net::DBus::Skype::Lite::$command"->new(
        id => $args{id},
        property => $args{property},
        value => $args{value},
    );
}

1;

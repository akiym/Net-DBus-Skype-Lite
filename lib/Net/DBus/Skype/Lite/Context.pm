package Net::DBus::Skype::Lite::Context;
use strict;
use warnings;
use parent qw/Exporter/;
our @EXPORT = qw/c/;

*c = *Net::DBus::Skype::Lite::context;

1;


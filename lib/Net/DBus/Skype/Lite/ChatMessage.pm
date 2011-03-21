package Net::DBus::Skype::Lite::ChatMessage;
use strict;
use warnings;
use overload qw/""/ => sub { shift->{res} };
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res/;
use Log::Minimal;

sub new {
    my ($class, $res) = @_;

    bless {
        res => $res,
    }, $class;
}

sub chatmessage {
    my ($self) = @_;

    my @res = parse_res($self->{res});
    $self->{command} = $res[0];
    $self->{id} = $res[1];
    $self->{property} = $res[2];
    $self->{value} = $res[3];

    $self;
}

sub status {
    my ($self) = @_;

    $self->{property} eq 'STATUS' ? $self->{value} : '';
}

sub from_dispname {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id FROM_DISPNAME});
    my $dispname = (parse_res($res))[3];
}

sub chatname {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id CHATNAME});
    my $body = (parse_res($res))[3];
}

sub body {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id BODY});
    my $body = (parse_res($res))[3];
}

1;

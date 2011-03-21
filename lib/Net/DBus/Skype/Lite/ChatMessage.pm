package Net::DBus::Skype::Lite::ChatMessage;
use strict;
use warnings;
use overload qw/""/ => sub { shift->{res} };
use Net::DBus::Skype::Lite::Context;
use Log::Minimal;

sub new {
    my ($class, $res) = @_;

    bless {
        res => $res,
    }, $class;
}

sub chatmessage {
    my ($self) = @_;

    my @res = $self->parse($self->{res});
    $self->{command} = $res[0];
    $self->{id} = $res[1];
    $self->{property} = $res[2];
    $self->{value} = $res[3];

    $self;
}

sub parse {
    my ($self, $res) = @_;

    my @res = split /\s+/, $res, 4;
}

sub from_dispname {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id FROM_DISPNAME});
    my $dispname = ($self->parse($res))[3];
}

sub body {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id BODY});
    my $body = ($self->parse($res))[3];
}

1;

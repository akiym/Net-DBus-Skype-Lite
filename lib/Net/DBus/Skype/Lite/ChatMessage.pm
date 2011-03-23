package Net::DBus::Skype::Lite::ChatMessage;
use strict;
use warnings;
use overload qw/""/ => sub { shift->{res} };
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Chat;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;
use Time::Piece;

sub new {
    my ($class, $id) = @_;

    bless {
        id => $id,
    }, $class;
}

sub chatmessage { shift }

sub get_chatmessage {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET CHATMESSAGE $id $property});
    (parse_res($res))[3];
}

sub timestamp {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $timestamp = $self->get_chatmessage('TIMESTAMP');
    Time::Piece->new($timestamp);
}

sub from_handle {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $from_handle = $self->get_chatmessage('FROM_HANDLE');
}

sub from_dispname {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $form_dispname = $self->get_chatmessage('FROM_DISPNAME');
}

sub status {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $status = $self->get_chatmessage('STATUS');
}

sub chatname {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $chatname = $self->get_chatmessage('CHATNAME');
}

sub is_editable {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $is_editable = $self->get_chatmessage('IS_EDITABLE');
}

sub edited_by {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $edited_by = $self->get_chatmessage('EDITED_BY');
}

sub edited_timestamp {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $edited_timestamp = $self->get_chatmessage('EDITED_TIMESTAMP');
    Time::Piece->new($edited_timestamp);
}

sub body {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $body = $self->get_chatmessage('BODY');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::ChatMessage

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item timestamp

Time::Piece object

=item from_handle
=item from_dispname
=item status
=item chatname
=item is_editable
=item edited_by
=item edited_timestamp

Time::Piece object

=item body

=back


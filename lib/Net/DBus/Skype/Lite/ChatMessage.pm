package Net::DBus::Skype::Lite::ChatMessage;
use strict;
use warnings;
use overload qw/""/ => sub { shift->{res} };
use Net::DBus::Skype::Lite::Chat;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;
use Time::Piece;

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

sub get_chatmessage {
    my ($self, $id, $property) = @_;

    my $res = c->api(qq{GET CHATMESSAGE $id $property});
    (parse_res($res))[3];
}

sub timestamp {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $timestamp = $self->get_chatmessage($id, 'TIMESTAMP');
    Time::Piece->new($timestamp);
}

sub from_handle {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $from_handle = $self->get_chatmessage($id, 'FROM_HANDLE');
}

sub from_dispname {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $form_dispname = $self->get_chatmessage($id, 'FROM_DISPNAME');
}

sub status {
    my ($self) = @_;

    $self->{property} eq 'STATUS' ? $self->{value} : '';
}

sub chatname {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id CHATNAME});
    my $chatname = (parse_res($res))[3];

    $res = c->api(qq{GET CHAT $chatname NAME});
    cmd_object('Chat', $res);
}

sub is_editable {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $is_editable = $self->get_chatmessage($id, 'IS_EDITABLE');
}

sub edited_by {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $edited_by = $self->get_chatmessage($id, 'EDITED_BY');
}

sub edited_timestamp {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $edited_timestamp = $self->get_chatmessage($id, 'EDITED_TIMESTAMP');
    Time::Piece->new($edited_timestamp);
}

sub body {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $body = $self->get_chatmessage($id, 'BODY');
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

Net::DBus::Skype::Lite::Chat object

=item is_editable
=item edited_by
=item edited_timestamp

Time::Piece object

=item body

=back


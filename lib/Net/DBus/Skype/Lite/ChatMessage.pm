package Net::DBus::Skype::Lite::ChatMessage;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Chat;
use Net::DBus::Skype::Lite::Util;
use Class::Trigger;

sub new {
    my ($class, %args) = @_;

    bless {
        id => $args{id},
        property => $args{property},
        value => $args{value},
    }, $class;
}

sub chatmessage { shift }

sub get_chatmessage {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET CHATMESSAGE $id $property});
    (parse_notification($res))[3];
}

sub timestamp {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'TIMESTAMP');
}

sub from_handle {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'FROM_HANDLE');
}

sub from_dispname {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'FROM_DISPNAME');
}

sub type {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'TYPE');
}

sub status {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'STATUS');
}

sub leavereason {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'LEAVEREASON');
}

sub chatname {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'CHATNAME');
}

sub users {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'USERS');
}

sub is_editable {
    my ($self, $id) = @_;

    my $res = $self->get_chatmessage($id, 'IS_EDITABLE');
    $res eq 'TRUE' ? 1 : 0;
}

sub edited_by {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'EDITED_BY');
}

sub edited_timestamp {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'EDITED_TIMESTAMP');
}

sub options {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'OPTIONS');
}

sub role {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'ROLE');
}

sub seen {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'SEEN');
}

sub body {
    my ($self, $id) = @_;

    $self->get_chatmessage($id, 'BODY');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::ChatMessage

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $chatmessage->[property] >>

    $chatmessage->timestamp;

=item timestamp
=item from_handle
=item from_dispname
=item type
=item status
=item leavereason
=item chatname
=item users
=item is_editable
=item edited_by
=item edited_timestamp
=item options
=item role
=item seen
=item body

=back


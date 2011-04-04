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

sub property {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET CHATMESSAGE $id $property});
    (parse_notification($res))[3];
}

sub timestamp {
    my ($self) = @_;
    $self->property('TIMESTAMP');
}

sub from_handle {
    my ($self) = @_;
    $self->property('FROM_HANDLE');
}

sub from_dispname {
    my ($self) = @_;
    $self->property('FROM_DISPNAME');
}

sub type {
    my ($self) = @_;
    $self->property('TYPE');
}

sub status {
    my ($self) = @_;
    $self->property('STATUS');
}

sub leavereason {
    my ($self) = @_;
    $self->property('LEAVEREASON');
}

sub chatname {
    my ($self) = @_;
    $self->property('CHATNAME');
}

sub users {
    my ($self) = @_;
    $self->property('USERS');
}

sub is_editable {
    my ($self) = @_;
    my $res = $self->property('IS_EDITABLE');
    $res eq 'TRUE' ? 1 : 0;
}

sub edited_by {
    my ($self) = @_;
    $self->property('EDITED_BY');
}

sub edited_timestamp {
    my ($self) = @_;
    $self->property('EDITED_TIMESTAMP');
}

sub options {
    my ($self) = @_;
    $self->property('OPTIONS');
}

sub role {
    my ($self) = @_;
    $self->property('ROLE');
}

sub seen {
    my ($self) = @_;
    $self->property('SEEN');
}

sub body {
    my ($self) = @_;
    $self->property('BODY');
}

sub chat {
    my ($self) = @_;
    my $id = $self->chatname;
    return object('Chat', id => $id);
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

=item chat

return Net::DBus::Skype::Lite::Chat object.

=back


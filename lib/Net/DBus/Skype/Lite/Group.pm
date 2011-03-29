package Net::DBus::Skype::Lite::Group;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
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

sub group { shift }

sub property {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET GROUP $id $property});
    (parse_notification($res))[3];
}

sub type {
    my ($self, $id) = @_;
    $self->property($id, 'TYPE');
}

sub custom_group_id {
    my ($self, $id) = @_;
    $self->property($id, 'CUSTOM_GROUP_ID');
}

sub displayname {
    my ($self, $id) = @_;
    $self->property($id, 'DISPLAYNAME');
}

sub nrofusers {
    my ($self, $id) = @_;
    $self->property($id, 'NROFUSERS');
}

sub nrofusers_online {
    my ($self, $id) = @_;
    $self->property($id, 'NROFUSERS_ONLINE');
}

sub users {
    my ($self, $id) = @_;
    $self->property($id, 'USERS');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::Group

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $group->[property] >>

=item type
=item custom_group_id
=item displayname
=item nrofusers
=item nrofusers_online
=item users

=back


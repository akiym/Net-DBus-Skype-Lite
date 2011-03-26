package Net::DBus::Skype::Lite::Group;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res/;

sub new {
    my ($class, %args) = @_;

    bless {
        id => $args{id},
        property => $args{property},
        value => $args{value},
    }, $class;
}

sub group { shift }

sub get_group {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET GROUP $id $property});
    (parse_res($res))[3];
}

sub type {
    my ($self, $id) = @_;

    $self->get_group($id, 'TYPE');
}

sub custom_group_id {
    my ($self, $id) = @_;

    $self->get_group($id, 'CUSTOM_GROUP_ID');
}

sub displayname {
    my ($self, $id) = @_;

    $self->get_group($id, 'DISPLAYNAME');
}

sub nrofusers {
    my ($self, $id) = @_;

    $self->get_group($id, 'NROFUSERS');
}

sub nrofusers_online {
    my ($self, $id) = @_;

    $self->get_group($id, 'NROFUSERS_ONLINE');
}

sub users {
    my ($self, $id) = @_;

    $self->get_group($id, 'USERS');
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


package Net::DBus::Skype::Lite::ChatMember;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res/;

sub new {
    my ($class, $id) = @_;

    bless {
        id => $id,
    }, $class;
}

sub chatmember { shift }

sub get_chatmember {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET CHATMEMBER $id $property});
    (parse_res($res))[3];
}

sub chatname {
    my ($self, $id) = @_;

    $self->get_chatmember($id, 'CHATNAME');
}

sub identity {
    my ($self, $id) = @_;

    $self->get_chatmember($id, 'IDENTITY');
}

sub role {
    my ($self, $id) = @_;

    $self->get_chatmember($id, 'ROLE');
}

sub is_active {
    my ($self, $id) = @_;

    $self->get_chatmember($id, 'IS_ACTIVE');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::ChatMember

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $chatmember->[property] >>

    $chatmember->chatname;

=item chatname
=item identity
=item role
=item is_active

=back

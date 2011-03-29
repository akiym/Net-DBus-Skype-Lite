package Net::DBus::Skype::Lite::ChatMember;
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

sub chatmember { shift }

sub property {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET CHATMEMBER $id $property});
    (parse_notification($res))[3];
}

sub chatname {
    my ($self, $id) = @_;
    $self->property($id, 'CHATNAME');
}

sub identity {
    my ($self, $id) = @_;
    $self->property($id, 'IDENTITY');
}

sub role {
    my ($self, $id) = @_;
    $self->property($id, 'ROLE');
}

sub is_active {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'IS_ACTIVE');
    $res eq 'TRUE' ? 1 : 0;
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


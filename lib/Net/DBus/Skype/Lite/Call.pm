package Net::DBus::Skype::Lite::Call;
use strict;
use warnings;
use overload qw/""/ => sub { shift->{res} };
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

sub new {
    my ($class, $id) = @_;

    bless {
        id => $id,
    }, $class;
}

sub call { shift }

sub get_call {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET CALL $id $property});
    (parse_res($res))[3];
}

sub status {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $status = $self->get_call('STATUS');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::Call

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item status

=back


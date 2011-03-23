package Net::DBus::Skype::Lite::Call;
use strict;
use warnings;
use overload qw/""/ => sub { shift->{res} };
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

sub new {
    my ($class, $res) = @_;

    bless {
        res => $res,
    }, $class;
}

sub call {
    my ($self) = @_;

    my @res = parse_res($self->{res});
    $self->{command} = $res[0];
    $self->{id} = $res[1];
    $self->{property} = $res[2];
    $self->{value} = $res[3];

    $self;
}

sub get_call {
    my ($self, $id, $property) = @_;

    my $res = c->api(qq{GET CALL $id $property});
    (parse_res($res))[3];
}

sub status {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $status = $self->get_call($id, 'STATUS');
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


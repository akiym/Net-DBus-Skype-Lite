package Net::DBus::Skype::Lite::Chat;
use strict;
use warnings;
use overload qq/""/ => sub { shift->chat->name };
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res/;

sub new {
    my ($class, $res) = @_;

    my $self = bless {
        res => $res,
    }, $class;
    $self->chat();

    $self;
}

sub chat {
    my ($self) = @_;

    my @res = parse_res($self->{res});
    $self->{command} = $res[0];
    $self->{id} = $res[1];
    $self->{property} = $res[2];
    $self->{value} = $res[3];

    $self;
}

sub send_message {
    my ($self, $message) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{CHATMESSAGE $id $message});
}

sub get_chat {
    my ($self, $id, $property) = @_;

    my $res = c->api(qq{GET CHAT $id $property});
    # TODO ERROR 105 Invalid chat name
    (parse_res($res))[3];
}

sub name {
    my ($self, $id) = @_;
    $id //= $self->{id};

    my $chatname = $self->get_chat($id, 'NAME');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::Chat

=head1 METHODS

=over 4

=item C<< $chat->send_message() >>

    $chat->send_message('hello');

=item name

=back


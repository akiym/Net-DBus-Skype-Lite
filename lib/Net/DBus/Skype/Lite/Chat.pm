package Net::DBus::Skype::Lite::Chat;
use strict;
use warnings;
use overload qq/""/ => sub { shift->chat->name };
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res/;

sub new {
    my ($class, $id) = @_;

    bless {
        id => $id,
    }, $class;
}

sub chat { shift }

sub send_message {
    my ($self, $message) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{CHATMESSAGE $id $message});
}

sub get_chat {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET CHAT $id $property});
    (parse_res($res))[3];
}

sub name {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    my $chatname = $self->get_chat('NAME');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::Chat

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $chat->send_message() >>

    $chat->send_message('hello');

=item name

=back


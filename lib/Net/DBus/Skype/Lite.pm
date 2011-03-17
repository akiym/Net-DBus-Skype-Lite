package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype::Lite::API;

sub new {
    my ($class) = @_;

    my $api = Net::DBus::Skype::Lite::API->new();
    bless {
        api => $api,
    }, $class;
}

sub api { shift->{api}->Invoke(@_) }

sub friends {
    my ($self) = @_;

    # -> SEARCH FRINDS
    my $res = $self->api(qq{SEARCH FRIENDS});

    # <- USERS [user[, user]*]
    my ($notification, $user) = split /\s+/, $res, 2;
    return unless $notification eq 'USERS';

    my @user = split ', ', $user;

    @user;
}

sub recent_chats {
    my ($self) = @_;

    # -> SEARCH RECENTCHATS
    my $res = $self->api(qq{SEARCH RECENTCHATS});

    # <- CHATS [<chatname>[, <chatname>]*]
    my ($notification, $chatname) = split /\s+/, $res, 2;
    return unless $notification eq 'CHATS';

    my @chatname = split ', ', $chatname;

    @chatname;
}

sub recent_chat {
    my ($self) = @_;

    my @chatname = $self->recent_chats();

    $chatname[0];
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite - 

=head1 SYNOPSIS

    use Net::DBus::Skype::Lite;

    my $skype = Net::DBus::Skype::Lite->new();
    for (@{$skype->recent_chat}) {
        $_->send_message(':)');
    }


package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype::Lite::API;
use Net::DBus::Skype::Lite::Command;
use Log::Minimal;

{
    our $CONTEXT;
    sub context { $CONTEXT }
    sub set_context { $CONTEXT = $_[1] }
}

sub new {
    my ($class) = @_;

    my $api = Net::DBus::Skype::Lite::API->new();
    my $self = bless {
        api => $api,
        _trigger => sub {},
    }, $class;
    $class->set_context($self);

    $self;
}

sub api { shift->{api}->Invoke(@_) }

sub parse {
    my ($self, $notification) = @_;

    return Net::DBus::Skype::Lite::Command->parse($notification);
}

sub _trigger {
    my ($self, $notification) = @_;

    my $res = $self->parse($notification);
    $self->{_trigger}->($self, $res);
}

sub trigger {
    my ($self, $trigger) = @_;

    debugf('set $self->{_trigger}');
    $self->{_trigger} = $trigger;
}

sub friends {
    my ($self) = @_;

    # -> SEARCH FRINDS
    my $res = $self->api(qq{SEARCH FRIENDS});

    # <- USERS [user[, user]*]
    my ($command, $user) = split /\s+/, $res, 2;
    return unless $command eq 'USERS';

    my @user = split ', ', $user;

    @user;
}

sub recent_chats {
    my ($self) = @_;

    # -> SEARCH RECENTCHATS
    my $res = $self->api(qq{SEARCH RECENTCHATS});

    # <- CHATS [<chatname>[, <chatname>]*]
    my ($command, $chatname) = split /\s+/, $res, 2;
    return unless $command eq 'CHATS';

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

=head1 METHODS

=over 4

=item C<< $skype->trigger() >>

    use Log::Minimal;

    my $skype = Net::DBus::Skype::Lite->new();
    $skype->trigger(sub {
        my ($self, $res) = @_;
        debugf($res);
    });

=back


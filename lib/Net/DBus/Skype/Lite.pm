package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype::Lite::API;
use Net::DBus::Skype::Lite::Command;
use Net::DBus::Skype::Lite::Util qw/parse_res/;
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
        _received => sub {},
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
    $self->_message_received($res);
}

sub trigger {
    my ($self, $trigger) = @_;

    debugf('set $self->{_trigger}');
    $self->{_trigger} = $trigger;
}

sub _message_received {
    my ($self, $res) = @_;

    my $msg = $res->chatmessage;
    return unless $msg;
    if ($msg->status eq 'RECEIVED') {
        return $self->{_received}->($self, $msg);
    }
}

sub message_received {
    my ($self, $trigger) = @_;

    $self->{_received} = $trigger;
}

sub friends {
    my ($self) = @_;

    # -> SEARCH FRINDS
    my $res = $self->api(qq{SEARCH FRIENDS});

    # <- USERS [user[, user]*]
    my ($command, $user) = parse_res($res, 2);
    return unless $command eq 'USERS';

    my @user = split ', ', $user;

    @user;
}

sub recent_chats {
    my ($self) = @_;

    # -> SEARCH RECENTCHATS
    my $res = $self->api(qq{SEARCH RECENTCHATS});

    # <- CHATS [<chatname>[, <chatname>]*]
    my ($command, $chatname) = parse_res($res, 2);
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

    $skype->trigger(sub {
        my ($self, $res) = @_;
        print $res;
    });

=item C<< $skype->message_received() >>

    my $skype = Net::DBus::Skype::Lite->new();
    $skype->trigger(sub {
        my ($self, $res) = @_;
        if (my $msg = $res->chatmessage) {
            if ($msg->status eq 'RECEIVED') {
                print $msg->body;
            }
        }
    });

the same as this

    $skype->message_received(
        my ($self, $msg) = @_;
        print $msg->body;
    );

=back


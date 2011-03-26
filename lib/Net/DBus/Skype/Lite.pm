package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype::Lite::API;
use Net::DBus::Skype::Lite::Command;
use Net::DBus::Skype::Lite::Util;

{
    our $CONTEXT;
    sub context { $CONTEXT }
    sub set_context { $CONTEXT = $_[1] }
}

sub new {
    my ($class, %args) = @_;

    my $self = bless {
        name => 'Net::DBus::Skype::Lite',
        notify => $args{notify} || sub {},
        invoke => $args{invoke} || sub {},
        trigger => sub {},
    }, $class;
    $class->set_context($self);
    my $api = Net::DBus::Skype::Lite::API->new();
    $self->{api} = $api;
    $self;
}

sub api { shift->{api}->Invoke(@_) }

sub trigger {
    my ($self, $hook) = @_;

    $self->{trigger} = $hook;
}

sub user {
    my $self = shift;
    my $hook = @_==1 ? $_[0] : {@_};

    if (ref($hook) eq 'CODE') {
        $self->{user} = $hook;
    } else {
        my $id = $hook;
        return object('User', id => $id);
    }
}

sub profile {
    my $self = shift;
    my $hook = @_==1 ? $_[0] : {@_};

    if (ref($hook) eq 'CODE') {
        $self->{profile} = $hook;
    } else {
        return object('Profile');
    }
}

sub call {
    my $self = shift;
    my $hook = @_==1 ? $_[0] : {@_};

    if (ref($hook) eq 'HASH') {
        while (my ($name, $hook) = each %$hook) {
            $self->{"call_$name"} = $hook;
        }
    } elsif (ref($hook) eq 'CODE') {
        $self->{call} = $hook;
    } else {
        my $id = $hook;
        return object('Call', id => $id);
    }
}

sub chatmessage {
    my $self = shift;
    my $hook = @_==1 ? $_[0] : {@_};

    if (ref($hook) eq 'HASH') {
        while (my ($name, $hook) = each %$hook) {
            $self->{"chatmessage_$name"} = $hook;
        }
    } elsif (ref($hook) eq 'CODE') {
        $self->{chatmessage} = $hook;
    } else {
        my $id = $hook;
        return object('ChatMessage', id => $id);
    }
}

sub create_chat {
    my ($self, @handle) = @_;

    my $handle = join ', ', @handle;
    my $res = $self->api(qq{CHAT CREATE $handle});
    my ($command, $id, $property, $value) = parse_notification($res);
    object('Chat', id => $id, property => $property, value => $value);
}

sub send_message {
    my ($self, $id, $message) = @_;

    $self->api(qq{CHATMESSAGE $id $message});
}

sub friends {
    my ($self) = @_;

    my $res = $self->api(qq{SEARCH FRIENDS});
    my ($command, $friend) = parse_notification($res, 2);
    my @friend = split ', ', $friend;
    for my $id (@friend) {
        $id = object('User', id => $id);
    }
    \@friend;
}

sub recent_chats {
    my ($self) = @_;

    my $res = $self->api(qq{SEARCH RECENTCHATS});
    my ($command, $chatname) = parse_notification($res, 2);
    my @chatname = split ', ', $chatname;
    for my $id (@chatname) {
        $id = object('Chat', id => $id);
    }
    \@chatname;
}

sub recent_chat {
    my ($self) = @_;

    my $chatname = $self->recent_chats;
    $chatname->[0];
}

sub groups {
    my ($self) = @_;

    my $res = $self->api(qq{SEARCH GROUPS});
    my ($command, $group) = parse_notification($res, 2);
    my @group = split ', ', $group;
    for my $id (@group) {
        # when module is loaded?
        $id = object('Group', id => $id);
    }
    \@group;
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite - 

=head1 SYNOPSIS

    use Net::DBus::Skype::Lite;

    my $skype = Net::DBus::Skype::Lite->new();
    for (@{$skype->recent_chats}) {
        $_->send_message(':)');
    }

=head1 METHODS

=head2 C<< Net::DBus::Skype::Lite->new() >>

=over 4

=item name

    Net::DBus::Skype::Lite->new(name => 'MyApp');

=item notify

    Net::DBus::Skype::Lite->new(
        notify => sub {
            my ($self, $notification) = @_;
            # run
        }
    );

=item invoke

    Net::DBus::Skype::Lite->new(
        invoke => sub {
            my ($self, $notification, $res) = @_;
            # run
        }
    );

=back

=head2 C<< $skype->trigger() >>

    $skype->trigger(sub {
        my ($self, $res, $notification) = @_;
        # run
    });

=head2 C<< $skype->user() >>

    $skype->user();

    $skype->user(sub {
        my ($self, $user) = @_;
        # run
    });

=head2 C<< $skype->profile() >>

    $skype->profile();

    $skype->profile(sub {
        my ($self, $profile) = @_;
        # run
    });

=head2 C<< $skype->call() >>

    $skype->call();

    $skype->call(sub {
        my ($self, $call) = @_;
        # run
    });

=over 4

=item inprogress

    $skype->call(
        inprogress => sub {
            my ($self, $call) = @_;
            # run
        }
    );

the same as this

    $skype->call(sub {
        my ($self, $call) = @_;
        if ($call->{property} eq 'STATUS' && $call->{value} eq 'INPROGRESS') {
            # run
        }
    });

=item finished

    $skype->call(
        finished => sub {
            my ($self, $call) = @_;
            # run
        }
    );

the same as this

    $skype->call(sub {
        my ($self, $call) = @_;
        if ($call->{property} eq 'STATUS' && $call->{value} eq 'FINISHED') {
            # run
        }
    });

=back

=head2 C<< $skype->chatmessage() >>

    $skype->chatmessage();

    $skype->chatmessage(sub {
        my ($self, $chatmessage) = @_;
        # run
    });

=over 4

=item received

    $skype->chatmessage(
        received => sub {
            my ($self, $chatmessage) = @_;
            # run
        }
    );

the same as this

    $skype->chatmessage(sub {
        my ($self, $chatmessage) = @_;
        if ($chatmessage->{property} eq 'STATUS' && $chatmessage->{value} eq 'RECEIVED') {
            # run
        }
    });

=back

=head2 C<< $skype->create_chat() >>

return Net::DBus::Skype::Lite::Chat object.

    $skype->create_chat('echo123');

=head2 C<< $skype->send_message() >>

    my $id = $skype->create_chat('echo123')->name;
    $skype->send_message($id, 'hello');

=head2 C<< $skype->friends() >>

return arrayref of Net::DBus::Skype::Lite::User object.

    for (@{$skype->friends}) {
        print $_->fullname;
    }

=head2 C<< $skype->recent_chats() >>

return arrayref of Net::DBus::Skype::Lite::Chat object.

    for (@{$skype->recent_chats}) {
        $_->send_message('hello');
    }

=head2 C<< $skype->recent_chat() >>

    $skype->recent_chat->send_message('hello');

the same as this

    $skype->recent_chats->[0]->send_message('hello');

=head2 C<< $skype->groups() >>

return arrayref of Net::DBus::Skype::Lite::Group object.

    for (@{$skype->groups}) {
        print $_->displayname;
    }

=head1 OBJECTS

=head2 Net::DBus::Skype::Lite::User;

=head2 Net::DBus::Skype::Lite::Profile;

=head2 Net::DBus::Skype::Lite::Call;

=head2 Net::DBus::Skype::Lite::Chat;

=head2 Net::DBus::Skype::Lite::ChatMember;

=head2 Net::DBus::Skype::Lite::ChatMessage;

=head2 Net::DBus::Skype::Lite::VoiceMail;

=head2 Net::DBus::Skype::Lite::SMS;

=head2 Net::DBus::Skype::Lite::Application;

=head2 Net::DBus::Skype::Lite::Group;

=head2 Net::DBus::Skype::Lite::FileTransfer;


package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype::Lite::API;
use Net::DBus::Skype::Lite::Command;
use Net::DBus::Skype::Lite::Util qw/parse_notification object add_trigger/;

{
    our $CONTEXT;
    sub context { $CONTEXT }
    sub set_context { $CONTEXT = $_[1] }
}

sub new {
    my ($class, %args) = @_;

    my $self = bless {
        name => 'Net::DBus::Skype::Lite',
    }, $class;
    $class->set_context($self);
    add_trigger('API', notify => $args{notify}) if exists $args{notify};
    add_trigger('API', invoke => $args{invoke}) if exists $args{invoke};
    my $api = Net::DBus::Skype::Lite::API->new();
    $self->{api} = $api;
    $self;
}

sub api { shift->{api}->Invoke(@_) }

sub user {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('User', user => $param);
        } else {
            if (defined $param) {
                return object('User', id => $param);
            } else {
                return object('User');
            }
        }
    } else {
        add_trigger('User', @_);
    }
}

sub profile {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('Profile', profile => $param);
        } else {
            return object('Profile');
        }
    } else {
        add_trigger('Profile', @_);
    }
}

sub call {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('Call', call => $param);
        } else {
            if (defined $param) {
                return object('Call', id => $param);
            } else {
                return object('Call');
            }
        }
    } else {
        add_trigger('Call', @_);
    }
}

sub chat {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('Chat', chat => $param);
        } else {
            if (defined $param) {
                return object('Chat', id => $param);
            } else {
                return object('Chat');
            }
        }
    } else {
        add_trigger('Chat', @_);
    }
}

sub chatmember {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('ChatMember', chatmember => $param);
        } else {
            if (defined $param) {
                return object('ChatMember', id => $param);
            } else {
                return object('ChatMember');
            }
        }
    } else {
        add_trigger('ChatMember', @_);
    }
}

sub chatmessage {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('ChatMessage', chatmessage => $param);
        } else {
            if (defined $param) {
                return object('ChatMessage', id => $param);
            } else {
                return object('ChatMessage');
            }
        }
    } else {
        add_trigger('ChatMessage', @_);
    }
}

# alias
sub message_received {
    my ($self, $code) = @_;

    my $wrap = sub {
        my ($chatmessage, $status) = @_;
        if ($status eq 'RECEIVED') {
            return $code->($chatmessage);
        } else {
            return sub {};
        }
    };
    add_trigger('ChatMessage', status => $wrap);
}

sub group {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('Group', group => $param);
        } else {
            if (defined $param) {
                return object('Group', id => $param);
            } else {
                return object('');
            }
        }
    } else {
        add_trigger('Group', @_);
    }
}

sub filetransfer {
    my $self = shift;
    if (@_ <= 1) {
        my $param = shift;
        if (ref($param) eq 'CODE') {
            add_trigger('FileTransfer', filetransfer => $param);
        } else {
            if (defined $param) {
                return object('FileTransfer', id => $param);
            } else {
                return object('');
            }
        }
    } else {
        add_trigger('FileTransfer', @_);
    }
}

sub create_chat {
    my ($self, @handle) = @_;

    my $handle = join ', ', @handle;
    my $res = $self->api(qq{CHAT CREATE $handle});
    my ($command, $id, $property, $value) = parse_notification($res);
    return object('Chat', id => $id, property => $property, value => $value);
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

    oops! this method is deprecated!

    $skype->trigger(sub {
        my ($self, $res, $notification) = @_;
        # run
    });

=head2 C<< $skype->user() >>

    $skype->user();

    $skype->user(sub {
        my ($user, $notification) = @_;
        # run
    });

=head2 C<< $skype->profile() >>

    $skype->profile();

    $skype->profile(sub {
        my ($profile, $notification) = @_;
        # run
    });

=head2 C<< $skype->call() >>

    $skype->call();

    $skype->call(sub {
        my ($call, $notification) = @_;
        # run
    });

=over 4

=item status

    $skype->call(
        status => sub {
            my ($call, $status) = @_;
            # run
        }
    );

=back

=head2 C<< $skype->chat() >>

    $skype->chat();

    $skype->chat(sub {
        my ($chat, $notification) = @_;
        # run
    });

=head2 C<< $skype->chatmember() >>

    $skype->chatmember();

    $skype->chatmember(sub {
        my ($chatmember, $notification) = @_;
        # run
    });

=head2 C<< $skype->chatmessage() >>

    $skype->chatmessage();

    $skype->chatmessage(sub {
        my ($chatmessage, $notification) = @_;
        # run
    });

=over 4

=item status

    $skype->chatmessage(
        status => sub {
            my ($chatmessage, $status) = @_;
            # run
        }
    );

=back

=head2 C<< $skype->message_received() >>

    $skype->message_received(sub {
        my ($chatmessage) = @_;
        # run
    });

the same as this

    $skype->chatmessage(
        status => sub {
            my ($chatmessage, $status) = @_;
            if ($status eq 'RECEIVED') {
                # run
            }
        }
    );

=head2 C<< $skype->group() >>

    $skype->group();

    $skype->group(sub {
        my ($group, $notification) = @_;
        # run
    });

=head2 C<< $skype->filetransfer() >>

    $skype->filetransfer();

    $skype->filetransfer(sub {
        my ($filetransfer, $notification) = @_;
        # run
    });

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


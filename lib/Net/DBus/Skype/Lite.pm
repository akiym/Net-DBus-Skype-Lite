package Net::DBus::Skype::Lite;
use strict;
use warnings;
use Net::DBus::Skype::Lite::API;
use Net::DBus::Skype::Lite::Command;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

{
    our $CONTEXT;
    sub context { $CONTEXT }
    sub set_context { $CONTEXT = $_[1] }
}

sub new {
    my ($class, %args) = @_;

    my $self = bless {
        notify => $args{notify} || sub {},
        invoke => $args{invoke} || sub {},
    }, $class;
    $class->set_context($self);
    my $api = Net::DBus::Skype::Lite::API->new();
    $self->{api} = $api;
    $self;
}

sub api { shift->{api}->Invoke(@_) }

sub trigger {
    my ($self, $hook) = @_;

    no warnings 'redefine';
    *_trigger = $hook;
}

sub call_inprogress {
    my ($self, $hook) = @_;

    no warnings 'redefine';
    *_call_inprogress = $hook;
}

sub message_received {
    my ($self, $hook) = @_;

    no warnings 'redefine';
    *_message_received = $hook;
}

sub create_chat {
    my ($self, @handle) = @_;

    my $handle = join ', ', @handle;
    my $res = $self->api(qq{CHAT CREATE $handle});
    my $id = (parse_res($res))[1];
    cmd_object('Chat', $id);
}

sub send_message {
    my ($self, $id, $message) = @_;

    $self->api(qq{CHATMESSAGE $id $message});
}

sub friends {
    my ($self) = @_;

    my $res = $self->api(qq{SEARCH FRIENDS});
    my ($command, $friend) = parse_res($res, 2);
    my @friend = split ', ', $friend;
    for my $id (@friend) {
        $id = cmd_object('User', $id);
    }
    \@friend;
}

sub recent_chats {
    my ($self) = @_;

    my $res = $self->api(qq{SEARCH RECENTCHATS});
    my ($command, $chatname) = parse_res($res, 2);
    my @chatname = split ', ', $chatname;
    for my $id (@chatname) {
        $id = cmd_object('Chat', $id);
    }
    \@chatname;
}

sub recent_chat {
    my ($self) = @_;

    my @chatname = $self->recent_chats();
    $chatname[0];
}

sub groups {
    my ($self) = @_;

    my $res = $self->api(qq{SEARCH GROUPS});
    my ($command, $group) = parse_res($res, 2);
    my @group = split ', ', $group;
    for my $id (@group) {
        # when module is loaded?
        $id = cmd_object('Group', $id);
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
    for (@{$skype->recent_chat}) {
        $_->send_message(':)');
    }

=head1 METHODS

=over 4

=item C<< Net::DBus::Skype::Lite->new() >>

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
            my ($self, $notification) = @_;
            # run
        }
    );

=item C<< $skype->trigger() >>

    $skype->trigger(sub {
        my ($self, $res, $notification) = @_;
        # run
    });

=item C<< $skype->call_inprogress() >>

    skype->call_inprogress(sub {
        my ($self, $call) = @_;
        # run
    });

the same as this

    $skype->trigger(sub {
        my ($self, $res) = @_;
        if (my $call = $res->call) {
            if ($call->status eq 'INPROGRESS') {
                # run
            }
        }
    });

=item C<< $skype->message_received() >>

    $skype->message_received(sub {
        my ($self, $msg) = @_;
        print $msg->body;
    });

the same as this

    $skype->trigger(sub {
        my ($self, $res) = @_;
        if (my $msg = $res->chatmessage) {
            if ($msg->status eq 'RECEIVED') {
                print $msg->body;
            }
        }
    });

=item C<< $skype->create_chat() >>

    $skype->create_chat('echo123');

=item C<< $skype->send_message() >>

    my $id = $skype->create_chat('echo123')->name;
    $skype->send_message($id, 'hello');

=item C<< $skype->recent_chats() >>

    for ($skype->recent_chats) {
        $_->send_message('hello');
    }

=item C<< $skype->recent_chat() >>

    $skype->recent_chat->send_message('hello');

the same as this

    ($skype->recent_chats)[0]->send_message('hello');

=item C<< $skype->groups() >>

    for ($skype->groups) {
        print $_->displayname;
    }

=back


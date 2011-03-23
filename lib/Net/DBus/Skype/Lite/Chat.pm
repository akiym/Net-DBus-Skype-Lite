package Net::DBus::Skype::Lite::Chat;
use strict;
use warnings;
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

    $self->get_chat('NAME');
}

sub timestamp {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('TIMESTAMP');
}

sub adder {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('ADDER');
}

sub status {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('STATUS');
}

sub posters {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('POSTERS');
}

sub members {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('MEMBERS');
}

sub topic {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('TOPIC');
}

sub topicxml {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('TOPICXML');
}

sub activemembers {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('ACTIVEMEMBERS');
}

sub friendlyname {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('FRIENDLYNAME');
}

sub chatmessages {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('CHATMESSAGES');
}

sub recentchatmessages {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('RECENTCHATMESSAGES');
}

sub bookmarked {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('BOOKMARKED');
}

sub passwordhint {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('PASSWORDHINT');
}

sub guidelines {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('GUIDELINES');
}

sub options {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('OPTIONS');
}

sub description {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('DESCRIPTION');
}

sub dialog_partner {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('DIALOG_PARTNER');
}

sub activity_timestamp {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('ACTIVITY_TIMESTAMP');
}

sub type {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('TYPE');
}

sub mystatus {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('MYSTATUS');
}

sub myrole {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('MYROLE');
}

sub blob {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('BLOB');
}

sub applicants {
    my ($self, $id) = @_;
    if ($id) {
        $self->{id} = $id;
    }

    $self->get_chat('APPLICANTS');
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


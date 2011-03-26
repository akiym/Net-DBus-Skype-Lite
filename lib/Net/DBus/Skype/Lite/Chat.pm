package Net::DBus::Skype::Lite::Chat;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util qw/parse_res cmd_object/;

sub new {
    my ($class, %args) = @_;

    bless {
        id => $args{id},
        property => $args{property},
        value => $args{value},
    }, $class;
}

sub chat { shift }

sub send_message {
    my ($self, $message) = @_;

    my $id = $self->{id};
    c->api(qq{CHATMESSAGE $id $message});
}

sub get_chat {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET CHAT $id $property});
    (parse_res($res))[3];
}

sub name {
    my ($self, $id) = @_;

    $self->get_chat($id, 'NAME');
}

sub timestamp {
    my ($self, $id) = @_;

    $self->get_chat($id, 'TIMESTAMP');
}

sub adder {
    my ($self, $id) = @_;

    $self->get_chat($id, 'ADDER');
}

sub status {
    my ($self, $id) = @_;

    $self->get_chat($id, 'STATUS');
}

sub posters {
    my ($self, $id) = @_;

    $self->get_chat($id, 'POSTERS');
}

sub members {
    my ($self, $id) = @_;

    my $res = $self->get_chat($id, 'MEMBERS');
    my @members = split ' ', $res;
    \@members;
}

sub topic {
    my ($self, $id) = @_;

    $self->get_chat($id, 'TOPIC');
}

sub topicxml {
    my ($self, $id) = @_;

    $self->get_chat($id, 'TOPICXML');
}

sub activemembers {
    my ($self, $id) = @_;

    $self->get_chat($id, 'ACTIVEMEMBERS');
}

sub friendlyname {
    my ($self, $id) = @_;

    $self->get_chat($id, 'FRIENDLYNAME');
}

sub chatmessages {
    my ($self, $id) = @_;

    $self->get_chat($id, 'CHATMESSAGES');
}

sub recentchatmessages {
    my ($self, $id) = @_;

    my $res = $self->get_chat($id, 'RECENTCHATMESSAGES');
    my @messages = split ', ', $res;
    for my $id (@messages) {
        $id = cmd_object('ChatMessage', $id);
    }
    \@messages;
}

sub bookmarked {
    my ($self, $id) = @_;

    my $res = $self->get_chat($id, 'BOOKMARKED');
    $res eq 'TRUE' ? 1 : 0;
}

sub memberobjects {
    my ($self, $id) = @_;

    my $res = $self->get_chat($id, 'MEMBEROBJECTS');
    my @members = split ', ', $res;
    for my $member (@members) {
        $member = cmd_object('ChatMember', $member);
    }
    \@members;
}

sub passwordhint {
    my ($self, $id) = @_;

    $self->get_chat($id, 'PASSWORDHINT');
}

sub guidelines {
    my ($self, $id) = @_;

    $self->get_chat($id, 'GUIDELINES');
}

sub options {
    my ($self, $id) = @_;

    $self->get_chat($id, 'OPTIONS');
}

sub description {
    my ($self, $id) = @_;

    $self->get_chat($id, 'DESCRIPTION');
}

sub dialog_partner {
    my ($self, $id) = @_;

    $self->get_chat($id, 'DIALOG_PARTNER');
}

sub activity_timestamp {
    my ($self, $id) = @_;

    $self->get_chat($id, 'ACTIVITY_TIMESTAMP');
}

sub type {
    my ($self, $id) = @_;

    $self->get_chat($id, 'TYPE');
}

sub mystatus {
    my ($self, $id) = @_;

    $self->get_chat($id, 'MYSTATUS');
}

sub myrole {
    my ($self, $id) = @_;

    $self->get_chat($id, 'MYROLE');
}

sub blob {
    my ($self, $id) = @_;

    $self->get_chat($id, 'BLOB');
}

sub applicants {
    my ($self, $id) = @_;

    $self->get_chat($id, 'APPLICANTS');
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

=item C<< $chat->[property] >>

    $chat->name;

=item name
=item timestamp
=item adder
=item status
=item poster
=item members
=item topic
=item topicxml
=item activemembers
=item friendlyname
=item chatmessages
=item recentchatmessages
=item bookmarked
=item memberobjects
=item passwordhint
=item guidelines
=item options
=item description
=item dialog_partner
=item activety_timestamp
=item type
=item mystatus
=item myrole
=item blob
=item applicants

=back


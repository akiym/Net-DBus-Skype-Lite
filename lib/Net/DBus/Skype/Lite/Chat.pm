package Net::DBus::Skype::Lite::Chat;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util;
use Class::Trigger;

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
    c->send_message($id, $message);
}

sub property {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET CHAT $id $property});
    (parse_notification($res))[3];
}

sub name {
    my ($self) = @_;
    $self->property('NAME');
}

sub timestamp {
    my ($self) = @_;
    $self->property('TIMESTAMP');
}

sub adder {
    my ($self) = @_;
    $self->property('ADDER');
}

sub status {
    my ($self) = @_;
    $self->property('STATUS');
}

sub posters {
    my ($self) = @_;
    $self->property('POSTERS');
}

sub members {
    my ($self) = @_;
    my $res = $self->property('MEMBERS');
    my @members = split ' ', $res;
    \@members;
}

sub topic {
    my ($self) = @_;
    $self->property('TOPIC');
}

sub topicxml {
    my ($self) = @_;
    $self->property('TOPICXML');
}

sub activemembers {
    my ($self) = @_;
    $self->property('ACTIVEMEMBERS');
}

sub friendlyname {
    my ($self) = @_;
    $self->property('FRIENDLYNAME');
}

sub chatmessages {
    my ($self) = @_;
    $self->property('CHATMESSAGES');
}

sub recentchatmessages {
    my ($self) = @_;
    my $res = $self->property('RECENTCHATMESSAGES');
    my @messages = split ', ', $res;
    for my $message (@messages) {
        $message = object('ChatMessage', id => $message);
    }
    \@messages;
}

sub bookmarked {
    my ($self) = @_;
    my $res = $self->property('BOOKMARKED');
    $res eq 'TRUE' ? 1 : 0;
}

sub memberobjects {
    my ($self) = @_;
    my $res = $self->property('MEMBEROBJECTS');
    my @members = split ', ', $res;
    for my $member (@members) {
        $member = object('ChatMember', id => $member);
    }
    \@members;
}

sub passwordhint {
    my ($self) = @_;
    $self->property('PASSWORDHINT');
}

sub guidelines {
    my ($self) = @_;
    $self->property('GUIDELINES');
}

sub options {
    my ($self) = @_;
    $self->property('OPTIONS');
}

sub description {
    my ($self) = @_;
    $self->property('DESCRIPTION');
}

sub dialog_partner {
    my ($self) = @_;
    $self->property('DIALOG_PARTNER');
}

sub activity_timestamp {
    my ($self) = @_;
    $self->property('ACTIVITY_TIMESTAMP');
}

sub type {
    my ($self) = @_;
    $self->property('TYPE');
}

sub mystatus {
    my ($self) = @_;
    $self->property('MYSTATUS');
}

sub myrole {
    my ($self) = @_;
    $self->property('MYROLE');
}

sub blob {
    my ($self) = @_;
    $self->property('BLOB');
}

sub applicants {
    my ($self) = @_;
    $self->property('APPLICANTS');
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


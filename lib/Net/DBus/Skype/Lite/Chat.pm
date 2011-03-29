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
    c->api(qq{CHATMESSAGE $id $message});
}

sub property {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET CHAT $id $property});
    (parse_notification($res))[3];
}

sub name {
    my ($self, $id) = @_;
    $self->property($id, 'NAME');
}

sub timestamp {
    my ($self, $id) = @_;
    $self->property($id, 'TIMESTAMP');
}

sub adder {
    my ($self, $id) = @_;
    $self->property($id, 'ADDER');
}

sub status {
    my ($self, $id) = @_;
    $self->property($id, 'STATUS');
}

sub posters {
    my ($self, $id) = @_;
    $self->property($id, 'POSTERS');
}

sub members {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'MEMBERS');
    my @members = split ' ', $res;
    \@members;
}

sub topic {
    my ($self, $id) = @_;
    $self->property($id, 'TOPIC');
}

sub topicxml {
    my ($self, $id) = @_;
    $self->property($id, 'TOPICXML');
}

sub activemembers {
    my ($self, $id) = @_;
    $self->property($id, 'ACTIVEMEMBERS');
}

sub friendlyname {
    my ($self, $id) = @_;
    $self->property($id, 'FRIENDLYNAME');
}

sub chatmessages {
    my ($self, $id) = @_;
    $self->property($id, 'CHATMESSAGES');
}

sub recentchatmessages {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'RECENTCHATMESSAGES');
    my @messages = split ', ', $res;
    for my $message (@messages) {
        $message = object('ChatMessage', id => $message);
    }
    \@messages;
}

sub bookmarked {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'BOOKMARKED');
    $res eq 'TRUE' ? 1 : 0;
}

sub memberobjects {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'MEMBEROBJECTS');
    my @members = split ', ', $res;
    for my $member (@members) {
        $member = object('ChatMember', id => $member);
    }
    \@members;
}

sub passwordhint {
    my ($self, $id) = @_;
    $self->property($id, 'PASSWORDHINT');
}

sub guidelines {
    my ($self, $id) = @_;
    $self->property($id, 'GUIDELINES');
}

sub options {
    my ($self, $id) = @_;
    $self->property($id, 'OPTIONS');
}

sub description {
    my ($self, $id) = @_;
    $self->property($id, 'DESCRIPTION');
}

sub dialog_partner {
    my ($self, $id) = @_;
    $self->property($id, 'DIALOG_PARTNER');
}

sub activity_timestamp {
    my ($self, $id) = @_;
    $self->property($id, 'ACTIVITY_TIMESTAMP');
}

sub type {
    my ($self, $id) = @_;
    $self->property($id, 'TYPE');
}

sub mystatus {
    my ($self, $id) = @_;
    $self->property($id, 'MYSTATUS');
}

sub myrole {
    my ($self, $id) = @_;
    $self->property($id, 'MYROLE');
}

sub blob {
    my ($self, $id) = @_;
    $self->property($id, 'BLOB');
}

sub applicants {
    my ($self, $id) = @_;
    $self->property($id, 'APPLICANTS');
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


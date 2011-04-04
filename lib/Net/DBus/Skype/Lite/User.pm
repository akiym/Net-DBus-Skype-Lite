package Net::DBus::Skype::Lite::User;
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

sub user { shift }

sub send_message {
    my ($self, $message) = @_;

    my $id = $self->{id};
    my $chat = c->create_chat($id);
    $chat->send_message($message);
}

sub property {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET USER $id $property});
    (parse_notification($res))[3];
}

sub handle {
    my ($self) = @_;
    $self->property('HANDLE');
}

sub fullname {
    my ($self) = @_;
    $self->property('FULLNAME');
}

sub birthday {
    my ($self) = @_;
    $self->property('BIRTHDAY');
}

sub sex {
    my ($self) = @_;
    $self->property('SEX');
}

sub language {
    my ($self) = @_;
    $self->property('LANGUAGE');
}

sub country {
    my ($self) = @_;
    $self->property('COUNTRY');
}

sub province {
    my ($self) = @_;
    $self->property('PROVINCE');
}

sub city {
    my ($self) = @_;
    $self->property('CITY');
}

sub phone_home {
    my ($self) = @_;
    $self->property('PHONE_HOME');
}

sub phone_office {
    my ($self) = @_;
    $self->property('PHONE_OFFICE');
}

sub phone_mobile {
    my ($self) = @_;
    $self->property('PHONE_MOBILE');
}

sub homepage {
    my ($self) = @_;
    $self->property('HOMEPAGE');
}

sub about {
    my ($self) = @_;
    $self->property('ABOUT');
}

sub hascallequipment {
    my ($self) = @_;
    my $res = $self->property('HASCALLEQUIPMENT');
    $res eq 'TRUE' ? 1 : 0;
}

sub is_video_capable {
    my ($self) = @_;
    my $res = $self->property('IS_VIDEO_CAPABLE');
    $res eq 'TRUE' ? 1 : 0;
}

sub is_voicemail_capable {
    my ($self) = @_;
    my $res = $self->property('IS_VOICEMAIL_CAPABLE');
    $res eq 'TRUE' ? 1 : 0;
}

sub buddystatus {
    my ($self) = @_;
    $self->property('BUDDYSTATUS');
}

sub isauthorized {
    my ($self) = @_;
    my $res = $self->property('ISAUTHORIZED');
    $res eq 'TRUE' ? 1 : 0;
}

sub isblocked {
    my ($self) = @_;
    my $res = $self->property('ISBLOCKED');
    $res eq 'TRUE' ? 1 : 0;
}

sub onlinestatus {
    my ($self) = @_;
    $self->property('ONLINESTATUS');
}

#sub skypeout {
#    my ($self) = @_;
#    $self->property('SKYPEOUT');
#}

#sub skypeme {
#    my ($self) = @_;
#    $self->property('SKYPEME');
#}

sub lastonlinetimestamp {
    my ($self) = @_;
    $self->property('LASTONLINETIMESTAMP');
}

sub can_leave_vm {
    my ($self) = @_;
    my $res = $self->property('CAN_LEAVE_VM');
    $res eq 'TRUE' ? 1 : 0;
}

sub speeddial {
    my ($self) = @_;
    $self->property('SPEEDDIAL');
}

sub receivedauthrequest {
    my ($self) = @_;
    $self->property('RECEIVEDAUTHREQUEST');
}

sub mood_text {
    my ($self) = @_;
    $self->property('MOOD_TEXT');
}

sub rich_mood_text {
    my ($self) = @_;
    $self->property('RICH_MOOD_TEXT');
}

sub aliases {
    my ($self) = @_;
    $self->property('ALIASES');
}

sub timezone {
    my ($self) = @_;
    $self->property('TIMEZONE');
}

sub is_cf_active {
    my ($self) = @_;
    my $res = $self->property('IS_CF_ACTIVE');
    $res eq 'TRUE' ? 1 : 0
}

sub nrof_authed_buddies {
    my ($self) = @_;
    $self->property('NROF_AUTHED_BUDDIES');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::User

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $user->[property] >>

    $user->handle;

=item handle
=item fullname
=item birthday
=item sex
=item language
=item country
=item province
=item city
=item phone_home
=item phone_office
=item phone_mobile
=item homepage
=item about
=item hascallequipment
=item is_video_capable
=item is_voicemail_capable
=item buddystatus
=item isauthorized
=item isblocked
=item onlinestatus
=item lastonlinetimestamp
=item can_leave_vm
=item speeddial
=item receivedauthrequest
=item mood_text
=item rich_mood_text
=item aliases
=item timezone
=item is_cf_active
=item nrof_authed_buddies

=back


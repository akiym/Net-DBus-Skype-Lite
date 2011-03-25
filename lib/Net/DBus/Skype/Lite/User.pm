package Net::DBus::Skype::Lite::User;
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

sub user { shift }

sub get_user {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET USER $id $property});
    (parse_res($res))[3];
}

sub handle {
    my ($self, $id) = @_;

    $self->get_user($id, 'HANDLE');
}

sub fullname {
    my ($self, $id) = @_;

    $self->get_user($id, 'FULLNAME');
}

sub birthday {
    my ($self, $id) = @_;

    $self->get_user($id, 'BIRTHDAY');
}

sub sex {
    my ($self, $id) = @_;

    $self->get_user($id, 'SEX');
}

sub languages {
    my ($self, $id) = @_;

    $self->get_user($id, 'LANGUAGES');
}

sub country {
    my ($self, $id) = @_;

    $self->get_user($id, 'COUNTRY');
}

sub province {
    my ($self, $id) = @_;

    $self->get_user($id, 'PROVINCE');
}

sub city {
    my ($self, $id) = @_;

    $self->get_user($id, 'CITY');
}

sub phone_home {
    my ($self, $id) = @_;

    $self->get_user($id, 'PHONE_HOME');
}

sub phone_office {
    my ($self, $id) = @_;

    $self->get_user($id, 'PHONE_OFFICE');
}

sub phone_mobile {
    my ($self, $id) = @_;

    $self->get_user($id, 'PHONE_MOBILE');
}

sub homepage {
    my ($self, $id) = @_;

    $self->get_user($id, 'HOMEPAGE');
}

sub about {
    my ($self, $id) = @_;

    $self->get_user($id, 'ABOUT');
}

sub hascallequipment {
    my ($self, $id) = @_;

    $self->get_user($id, 'HASCALLEQUIPMENT');
}

sub is_video_capable {
    my ($self, $id) = @_;

    $self->get_user($id, 'IS_VIDEO_CAPABLE');
}

sub is_voicemail_capable {
    my ($self, $id) = @_;

    $self->get_user($id, 'IS_VOICEMAIL_CAPABLE');
}

sub buddystatus {
    my ($self, $id) = @_;

    $self->get_user($id, 'BUDDYSTATUS');
}

sub isauthorized {
    my ($self, $id) = @_;

    $self->get_user($id, 'ISAUTHORIZED');
}

sub isblocked {
    my ($self, $id) = @_;

    $self->get_user($id, 'ISBLOCKED');
}

sub onlinestatus {
    my ($self, $id) = @_;

    $self->get_user($id, 'ONLINESTATUS');
}

sub skypeout {
    my ($self, $id) = @_;

    $self->get_user($id, 'SKYPEOUT');
}

sub skypeme {
    my ($self, $id) = @_;

    $self->get_user($id, 'SKYPEME');
}

sub lastonlinetimestamp {
    my ($self, $id) = @_;

    $self->get_user($id, 'LASTONLINETIMESTAMP');
}

sub cam_leave_vm {
    my ($self, $id) = @_;

    $self->get_user($id, 'CAM_LEAVE_VM');
}

sub speeddial {
    my ($self, $id) = @_;

    $self->get_user($id, 'SPEEDDIAL');
}

sub receivedauthrequest {
    my ($self, $id) = @_;

    $self->get_user($id, 'RECEIVEDAUTHREQUEST');
}

sub mood_text {
    my ($self, $id) = @_;

    $self->get_user($id, 'MOOD_TEXT');
}

sub rich_mood_text {
    my ($self, $id) = @_;

    $self->get_user($id, 'RICH_MOOD_TEXT');
}

sub aliases {
    my ($self, $id) = @_;

    $self->get_user($id, 'ALIASES');
}

sub timezone {
    my ($self, $id) = @_;

    $self->get_user($id, 'TIMEZONE');
}

sub is_cf_active {
    my ($self, $id) = @_;

    $self->get_user($id, 'IS_CF_ACTIVE');
}

sub nrof_authed_buddies {
    my ($self, $id) = @_;

    $self->get_user($id, 'NROF_AUTHED_BUDDIES');
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
=item languages
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
=item skypeout
=item skypeme
=item lastonlinetimestamp
=item cam_leave_vm
=item speeddial
=item receivedauthrequest
=item mood_text
=item rich_mood_text
=item aliases
=item timezone
=item is_cf_active
=item nrof_authed_buddies

=back


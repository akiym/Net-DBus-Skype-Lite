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

sub property {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET USER $id $property});
    (parse_notification($res))[3];
}

sub handle {
    my ($self, $id) = @_;
    $self->property($id, 'HANDLE');
}

sub fullname {
    my ($self, $id) = @_;
    $self->property($id, 'FULLNAME');
}

sub birthday {
    my ($self, $id) = @_;
    $self->property($id, 'BIRTHDAY');
}

sub sex {
    my ($self, $id) = @_;
    $self->property($id, 'SEX');
}

sub language {
    my ($self, $id) = @_;
    $self->property($id, 'LANGUAGE');
}

sub country {
    my ($self, $id) = @_;
    $self->property($id, 'COUNTRY');
}

sub province {
    my ($self, $id) = @_;
    $self->property($id, 'PROVINCE');
}

sub city {
    my ($self, $id) = @_;
    $self->property($id, 'CITY');
}

sub phone_home {
    my ($self, $id) = @_;
    $self->property($id, 'PHONE_HOME');
}

sub phone_office {
    my ($self, $id) = @_;
    $self->property($id, 'PHONE_OFFICE');
}

sub phone_mobile {
    my ($self, $id) = @_;
    $self->property($id, 'PHONE_MOBILE');
}

sub homepage {
    my ($self, $id) = @_;
    $self->property($id, 'HOMEPAGE');
}

sub about {
    my ($self, $id) = @_;
    $self->property($id, 'ABOUT');
}

sub hascallequipment {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'HASCALLEQUIPMENT');
    $res eq 'TRUE' ? 1 : 0;
}

sub is_video_capable {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'IS_VIDEO_CAPABLE');
    $res eq 'TRUE' ? 1 : 0;
}

sub is_voicemail_capable {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'IS_VOICEMAIL_CAPABLE');
    $res eq 'TRUE' ? 1 : 0;
}

sub buddystatus {
    my ($self, $id) = @_;
    $self->property($id, 'BUDDYSTATUS');
}

sub isauthorized {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'ISAUTHORIZED');
    $res eq 'TRUE' ? 1 : 0;
}

sub isblocked {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'ISBLOCKED');
    $res eq 'TRUE' ? 1 : 0;
}

sub onlinestatus {
    my ($self, $id) = @_;
    $self->property($id, 'ONLINESTATUS');
}

#sub skypeout {
#    my ($self, $id) = @_;
#    $self->property($id, 'SKYPEOUT');
#}

#sub skypeme {
#    my ($self, $id) = @_;
#    $self->property($id, 'SKYPEME');
#}

sub lastonlinetimestamp {
    my ($self, $id) = @_;
    $self->property($id, 'LASTONLINETIMESTAMP');
}

sub can_leave_vm {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'CAN_LEAVE_VM');
    $res eq 'TRUE' ? 1 : 0;
}

sub speeddial {
    my ($self, $id) = @_;
    $self->property($id, 'SPEEDDIAL');
}

sub receivedauthrequest {
    my ($self, $id) = @_;
    $self->property($id, 'RECEIVEDAUTHREQUEST');
}

sub mood_text {
    my ($self, $id) = @_;
    $self->property($id, 'MOOD_TEXT');
}

sub rich_mood_text {
    my ($self, $id) = @_;
    $self->property($id, 'RICH_MOOD_TEXT');
}

sub aliases {
    my ($self, $id) = @_;
    $self->property($id, 'ALIASES');
}

sub timezone {
    my ($self, $id) = @_;
    $self->property($id, 'TIMEZONE');
}

sub is_cf_active {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'IS_CF_ACTIVE');
    $res eq 'TRUE' ? 1 : 0
}

sub nrof_authed_buddies {
    my ($self, $id) = @_;
    $self->property($id, 'NROF_AUTHED_BUDDIES');
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


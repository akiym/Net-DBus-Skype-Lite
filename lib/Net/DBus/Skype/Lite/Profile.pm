package Net::DBus::Skype::Lite::Profile;
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

sub profile { shift }

sub get_profile {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET PROFILE $id $property});
    (parse_res($res))[3];
}

sub pstn_balance {
    my ($self, $id) = @_;

    $self->get_profile($id, 'PSTN_BALANCE');
}

sub pstn_balance_currency {
    my ($self, $id) = @_;

    $self->get_profile($id, 'PSTN_BALANCE_CURRENCY');
}

sub fullname {
    my ($self, $id) = @_;

    $self->get_profile($id, 'FULLNAME');
}

sub birthday {
    my ($self, $id) = @_;

    $self->get_profile($id, 'BIRTHDAY');
}

sub sex {
    my ($self, $id) = @_;

    $self->get_profile($id, 'SEX');
}

sub languages {
    my ($self, $id) = @_;

    $self->get_profile($id, 'LANGUAGES');
}

sub country {
    my ($self, $id) = @_;

    $self->get_profile($id, 'COUNTRY');
}

sub ipcountry {
    my ($self, $id) = @_;

    $self->get_profile($id, 'IPCOUNTRY');
}

sub province {
    my ($self, $id) = @_;

    $self->get_profile($id, 'PROVINCE');
}

sub city {
    my ($self, $id) = @_;

    $self->get_profile($id, 'CITY');
}

sub phone_home {
    my ($self, $id) = @_;

    $self->get_profile($id, 'PHONE_HOME');
}

sub phone_office {
    my ($self, $id) = @_;

    $self->get_profile($id, 'PHONE_OFFICE');
}

sub phone_mobile {
    my ($self, $id) = @_;

    $self->get_profile($id, 'PHONE_MOBILE');
}

sub homepage {
    my ($self, $id) = @_;

    $self->get_profile($id, 'HOMEPAGE');
}

sub about {
    my ($self, $id) = @_;

    $self->get_profile($id, 'ABOUT');
}

sub mood_text {
    my ($self, $id) = @_;

    $self->get_profile($id, 'MOOD_TEXT');
}

sub rich_mood_text {
    my ($self, $id) = @_;

    $self->get_profile($id, 'RICH_MOOD_TEXT');
}

sub timezone {
    my ($self, $id) = @_;

    $self->get_profile($id, 'TIMEZONE');
}

sub call_apply_cf {
    my ($self, $id) = @_;

    $self->get_profile($id, 'CALL_APPLY_CF');
}

sub call_noanswer_rules {
    my ($self, $id) = @_;

    $self->get_profile($id, 'CALL_NOANSWER_RULES');
}

sub call_send_to_vm {
    my ($self, $id) = @_;

    $self->get_profile($id, 'CALL_SEND_TO_VM');
}

sub sms_validated_numbers {
    my ($self, $id) = @_;

    $self->get_profile($id, 'SMS_VALIDATED_NUMBERS');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::Profile

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $profile->[property] >>

    $profile->fullname;

=item pstn_balance
=item pstn_balance_currency
=item fullname
=item birthday
=item sex
=item languages
=item country
=item ipcountry
=item province
=item city
=item phone_home
=item phone_office
=item phone_mobile
=item homepage
=item about
=item mood_text
=item rich_mood_text
=item timezone
=item call_apply_cf
=item call_noanswer_rules
=item call_send_to_vm
=item sms_validated_numbers

=back


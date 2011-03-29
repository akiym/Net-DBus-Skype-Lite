package Net::DBus::Skype::Lite::Profile;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util;
use Class::Trigger;

sub new {
    my ($class, %args) = @_;

    bless {
        property => $args{property},
        value => $args{value},
    }, $class;
}

sub profile { shift }

sub property {
    my ($self, $property) = @_;

    my $res = c->api(qq{GET PROFILE $property});
    (parse_notification($res, 3))[2];
}

sub pstn_balance {
    my ($self) = @_;
    $self->property('PSTN_BALANCE');
}

sub pstn_balance_currency {
    my ($self) = @_;
    $self->property('PSTN_BALANCE_CURRENCY');
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

sub languages {
    my ($self) = @_;
    $self->property('LANGUAGES');
}

sub country {
    my ($self) = @_;
    $self->property('COUNTRY');
}

sub ipcountry {
    my ($self) = @_;
    $self->property('IPCOUNTRY');
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

sub mood_text {
    my ($self) = @_;
    $self->property('MOOD_TEXT');
}

sub rich_mood_text {
    my ($self) = @_;
    $self->property('RICH_MOOD_TEXT');
}

sub timezone {
    my ($self) = @_;
    $self->property('TIMEZONE');
}

sub call_apply_cf {
    my ($self) = @_;
    my $res = $self->property('CALL_APPLY_CF');
    $res eq 'TRUE' ? 1 : 0;
}

sub call_noanswer_timeout {
    my ($self) = @_;
    $self->property('CALL_NOANSWER_TIMEOUT');
}

sub call_forward_rules {
    my ($self) = @_;
    $self->property('CALL_FORWARD_RULES');
}

sub call_send_to_vm {
    my ($self) = @_;
    my $res = $self->property('CALL_SEND_TO_VM');
    $res eq 'TRUE' ? 1 : 0;
}

sub sms_validated_numbers {
    my ($self) = @_;
    $self->property('SMS_VALIDATED_NUMBERS');
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
=item call_noanswer_timeout
=item call_forward_rules
=item call_send_to_vm
=item sms_validated_numbers

=back


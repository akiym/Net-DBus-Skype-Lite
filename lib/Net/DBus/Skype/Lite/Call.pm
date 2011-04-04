package Net::DBus::Skype::Lite::Call;
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

sub call { shift }

sub property {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET CALL $id $property});
    (parse_notification($res))[3];
}

sub set_property {
    my ($self, $property, $value) = @_;

    my $id = $self->{id};
    c->api(qq{SET CALL $id $property $value});
}

sub timestamp {
    my ($self) = @_;
    $self->property('TIMESTAMP');
}

sub partner_handle {
    my ($self) = @_;
    $self->property('PARTNER_HANDLE');
}

sub partner_dispname {
    my ($self) = @_;
    $self->property('PARTNER_DISPNAME');
}

sub target_identity {
    my ($self) = @_;
    $self->property('TARGET_IDENTITY');
}

sub conf_id {
    my ($self) = @_;
    $self->property('CONF_ID');
}

sub type {
    my ($self) = @_;
    $self->property('TYPE');
}

sub status {
    my ($self, $value) = @_;
    if (defined $value) {
        $self->set_property('STATUS', $value);
    } else {
        $self->property('STATUS');
    }
}

sub video_status {
    my ($self) = @_;
    $self->property('VIDEO_STATUS');
}

sub video_send_status {
    my ($self) = @_;
    $self->property('VIDEO_SEND_STATUS');
}

sub failurereason {
    my ($self) = @_;
    $self->property('FAILUREREASON');
}

sub subject {
    my ($self) = @_;
    $self->property('SUBJECT');
}

sub pstn_number {
    my ($self) = @_;
    $self->property('PSTN_NUMBER');
}

sub duration {
    my ($self) = @_;
    $self->property('DURATION');
}

sub pstn_status {
    my ($self) = @_;
    $self->property('PSTN_STATUS');
}

sub conf_participants_count {
    my ($self) = @_;
    $self->property('CONF_PARTICIPANTS_COUNT');
}

sub conf_participant {
    my ($self) = @_;
    $self->property('CONF_PARTICIPANT');
}

sub vm_duration {
    my ($self) = @_;
    $self->property('VM_DURATION');
}

sub vm_allowed_duration {
    my ($self) = @_;
    $self->property('VM_ALLOWED_DURATION');
}

sub rate {
    my ($self) = @_;
    $self->property('RATE');
}

sub rate_currency {
    my ($self) = @_;
    $self->property('RATE_CURRENCY');
}

sub rate_precision {
    my ($self) = @_;
    $self->property('RATE_PRECISION');
}

sub input {
    my ($self) = @_;
    $self->property('INPUT');
}

sub output {
    my ($self) = @_;
    $self->property('OUTPUT');
}

sub capture_mic {
    my ($self) = @_;
    $self->property('CAPTURE_MIC');
}

sub vaa_input_status {
    my ($self) = @_;
    my $res = $self->property('VAA_INPUT_STATUS');
    $res eq 'TRUE' ? 1 : 0;
}

sub forwarded_by {
    my ($self) = @_;
    $self->property('FORWARDED_BY');
}

sub transfer_active {
    my ($self) = @_;
    my $res = $self->property('TRANSFER_ACTIVE');
    $res eq 'TRUE' ? 1 : 0;
}

sub transfer_status {
    my ($self) = @_;
    $self->property('TRANSFER_STATUS');
}

sub transferred_by {
    my ($self) = @_;
    $self->property('TRANSFERRED_BY');
}

sub transferred_to {
    my ($self) = @_;
    $self->property('TRANSFERRED_TO');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::Call

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $call->[property] >>

    $call->timestamp;

=item timestamp
=item partner_handle
=item partner_dispname
=item target_identity
=item conf_id
=item type
=item status
=item video_status
=item video_send_status
=item failurereason
=item subject
=item pstn_number
=item duration
=item pstn_status
=item conf_participants_count
=item conf_participant
=item vm_duration
=item vm_allowed_duration
=item rate
=item rate_currency
=item rate_precision
=item input
=item output
=item capture_mic
=item vaa_input_status
=item forwarded_by
=item transfer_active
=item transfer_status
=item transferred_by
=item transferred_to

=back


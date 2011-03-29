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
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET CALL $id $property});
    (parse_notification($res))[3];
}

sub timestamp {
    my ($self, $id) = @_;
    $self->property($id, 'TIMESTAMP');
}

sub partner_handle {
    my ($self, $id) = @_;
    $self->property($id, 'PARTNER_HANDLE');
}

sub partner_dispname {
    my ($self, $id) = @_;
    $self->property($id, 'PARTNER_DISPNAME');
}

sub target_identity {
    my ($self, $id) = @_;
    $self->property($id, 'TARGET_IDENTITY');
}

sub conf_id {
    my ($self, $id) = @_;
    $self->property($id, 'CONF_ID');
}

sub type {
    my ($self, $id) = @_;
    $self->property($id, 'TYPE');
}

sub status {
    my ($self, $id) = @_;
    $self->property($id, 'STATUS');
}

sub video_status {
    my ($self, $id) = @_;
    $self->property($id, 'VIDEO_STATUS');
}

sub video_send_status {
    my ($self, $id) = @_;
    $self->property($id, 'VIDEO_SEND_STATUS');
}

sub failurereason {
    my ($self, $id) = @_;
    $self->property($id, 'FAILUREREASON');
}

sub subject {
    my ($self, $id) = @_;
    $self->property($id, 'SUBJECT');
}

sub pstn_number {
    my ($self, $id) = @_;
    $self->property($id, 'PSTN_NUMBER');
}

sub duration {
    my ($self, $id) = @_;
    $self->property($id, 'DURATION');
}

sub pstn_status {
    my ($self, $id) = @_;
    $self->property($id, 'PSTN_STATUS');
}

sub conf_participants_count {
    my ($self, $id) = @_;
    $self->property($id, 'CONF_PARTICIPANTS_COUNT');
}

sub conf_participant {
    my ($self, $id) = @_;
    $self->property($id, 'CONF_PARTICIPANT');
}

sub vm_duration {
    my ($self, $id) = @_;
    $self->property($id, 'VM_DURATION');
}

sub vm_allowed_duration {
    my ($self, $id) = @_;
    $self->property($id, 'VM_ALLOWED_DURATION');
}

sub rate {
    my ($self, $id) = @_;
    $self->property($id, 'RATE');
}

sub rate_currency {
    my ($self, $id) = @_;
    $self->property($id, 'RATE_CURRENCY');
}

sub rate_precision {
    my ($self, $id) = @_;
    $self->property($id, 'RATE_PRECISION');
}

sub input {
    my ($self, $id) = @_;
    $self->property($id, 'INPUT');
}

sub output {
    my ($self, $id) = @_;
    $self->property($id, 'OUTPUT');
}

sub capture_mic {
    my ($self, $id) = @_;
    $self->property($id, 'CAPTURE_MIC');
}

sub vaa_input_status {
    my ($self, $id) = @_;
    my $res = $self->property($id, 'VAA_INPUT_STATUS');
    $res eq 'TRUE' ? 1 : 0;
}

sub forwarded_by {
    my ($self, $id) = @_;
    $self->property($id, 'FORWARDED_BY');
}

sub transfer_active {
    my ($self, $id) = @_;
    $self->property($id, 'TRANSFER_ACTIVE');
}

sub transfer_status {
    my ($self, $id) = @_;
    $self->property($id, 'TRANSFER_STATUS');
}

sub transferred_by {
    my ($self, $id) = @_;
    $self->property($id, 'TRANSFERRED_BY');
}

sub transferred_to {
    my ($self, $id) = @_;
    $self->property($id, 'TRANSFERRED_TO');
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


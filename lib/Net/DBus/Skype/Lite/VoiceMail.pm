package Net::DBus::Skype::Lite::VoiceMail;
use strict;
use warnings;
use Net::DBus::Skype::Lite::Context;
use Net::DBus::Skype::Lite::Util;

sub new {
    my ($class, %args) = @_;

    bless {
        id => $args{id},
        property => $args{property},
        value => $args{value},
    }, $class;
}

sub voicemail { shift }

sub property {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET VOICEMAIL $id $property});
    (parse_notification($res))[3];
}

sub type {
    my ($self, $id) = @_;
    $self->property($id, 'TYPE');
}

sub partner_handle {
    my ($self, $id) = @_;
    $self->property($id, 'PARTNER_HANDLE');
}

sub partner_dispname {
    my ($self, $id) = @_;
    $self->property($id, 'PARTNER_DISPNAME');
}

sub status {
    my ($self, $id) = @_;
    $self->property($id, 'STATUS');
}

sub failurereason {
    my ($self, $id) = @_;
    $self->property($id, 'FAILUREREASON');
}

sub subject {
    my ($self, $id) = @_;
    $self->property($id, 'SUBJECT');
}

sub timestamp {
    my ($self, $id) = @_;
    $self->property($id, 'TIMESTAMP');
}

sub duration {
    my ($self, $id) = @_;
    $self->property($id, 'DURATION');
}

sub allowed_duration {
    my ($self, $id) = @_;
    $self->property($id, 'ALLOWED_DURATION');
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

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::VoiceMail

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $voicemail->[property] >>

    $voicemail->type;

=item type
=item partner_handle
=item partner_dispname
=item status
=item failurereason
=item subject
=item timestamp
=item duration
=item allowed_duration
=item input
=item output
=item capture_mic

=back


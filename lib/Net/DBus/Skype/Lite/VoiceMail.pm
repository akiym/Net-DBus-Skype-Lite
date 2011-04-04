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
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET VOICEMAIL $id $property});
    (parse_notification($res))[3];
}

sub type {
    my ($self) = @_;
    $self->property('TYPE');
}

sub partner_handle {
    my ($self) = @_;
    $self->property('PARTNER_HANDLE');
}

sub partner_dispname {
    my ($self) = @_;
    $self->property('PARTNER_DISPNAME');
}

sub status {
    my ($self) = @_;
    $self->property('STATUS');
}

sub failurereason {
    my ($self) = @_;
    $self->property('FAILUREREASON');
}

sub subject {
    my ($self) = @_;
    $self->property('SUBJECT');
}

sub timestamp {
    my ($self) = @_;
    $self->property('TIMESTAMP');
}

sub duration {
    my ($self) = @_;
    $self->property('DURATION');
}

sub allowed_duration {
    my ($self) = @_;
    $self->property('ALLOWED_DURATION');
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


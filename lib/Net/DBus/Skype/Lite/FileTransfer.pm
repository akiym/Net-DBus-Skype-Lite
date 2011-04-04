package Net::DBus::Skype::Lite::FileTransfer;
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

sub filetransfer { shift }

sub property {
    my ($self, $property) = @_;

    my $id = $self->{id};
    my $res = c->api(qq{GET FILETRANSFER $id $property});
    (parse_notification($res))[3];
}

sub type {
    my ($self) = @_;
    $self->property('TYPE');
}

sub status {
    my ($self) = @_;
    $self->property('STATUS');
}

sub failusereason {
    my ($self) = @_;
    $self->property('FAILUSEREASON');
}

sub partner_handle {
    my ($self) = @_;
    $self->property('PARTNER_HANDLE');
}

sub partner_dispname {
    my ($self) = @_;
    $self->property('PARTNER_DISPNAME');
}

sub starttime {
    my ($self) = @_;
    $self->property('STARTTIME');
}

sub finishtime {
    my ($self) = @_;
    $self->property('FINISHTIME');
}

sub filepath {
    my ($self) = @_;
    $self->property('FILEPATH');
}

sub filesize {
    my ($self) = @_;
    $self->property('FILESIZE');
}

sub bytespersecond {
    my ($self) = @_;
    $self->property('BYTESPERSECOND');
}

sub bytestransferred {
    my ($self) = @_;
    $self->property('BYTESTRANSFERRED');
}


1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::FileTransfer

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $filetransfer->[property] >>

    $filetransfer->type;

=item type
=item status
=item failusereason
=item partner_handle
=item partner_dispname
=item starttime
=item finishtime
=item filepath
=item filesize
=item bytespersecond
=item bytestransferred


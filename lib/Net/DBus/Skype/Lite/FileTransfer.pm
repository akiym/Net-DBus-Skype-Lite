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

sub get_filetransfer {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET FILETRANSFER $id $property});
    (parse_notification($res))[3];
}

sub type {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'TYPE');
}

sub status {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'STATUS');
}

sub failusereason {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'FAILUSEREASON');
}

sub partner_handle {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'PARTNER_HANDLE');
}

sub partner_dispname {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'PARTNER_DISPNAME');
}

sub starttime {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'STARTTIME');
}

sub finishtime {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'FINISHTIME');
}

sub filepath {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'FILEPATH');
}

sub filesize {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'FILESIZE');
}

sub bytespersecond {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'BYTESPERSECOND');
}

sub bytestransferred {
    my ($self, $id) = @_;

    $self->get_filetransfer($id, 'BYTESTRANSFERRED');
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


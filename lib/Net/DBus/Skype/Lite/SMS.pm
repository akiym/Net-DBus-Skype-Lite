package Net::DBus::Skype::Lite::SMS;
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

sub sms { shift }

sub get_sms {
    my ($self, $id, $property) = @_;
    $id ||= $self->{id};

    my $res = c->api(qq{GET SMS $id $property});
    (parse_res($res))[3];
}

sub body {
    my ($self, $id) = @_;

    $self->get_sms($id, 'BODY');
}

sub type {
    my ($self, $id) = @_;

    $self->get_sms($id, 'TYPE');
}

sub status {
    my ($self, $id) = @_;

    $self->get_sms($id, 'STATUS');
}

sub failurereason {
    my ($self, $id) = @_;

    $self->get_sms($id, 'FAILUREREASON');
}

sub is_failed_unseen {
    my ($self, $id) = @_;

    my $res = $self->get_sms($id, 'IS_FAILED_UNSEEN');
    $res eq 'TRUE' ? 1 : 0;
}

sub timestamp {
    my ($self, $id) = @_;

    $self->get_sms($id, 'TIMESTAMP');
}

sub price {
    my ($self, $id) = @_;

    $self->get_sms($id, 'PRICE');
}

sub price_precision {
    my ($self, $id) = @_;

    $self->get_sms($id, 'PRICE_PRECISION');
}

sub price_currency {
    my ($self, $id) = @_;

    $self->get_sms($id, 'PRICE_CURRENCY');
}

sub reply_to_number {
    my ($self, $id) = @_;

    $self->get_sms($id, 'REPLY_TO_NUMBER');
}

sub target_numbers {
    my ($self, $id) = @_;

    $self->get_sms($id, 'TARGET_NUMBERS');
}

sub target_statuses {
    my ($self, $id) = @_;

    $self->get_sms($id, 'TARGET_STATUSES');
}

1;
__END__

=head1 NAME

Net::DBus::Skype::Lite::SMS

=head1 SYNOPSIS

=head1 METHODS

=over 4

=item C<< $sms->[property] >>

    $sms->body;

=item body
=item type
=item status
=item failurereason
=item is_failed_unseen
=item timestamp
=item price
=item price_precision
=item price_currency
=item reply_to_number
=item target_numbers
=item target_statuses

=back


use strict;
use warnings;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), '..', 'lib');
use Net::DBus::Skype::Lite;
use Term::ReadLine;
use Data::Dumper;

my $skype = Net::DBus::Skype::Lite->new();

my $term = Term::ReadLine->new('Skype shell');
while (defined(my $cmd = $term->readline('skype> '))) {
    exit if $cmd eq 'exit';
    print $skype->api($cmd), "\n";
}

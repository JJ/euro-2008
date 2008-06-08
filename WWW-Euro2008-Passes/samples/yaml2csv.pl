#!/usr/bin/perl

use lib qw( lib ../lib );

use WWW::Euro2008::Passes qw( extract_statistics next_URL );

use YAML qw(LoadFile);

my $file = shift;
my $pases = LoadFile( $file ) || die "Can't load file: $@\n";


my @jugadores = keys %$pases;
print ";", join(";", @jugadores ), "\n";
for my $p (@jugadores ) {
    print "$p";
    for my $o (@jugadores ) {
	print ";", $pases->{$o}{$p}; 
    }
    print "\n";
}

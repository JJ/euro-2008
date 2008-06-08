#!/usr/bin/perl

use lib qw( lib ../lib );

use WWW::Euro2008::Passes qw( extract_statistics next_URL );

use YAML qw(LoadFile);

my $file = shift;
my $pases = LoadFile( $file ) || die "Can't load file: $@\n";


my @jugadores = keys %$pases;
my %map;
for my $j (1..@jugadores ) {
    $map{$jugadores[$j-1]}=$j;
}
print "*Vertices ", scalar @jugadores, "\n", 
    join("\n", map( $map{$_}." \"$_\"", @jugadores ));
print "\n*Arcs\n";
for my $p (@jugadores ) {
    for my $o (@jugadores ) {
	print "$map{$p} $map{$o} $pases->{$p}{$o}\n" if $pases->{$p}{$o}; 
    }
}

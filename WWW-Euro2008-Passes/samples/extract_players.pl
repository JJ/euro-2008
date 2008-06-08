#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp qw(read_file);
use YAML qw(Dump DumpFile);

my $file = shift || die "No file\n";

my $text = read_file( $file ) || die "Can't load: $@\n";
my @players = ($text =~ m{<li id="\S+">(.+?)</li>}gs);

my %player_hash;
for my $p (@players) {
    my ($number, $name ) = ($p =~ m{(\d+) <a href="[^"]+">([^<]+)\s»</a>}g);
    $player_hash{$name} = $number;
}

print Dump( \%player_hash );
print DumpFile( 'sp.yaml', \%player_hash);

#!/usr/bin/perl

use lib qw( lib ../lib );

use WWW::Euro2008::Passes qw( extract_statistics next_URL );

use YAML qw(LoadFile);
use File::Slurp qw(write_file);
use Encode qw(is_utf8 from_to encode decode);
use Encode::Guess qw/utf8 latin1 iso-8859-1 iso-8859-15/;

my $file = shift || die "Need a file\n";
my $team_1 = shift || die "Team 1 missing\n";
my $team_2 = shift || die "Team 2 missing\n";

my $team_1_hashref = LoadFile( "$team_1.yaml" ) || die "Can't open $team_1: $@\n";
my $team_2_hashref = LoadFile( "$team_2.yaml" ) || die "Can't open $team_2: $@\n";

my $pases = LoadFile( $file ) || die "Can't load file: $@\n";

my ($base) = ( $file =~ /(.+)\.yaml/ );

my @jugadores = keys %$pases;
my %map;
for my $j (1..@jugadores ) {
    $map{$jugadores[$j-1]}=$j;
}
my $output = "*Vertices ". scalar @jugadores. "\n";

for my $j ( 1..@jugadores ) {
    my $this_guy = $jugadores[$j-1];
    $output .= "$j \"$this_guy\" 0.0 0.0 ". 
	($team_1_hashref->{$this_guy}?"circle":"box")." ".
	"ic ".($team_1_hashref->{$this_guy}?"green":"red")."\n";   
} 

$output .= "*Arcs\n";
for my $p (@jugadores ) {
    for my $o (@jugadores ) {
	$output .= "$map{$p} $map{$o} $pases->{$p}{$o}\n" if $pases->{$p}{$o}; 
    }
}

write_file( "$base.net", $output );



#!/usr/bin/perl

use strict;
use warnings;

use lib qw( ../lib );

use File::Slurp qw(read_file);
use YAML qw(Dump DumpFile);
use LWP::Simple qw(get);
use WWW::Euro2008::Passes qw(extract_players);

my $code = shift || die "Need team Euro 2008 code\n";

my $base_URL = "http://www.euro2008.uefa.com/tournament/teams/team=$code/index.html";
my $texto = get( $base_URL ) || die "Can't download: $@\n";

my ($country_name ) = ( $texto =~ /Teams - ([^<]+)</ );
my $player_hashref = extract_players( $texto );


print Dump( $player_hashref );
print DumpFile( "$country_name.yaml", $player_hashref);

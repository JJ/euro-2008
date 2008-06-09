#!/usr/bin/perl

use lib qw( lib ../lib );

use WWW::Euro2008::Passes qw( extract_statistics next_URL );
use LWP::Simple qw(get);
use YAML qw(Dump DumpFile);
my $base_URL = 'http://www.euro2008.uefa.com/tournament/statistics/players/typestat=PD/';
my $this_URL = 'index.html';

my %pares;
my $texto;
do {
  my $texto_URL = "$base_URL$this_URL";
  print "Downloading $texto_URL\n";
  $texto = get( $texto_URL ) || die "No hay fichero";
  extract_statistics( $texto, \%pares );
} while ( $this_URL = next_URL( $texto ) );

print Dump( \%pares );
DumpFile( 'jun-9.yaml', \%pares);




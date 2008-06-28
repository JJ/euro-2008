#!/usr/bin/perl

use strict;
use warnings;

use lib qw( ../lib );

use File::Slurp qw(read_file);
use YAML qw(Dump DumpFile);
use LWP::Simple qw(get);
use WWW::Euro2008::Passes qw(extract_statistics_team download_team_passing_statistics);

my $code = shift || die "Need team Euro 2008 code\n";


my $texto = download_team_passing_statistics( $code );

my ($country_name ) = ( $texto =~ /Teams - ([^<]+)</ );
my $passes_hashref = extract_statistics_team( $texto );


print Dump( $passes_hashref );
print DumpFile( "passes-$country_name.yaml", $passes_hashref);

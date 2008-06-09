#!/usr/bin/perl

use strict;
use warnings;

use lib qw( ../lib );

use File::Slurp qw(read_file);
use YAML qw(LoadFile DumpFile);

my $day_1 = shift || die "No day 1\n";
my $day_2 = shift || die "No day 2\n";


my $day_1_hashref = LoadFile( "$day_1.yaml" ) || die "Can't open $day_1: $@\n";
my $day_2_hashref = LoadFile( "$day_2.yaml" ) || die "Can't open $day_1: $@\n";

#Day 2 supposed to be newer
my %diff_hash;
for my $p ( keys %$day_2_hashref ) {
  for my $q ( keys %{$day_2_hashref->{$p}} ) {
    if ( $day_1_hashref->{$p}{$q} ) {
      if ( $day_2_hashref->{$p}{$q} - $day_1_hashref->{$p}{$q} ) {
	$diff_hash{$p}{$q} = $day_2_hashref->{$p}{$q} - $day_1_hashref->{$p}{$q}
      } 
    } else {
      $diff_hash{$p}{$q} = $day_2_hashref->{$p}{$q}
    }
  }
}


DumpFile( "$day_2-$day_1.yaml", \%diff_hash );



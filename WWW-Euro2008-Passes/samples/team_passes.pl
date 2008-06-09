#!/usr/bin/perl

use strict;
use warnings;

use lib qw( ../lib );

use File::Slurp qw(read_file);
use YAML qw(LoadFile DumpFile);

my $team = shift || die "No team\n";
my $passes = shift || die "No passes\n";

my $team_hashref = LoadFile( "$team.yaml" ) || die "Can't open $team: $@\n";
my $passes_hashref = LoadFile( "$passes.yaml" ) || die "Can't open $passes: $@\n";

my %these_passes;
for my $p ( keys %$passes_hashref ) {
  my ($number, $name ) = split(/\s+-\s+/, $p );
  if ( $team_hashref->{$name} ) {
    for my $q ( keys %{$passes_hashref->{$p}} ) {
      my ($o_number, $o_name ) = split(/\s+-\s+/, $q );
      if ( $team_hashref->{$o_name} ) {
	$these_passes{$name}{$o_name} = $passes_hashref->{$p}{$q};
      }
    }
  }
}

DumpFile( "$team-$passes.yaml", \%these_passes );


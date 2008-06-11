#!/usr/bin/perl

#Extracts passes within a team and cuts by two teams
use strict;
use warnings;

use lib qw( ../lib );

use File::Slurp qw(read_file);
use YAML qw(LoadFile DumpFile);

my $team_1 = shift || die "No team\n";
my $team_2 = shift || die "No second team\n";
my $passes = shift || die "No passes\n";

my $team_1_hashref = LoadFile( "$team_1.yaml" ) || die "Can't open $team_1: $@\n";
my $team_2_hashref = LoadFile( "$team_2.yaml" ) || die "Can't open $team_2: $@\n";

my $passes_hashref = LoadFile( "$passes.yaml" ) || die "Can't open $passes: $@\n";

my %these_passes;
for my $p ( keys %$passes_hashref ) {
  my ($number, $name ) = split(/\s+-\s+/, $p );
  if ( $team_1_hashref->{$name} || $team_2_hashref->{$name} ) {
    for my $q ( keys %{$passes_hashref->{$p}} ) {
      my ($o_number, $o_name ) = split(/\s+-\s+/, $q );
      if ( $team_1_hashref->{$o_name} || $team_2_hashref->{$o_name}) {
	$these_passes{$name}{$o_name} = $passes_hashref->{$p}{$q};
      }
    }
  }
}

DumpFile( "$team_1-$team_2-$passes.yaml", \%these_passes );


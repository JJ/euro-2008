package WWW::Euro2008::Passes;

use warnings;
use strict;
use Carp;
use LWP::Simple qw(get);

use version; our $VERSION = qv('0.0.3');
require Exporter;


# Other recommended modules (uncomment to use):
#  use IO::Prompt;
#  use Perl6::Export;
#  use Perl6::Slurp;
#  use Perl6::Say;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(download_team_passing_statistics extract_statistics extract_statistics_team next_URL extract_statistics_country extract_players);  # symbols to export on request


# Module implementation here

sub download_team_passing_statistics {
    my $team_id = shift || croak "No team here";
    my $url = "http://www.euro2008.uefa.com/tournament/teams/team=$team_id/statistics/distribution.html";
    my $text = get( $url ) || croak  "Problems downloading $url: $@";
    return $text;
}

sub extract_statistics_team {
    my $text  = shift;
    my @pairs = ($text =~ m{<td class="pName">([^<]+)</td><td class="pTot">(\d+)</td>}gs);
    return extract_pairs( @pairs );
    
}

sub extract_statistics {
    my $text  = shift;
    my @pairs = ($text =~ m{<td class="tdPlayerStats" style="[^"]+">([^<]+)</td><td class="valueNoBold">(\d+)</td>}gs);
    return extract_pairs( @pairs );
}

sub extract_pairs {
    my $pares_ref;
    my @pairs = @_;
    while ( @pairs )  {
	my ( $pareja, $pases ) = splice( @pairs, 0, 2 );
	my ( $menda, $otro_menda ) = ($pareja =~ /(\d+\s+-[^-]+)\s+-\s+(\d+\s+-[^-]+)/);
	$pares_ref->{$menda}{$otro_menda}=$pases;
    }
    return $pares_ref;
}


sub extract_statistics_country {
    my $text  = shift;
    my $pares_ref = shift;
    my $country = shift || croak "No country";
    my @pairs = ($text =~ m{<td class="tdPlayerStats" style="[^"]+">([^<]+)</td><td class="valueNoBold">(\d+)</td><td class="\S+">([^<]+)</td}gs);
    my %pares;
    while ( @pairs )  {
	my ( $pareja, $pases, $this_country ) = splice( @pairs, 0, 3 );
	if ( $this_country eq $country ) {
	    my ( $menda, $otro_menda ) = ($pareja =~ /(\d+\s+-[^-]+)\s+-\s+(\d+\s+-[^-]+)/);
	    $pares_ref->{$menda}{$otro_menda}=$pases;
	}
    }
}

sub next_URL {
    my $text = shift;
    if ( $text =~ m{<div class="nextLink"><span><a href="([^"]+)">Next} ) {
	return $1;
    } else {
	return ''
    }
}

sub extract_players {
    my $text = shift;
    my @players = ($text =~ m{<li id="\S+">(.+?)</li>}gs);

    my %player_hash;
    for my $p (@players) {
	my ($number, $name ) = ($p =~ m{(\d+) <a href="[^"]+">([^<]+)\s\S+</a>}g);
        $player_hash{$name} = $number;
    }
return \%player_hash;
    
}


1; # Magic true value required at end of module
__END__

=head1 NAME

WWW::Euro2008::Passes - [One line description of module's purpose here]


=head1 VERSION

This document describes WWW::Euro2008::Passes version 0.0.1


=head1 SYNOPSIS

    use WWW::Euro2008::Passes;

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.
  
  
=head1 DESCRIPTION

=for author to fill in:
    Write a full description of the module and its features here.
    Use subsections (=head2, =head3) as appropriate.


=head1 INTERFACE 

=for author to fill in:
    Write a separate section listing the public components of the modules
    interface. These normally consist of either subroutines that may be
    exported, or methods that may be called on objects belonging to the
    classes provided by the module.


=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.
  
WWW::Euro2008::Passes requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-www-euro2008-passes@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

JJ Merelo  C<< <jj@merelo.net> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, JJ Merelo C<< <jj@merelo.net> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

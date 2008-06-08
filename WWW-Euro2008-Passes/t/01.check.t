use Test::More tests => 2;

use lib qw( lib ../lib );

use WWW::Euro2008::Passes qw( extract_statistics extract_statistics_country );
use File::Slurp qw(read_file);

my $texto_file = 'pd-8-jun.html';
my $texto = read_file( $texto_file ) || die "No hay fichero";
my %pares;
extract_statistics( $texto,\%pares );

ok( scalar %pares eq '12/32' , 'OK' );
my %nones;
extract_statistics_country($texto, \%nones, 'Portugal');
ok( scalar %nones eq '3/8', 'OK by country');

diag( "Testing WWW::Euro2008::Passes $WWW::Euro2008::Passes::VERSION" );

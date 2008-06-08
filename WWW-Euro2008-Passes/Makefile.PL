use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::Euro2008::Passes',
    AUTHOR              => 'JJ Merelo <jj@merelo.net>',
    VERSION_FROM        => 'lib/WWW/Euro2008/Passes.pm',
    ABSTRACT_FROM       => 'lib/WWW/Euro2008/Passes.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-Euro2008-Passes-*' },
);

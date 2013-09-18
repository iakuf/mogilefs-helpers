use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'MogileFS::Helpers',
    AUTHOR              => '扶凯 <iakuf@163.com>',
    EXE_FILES           => ['etc/init.d/mogilefsd', 'etc/init.d/mogstored'],
    PL_FILES            => {},
    LICENSE             => "perl",
    DISTNAME            => 'MogileFS-Helpers',
    VERSION             => "0.01",
    ABSTRACT_FROM       => 'lib/MogileFS/Helpers.pod',
    PREREQ_PM => {
        'MogileFS::Server' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'MogileFS-Helpers-*' },
    META_MERGE => {
        resources => {
            repository => 'https://github.com/iakuf/mogilefs-helpers',
        },
    },
);

sub MY::postamble {
    my $self = shift;
    my @install;
    for my $path (qw#/etc/mogilefs/ /var/mogdata/#) {
        push (@install, "\t\$(MKPATH) $path",)
    }
    for my $config (qw/mogilefs.conf mogilefsd.conf mogstored.conf/) {
        push ( @install, 
            "install:: etc/mogilefs/$config",
            '',
            "\t \$(CP) etc/mogilefs/$config /etc/mogilefs/$config",
        );
    }

    return join("\n", @install);
}

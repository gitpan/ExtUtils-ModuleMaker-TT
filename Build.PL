use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'ExtUtils::ModuleMaker::TT',
	  dist_author     => 'David A. Golden <david@dagolden.com>',
      license         => 'perl',
	  requires        => { ExtUtils::ModuleMaker => 0.32,
						   Template => 2.13,
						   Cwd => 2.12,
						   File::Path => 1.06,
						   Getopt::Long => 2.34,
						   Pod::Usage => 1.00,
						   Config::General => 2.19,
						   File::Basename => 0,
						   File::Spec::Functions => 1.3,
						   Data::Dumper => 2.121,
						 },
	  build_requires  => { Test::Distribution => 1.11, 
	                       Module::Build => 0.24,
						 },
	  script_files    => [ 'scripts/makeperlmod' ],
    )->create_build_script;

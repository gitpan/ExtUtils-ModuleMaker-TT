use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'ExtUtils::ModuleMaker::TT',
	  dist_author     => 'David A Golden <dagolden@cpan.org>',
      create_makefile_pl => "traditional",
      create_readme => 1,
      license         => 'perl',
	  requires        => { 
          ExtUtils::ModuleMaker => 0.32,
          Template => 2.13,
          Cwd => 2.12,
          File::Path => 1.06,
          File::Spec => 0.87,
          File::Spec::Functions => 1.3,
          Getopt::Long => 2.34,
          Pod::Usage => 1.00,
          Config::General => 2.19,
          File::Basename => 0,
          Data::Dumper => 2.121,
      },
	  build_requires  => { 
          File::Temp => 0.16, 
          Test::More => 0.54,
          Test::Pod => 1.20,
          Test::Pod::Coverage => 1.06,
      },
	  script_files    => [ 'scripts/makeperlmod' ],
    )->create_build_script;

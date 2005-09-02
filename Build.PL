use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'ExtUtils::ModuleMaker::TT',
	  dist_author     => 'David A Golden <dagolden@cpan.org>',
      create_makefile_pl => "traditional",
      create_readme => 1,
      license         => 'perl',
	  requires        => { 
          ExtUtils::ModuleMaker => 0.36,
          Template => 2.13,
          Cwd => 2.12,
          File::Path => 1.06,
          File::Spec => 0.87,
          File::Spec::Functions => 1.3,
          Getopt::Long => 0,
          Pod::Usage => 1.00,
          Config::General => 2.19,
          File::Basename => 0,
          Data::Dumper => 2.121,
          File::Temp => 0.16, 
          Test::More => 0.47,
      },
	  scripts    => { 'scripts/makeperlmod' => 1 },
    )->create_build_script;

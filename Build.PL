use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'ExtUtils::ModuleMaker::TT',
	  dist_author     => 'David A Golden <dagolden@cpan.org>',
      create_makefile_pl => "traditional",
      create_readme => 1,
      license         => 'perl',
	  requires        => { 
          Config::General => 2.30,
          Cwd => 3.11, 
          Data::Dumper => 2.121,
          ExtUtils::ModuleMaker => 0.43,
          File::Basename => 2.73,
          File::Path => 1.06,
          File::pushd => 0.24,
          File::Spec => 3.11,
          File::Temp => 0.16, 
          Getopt::Long => 2.2,
          IPC::Run3 => 0.031,
          Module::Build => 0.2703,
          Path::Class => 0.13,
          Pod::Usage => 1.33,
          Probe::Perl => 0.01,
          Template => 2.14,
          Test::More => 0.48,
      },
	  scripts    => { 'scripts/makeperlmod' => 1 },
    )->create_build_script;

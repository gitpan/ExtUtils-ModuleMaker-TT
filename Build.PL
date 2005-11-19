use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'ExtUtils::ModuleMaker::TT',
	  dist_author     => 'David A Golden <dagolden@cpan.org>',
      create_makefile_pl => "traditional",
      create_readme   => 1,
      license         => 'perl',
	  requires        => { 
          Config::Find => 0.22,
          Config::General => 2.29,
          Data::Dumper => 0,
          ExtUtils::ModuleMaker => 0.43,
          File::Copy => 0,
          File::pushd => 0.24,
          Getopt::Long => 0,
          IPC::Run3 => 0.033,
          Path::Class => 0.13,
          Pod::Usage => 0,
          Probe::Perl => 0.01,
          Template => 2.14,
          Test::More => 0.48, # thread safe
      },
	  scripts    => { 'scripts/makeperlmod' => 1 },
    )->create_build_script;

# t/06_singlepm.t -- tests creation of a single .pm in an existing distribution
# tree

#use Test::More qw/no_plan/;
use Test::More tests => 15;
use File::Temp qw( tempdir );
use Cwd;

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
my $tempdir = tempdir( CLEANUP => 1 );
ok ($tempdir, "making tempdir $tempdir");
my $orig_dir = cwd();
ok (chdir $tempdir, "chdir $tempdir");

###########################################################################

my $MOD;

ok ($MOD  = ExtUtils::ModuleMaker::TT->new
			(
				NAME		=> 'Sample::Module::Foo',
				COMPACT		=> 1,
				LICENSE		=> 'looselips',
				BUILD_SYSTEM => 'Module::Build'
			),
	"call ExtUtils::ModuleMaker::TT->new");

ok ($MOD->complete_build (),
	"call \$MOD->complete_build");
	
ok (chdir 'Sample-Module-Foo',
	"cd Sample-Module-Foo");

ok ($MOD->build_single_pm({ NAME => 'Sample::Module::Bar'}),
	"call \$MOD->build_single_pm");

ok ( -e 'lib/Sample/Module/Bar.pm' ,
	"new module file successfully created");

ok ( -e 't/Sample_Module_Bar.t',
	"new test file successfully created");

###########################################################################

# test from a deep directory

my $tgtdir = 'lib/Sample/Module';
ok (chdir $tgtdir,
	"cd $tgtdir");

ok ($MOD  = ExtUtils::ModuleMaker::TT->new
			(
				NAME		=> 'Sample::Module::Foo',
				COMPACT		=> 1,
				LICENSE		=> 'looselips',
				BUILD_SYSTEM => 'Module::Build'
			),
	"call ExtUtils::ModuleMaker::TT->new");

ok ($MOD->build_single_pm({ NAME => 'Sample::Module::Bar'}),
	"call \$MOD->build_single_pm");

ok ( -e ($MOD->{Base_Dir} . "/lib/Sample/Module/Bar.pm") ,
	"new module file successfully created");

ok ( -e ($MOD->{Base_Dir} . "/t/Sample_Module_Bar.t"),
	"new test file successfully created");


ok (chdir $orig_dir, "chdir $orig_dir");

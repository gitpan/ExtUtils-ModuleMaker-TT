# t/06_singlepm.t -- tests creation of a single .pm in an existing distribution
# tree

#use Test::More qw/no_plan/;
use Test::More tests => 11;

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
ok (chdir 'blib/testing' || chdir '../blib/testing', "chdir 'blib/testing'");

###########################################################################

my $MOD;

ok ($MOD  = ExtUtils::ModuleMaker::TT->new
			(
				NAME		=> 'Sample::Module::Foo',
				COMPACT		=> 1,
				LICENSE		=> 'looselips',
			),
	"call ExtUtils::ModuleMaker::TT->new");
	
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

$MOD->{Base_Dir} = undef;

ok (chdir '../Sample/Module/lib/Sample',
	"cd ../Sample/Module/lib/Sample");

ok ($MOD->build_single_pm({ NAME => 'Sample::Module::Bar'}),
	"call \$MOD->build_single_pm");

ok ( -e ($MOD->{Base_Dir} . "/lib/Sample/Module/Bar.pm") ,
	"new module file successfully created");

ok ( -e ($MOD->{Base_Dir} . "/t/Sample_Module_Bar.t"),
	"new test file successfully created");



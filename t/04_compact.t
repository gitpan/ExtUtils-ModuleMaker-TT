# t/04_compact.t -- tests a compact build, a different license text and
# a Module::Build build system

#use Test::More qw/no_plan/;
use Test::More tests => 18;
use File::Temp qw( tempdir );

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
my $tempdir = tempdir( CLEANUP => 1 );
ok ($tempdir, "making tempdir $tempdir");
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

###########################################################################

ok (chdir 'Sample-Module-Foo',
	"cd Sample-Module-Foo");

#        MANIFEST.SKIP .cvsignore
for (qw( Changes MANIFEST MANIFEST.SKIP Build.PL LICENSE
		README lib lib/Sample/Module/Foo.pm t t/Sample_Module_Foo.t )) {
    ok (-e,
		"$_ exists");
}

###########################################################################

ok (open (FILE, 'LICENSE'),
	"reading 'LICENSE'");
my $filetext = do {local $/; <FILE>};
close FILE;

ok ($filetext =~ m/Loose lips sink ships/,
	"correct LICENSE generated");

###########################################################################


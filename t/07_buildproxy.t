# t/07_buildproxy.t -- tests Module::Build and Proxy

#use Test::More qw/no_plan/;
use Test::More tests => 19;
use File::Temp qw( tempdir );

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
my $tempdir = tempdir( CLEANUP => 1 );
ok ($tempdir, "making tempdir $tempdir");
ok (chdir $tempdir, "chdir $tempdir");

###########################################################################

my $MOD;

ok ($MOD  = ExtUtils::ModuleMaker::TT->new
			(
				NAME		=> 'Another::Module::Foo',
				COMPACT		=> 1,
				LICENSE		=> 'looselips',
				BUILD_SYSTEM => 'Module::Build and Proxy'
			),
	"call ExtUtils::ModuleMaker::TT->new");
	
ok ($MOD->complete_build (),
	"call \$MOD->complete_build");

###########################################################################

ok (chdir 'Another-Module-Foo',
	"cd Another-Module-Foo");

for (qw( Changes MANIFEST MANIFEST.SKIP Build.PL Makefile.PL LICENSE
		README lib lib/Another/Module/Foo.pm t t/Another_Module_Foo.t )) {
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


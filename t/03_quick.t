# t/03_quick.t -- tests a quick build with minimal options

#use Test::More qw/no_plan/;
use Test::More tests => 19;
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
				NAME		=> 'Sample::Module',
			),
	"call ExtUtils::ModuleMaker::TT->new");
	
ok ($MOD->complete_build (),
	"call \$MOD->complete_build");

###########################################################################

ok (chdir 'Sample/Module',
	"cd Sample/Module");

#        MANIFEST.SKIP .cvsignore
for (qw( Changes MANIFEST MANIFEST.SKIP Makefile.PL LICENSE
		README lib lib/Sample/Module.pm t t/Sample_Module.t )) {
    ok (-e,
		"$_ exists");
}

###########################################################################

ok (open (FILE, 'LICENSE'),
	"reading 'LICENSE'");
my $filetext = do {local $/; <FILE>};
close FILE;

ok ($filetext =~ m/Terms of Perl itself/,
	"correct LICENSE generated");

###########################################################################

ok (chdir $orig_dir, "chdir $orig_dir");


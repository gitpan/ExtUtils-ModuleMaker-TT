# t/03_quick.t -- tests a quick build with minimal options

#use Test::More qw/no_plan/;
use Test::More tests => 16;
use File::pushd;

BEGIN { use_ok( 'ExtUtils::ModuleMaker' ); }

{
    my $dir = tempd();

    ok (my $MOD = ExtUtils::ModuleMaker->new (
            NAME => 'Sample::Module',
            ALT_BUILD => 'ExtUtils::ModuleMaker::TT',
            TEST_NAME_DERIVED_FROM_MODULE_NAME => 1,
            INCLUDE_MANIFEST_SKIP => 1,
        ),
        "create ExtUtils::ModuleMaker with ALT_BUILD");
        
    ok ($MOD->complete_build (),
        "call \$MOD->complete_build");

    ok (chdir 'Sample/Module',
        "cd Sample/Module");

    #        MANIFEST.SKIP .cvsignore
    for (qw( Changes MANIFEST MANIFEST.SKIP Makefile.PL LICENSE
            README lib lib/Sample/Module.pm t t/001_Sample_Module.t )) {
        ok (-e,
            "$_ exists");
    }

    ok (open (FILE, 'LICENSE'),
        "reading 'LICENSE'");
    my $filetext = do {local $/; <FILE>};
    close FILE;

    ok ($filetext =~ m/Terms of Perl itself/,
        "correct LICENSE generated");
}

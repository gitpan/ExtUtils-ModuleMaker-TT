# t/05_template.t -- tests abilty to create template directory

#use Test::More qw/no_plan/;
use Test::More tests => 15;
use File::pushd;

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }

{
    my $dir = tempd();

    ok (ExtUtils::ModuleMaker::TT->create_template_directory('templates'),
        "create_template_directory");

    ###########################################################################

    ok (chdir 'templates',
        "cd templates");

    #        MANIFEST.SKIP .cvsignore
    for ( keys %ExtUtils::ModuleMaker::TT::templates ) {
        ok (-e,
            "$_ exists");
    }

}

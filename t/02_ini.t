# -*- perl -*-

# t/02_ini.t - check module loading and create testing directory

use Test::More tests => 6;

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::Licenses::Standard' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::Licenses::Local' ); }

###########################################################################

BEGIN { use_ok( 'File::Path' ); }

ok (chdir 'blib' || chdir '../blib',
	"chdir 'blib'");

mkpath ('testing', 0, 0775);

ok (chdir 'testing',
	"chdir 'testing'");

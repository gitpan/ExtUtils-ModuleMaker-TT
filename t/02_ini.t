# -*- perl -*-

# t/02_ini.t - check module loading 

use Test::More tests => 3;

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::Licenses::Standard' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::Licenses::Local' ); }

###########################################################################


# -*- perl -*-

# t/02_ini.t - check module loading and create testing directory

use Test::More tests => 5;
use File::Temp qw( tempdir );

BEGIN { use_ok( 'ExtUtils::ModuleMaker::TT' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::Licenses::Standard' ); }
BEGIN { use_ok( 'ExtUtils::ModuleMaker::Licenses::Local' ); }

###########################################################################

my $tempdir = tempdir( CLEANUP => 1 );
ok ($tempdir, "making tempdir $tempdir");
ok (chdir $tempdir, "chdir $tempdir");


# t/05_template.t -- tests abilty to create template directory

#use Test::More qw/no_plan/;
use Test::More tests => 16;
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
			),
	"call ExtUtils::ModuleMaker::TT->new");
	
ok ($MOD->create_template_directory('templates'),
	"call \$MOD->create_template_directory");

###########################################################################

ok (chdir 'templates',
	"cd templates");

#        MANIFEST.SKIP .cvsignore
for ( keys %{ $MOD->{templates}} ) {
    ok (-e,
		"$_ exists");
}



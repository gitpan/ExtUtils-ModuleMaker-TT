# t/05_template.t -- tests abilty to create template directory

#use Test::More qw/no_plan/;
use Test::More tests => 15;

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



use strict;
use warnings;

use Test::More tests => 15; 
use t::CLI;
use File::pushd;
use Path::Class;

BEGIN { 
    use_ok( "ExtUtils::ModuleMaker::Auxiliary",
        qw( _save_pretesting_status _restore_pretesting_status )
    );
}

#--------------------------------------------------------------------------#
# Setup
#--------------------------------------------------------------------------#

$|++;

my $null_default = dir('t/config/empty_default')->absolute;
my $sample_config = dir('t/config/sample')->absolute;

my $cli = t::CLI->new('scripts/makeperlmod');

#--------------------------------------------------------------------------#
# Mask any user defaults for the duration of the program
#--------------------------------------------------------------------------#

# these add 8 tests
my $pretest_status = _save_pretesting_status();
END { _restore_pretesting_status( $pretest_status ) }

#--------------------------------------------------------------------------#
# error if config file doesn't exist
#--------------------------------------------------------------------------#

$cli->dies_ok(qw( -c doesntexist -s foo));
$cli->stderr_like(qr/doesntexist.+does not exist/, "config not found error");

#--------------------------------------------------------------------------#
# set author name and templates via config
#--------------------------------------------------------------------------#

{
    my $dir = tempd;

    # create templates
    $cli->runs_ok(qw( -t templates ));

    # XXX should modify README template here and check after creation
    open( my $fh, ">", file("templates", "README"))
        or die "Couldn't open README template for editing";

    ok( print( $fh "Author: [% AUTHOR %]\n") , 
        "... modified README template");
    close $fh;
    
    # create new dir; sample config specifies templates directory
    $cli->runs_ok('-c', $sample_config, qw(-n Foo::Bar ));

    is( file("Foo-Bar/README")->slurp(chomp=>1), 
        "Author: Warren G. Harding",
        "... custom template filled with custom author name"
    );
    
}
    

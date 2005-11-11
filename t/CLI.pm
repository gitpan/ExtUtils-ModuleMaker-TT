package t::CLI;
use strict;
use warnings;

use Test::Builder;
use Probe::Perl;
use IPC::Run3;
use File::Basename qw(fileparse);
use Cwd;
use Path::Class;

my $Test = Test::Builder->new;
my $pp = Probe::Perl->new;
my $perl = file($pp->find_perl_interpreter)->absolute;
my $cwd = cwd;

#--------------------------------------------------------------------------#
# Main API
#--------------------------------------------------------------------------#

sub new {
    my ($class, $program, @default_args ) = @_;
    my $self = bless {}, $class;
    $self->program( $program );
    $self->default_args( [@default_args] );
    return $self;
}

# returns success or failure; exit_code is undef on failure; actual error
# message is in @$
sub run {
    my ($self, @args) = @_;
    my ($stdout, $stderr);
    my $stdin = $self->stdin;

    my @cmd = (
        $perl, 
        "-Mblib=$cwd", 
        $self->program(),
        @{ $self->default_args() },
        @args,
    );
                
    eval {run3 \@cmd, \$stdin, \$stdout, \$stderr};
    my $result = $@ eq q{} ? 1 : 0;
    $self->exit_code($@ eq q{} ? $? >> 8 : undef);
    $self->stdout($stdout);
    $self->stderr($stderr);
    $@ .= "(running '@cmd')";
    return $result;
}

#--------------------------------------------------------------------------#
# Accessors
#--------------------------------------------------------------------------#

sub program {
    my ($self, $p) = @_;
    if (defined $p) {
        die "Can't find $p" if ! -e $p;
        $self->{program} = File::Spec->rel2abs($p);
        $self->basename(fileparse($p));
    }
    return $self->{program};
}
        
BEGIN {
    my $evaltext = << 'CODE';
        sub {
            $_[0]->{PROP} = $_[1] if @_ > 1;
            return $_[0]->{PROP};
        }
CODE
    for ( qw( exit_code stdin stdout stderr basename default_args)) {
        no strict 'refs';
        (my $sub = $evaltext) =~ s/PROP/$_/g;
        *{__PACKAGE__ . "::$_"} = eval $sub;
    }
}

#--------------------------------------------------------------------------#
# Testing functions
#--------------------------------------------------------------------------#

sub runs_ok {
    my ($self, @args) = @_;
    my $label = "Ran " . $self->basename . " with "
              . (@args && $args[0] ne q{} ? "args '@args'" : "no args" )
              . " without error";
    my $runs = $self->run(@args);
    die $@ if ! $runs;
    my $ok = $Test->ok( ! $self->exit_code, $label );
    if ( ! $ok ) {
        $Test->diag( "Exit code: " . $self->exit_code . "\n");
        $Test->diag( "STDERR: " . $self->stderr . "\n") if $self->stderr;
        $Test->diag( "STDOUT: " . $self->stdout . "\n") if $self->stdout;
    }
    return $ok;
}

sub dies_ok {
    my ($self, @args) = @_;
    my $label = $self->basename . " with "
              . (@args && $args[0] ne q{} ? "args '@args'" : "no args" )
              . " ended with an error";
    my $runs = $self->run(@args);
    die $@ if ! $runs;
    my $ok = $Test->ok( $self->exit_code, $label );
    if ( ! $ok ) {
        $Test->diag( "Exit code: " . $self->exit_code . "\n");
    }
    return $ok;
}


sub exits_with {
    my ($self, $expect, @args) = @_;
    my $label = $self->basename . " with "
              . (@args && $args[0] ne q{} ? "args '@args'" : "no args" )
              . " ended with exit code $expect";
    my $runs = $self->run(@args);
    die $@ if ! $runs;
    return $Test->is_num( $self->exit_code, $expect, $label );
}

sub stdout_is {
    my ($self, $expect, $label) = @_;
    return $Test->is_eq( $self->stdout, $expect, 
        $label 
            ? "... $label" 
            : "... " . $self->basename . " had correct output to STDOUT" );
}

sub stdout_like {
    my ($self, $expect, $label) = @_;
    return $Test->like( $self->stdout, $expect, 
        $label 
            ? "... $label"
            : "... " . $self->basename . " had correct output to STDOUT" );
}

sub stderr_is {
    my ($self, $expect, $label) = @_;
    return $Test->is_eq( $self->stderr, $expect,
        $label 
            ? "... $label"
            : "... " . $self->basename . " had correct output to STDERR" );
}

sub stderr_like {
    my ($self, $expect, $label) = @_;
    return $Test->like( $self->stderr, $expect,
        $label 
            ? "... $label"
            : "... " . $self->basename . " had correct output to STDERR" );
}


1; #true

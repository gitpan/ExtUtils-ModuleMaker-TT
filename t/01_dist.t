# Tests overall distribution components for use, consistent
# versioning, correct pod, and correct PREREQ_PM list.  The
# single line "use Test::Distribution" is all that is needed.
# not testing prereqs as Test::Distribution doesn't
# support Module::Build yet
use Test::Distribution qw( not prereq );

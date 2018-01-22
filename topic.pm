#!/usr/bin/perl

package topic;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			       pragmas
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# standard library
use strict;
use warnings;
use diagnostics;
use Getopt::Long;
use feature q{say};		# this is fucking awesome!

sub new {
    my ($class, %args) = @_;
    return bless { %args }, $class;
}

1;
__END__

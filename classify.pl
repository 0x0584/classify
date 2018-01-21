#!/usr/bin/perl
#			 AUTHOR: Anas Rchid (0x0584)
#			 CREATED: Sat. Jan 20, 2018
#		         --------------------------
#    DESCRIPTION: Classify documents based on the used dictionary.
#      Then decide whether it was a positive or negative answer!
#		         --------------------------
# CURRENT: Classify documents
#

# TODO: find a way to get a relative amount of files
# CREATED: 01/20/2018

# TODO: generate docs
# CREATED: 01/21/2018

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

package classify;


use strict;
use warnings;
use Getopt::Long;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

my $quiet = undef;
my $help;
my $topics;
my $dicts;
my @main_args;

sub handleoptions () {
     # Process options.
     if (@ARGV > 0) {
	  GetOptions('quiet|q' => \$quiet, 'help|?'  => \$help,
		     'dict=s'  => \$dicts, 'topic=s' => \$topics);
	  @main_args = @ARGV;
	  print "hell yeah!" unless $quiet;
	  print @main_args unless $quiet;
     }
}

handleoptions();

my $ERR_MSG = 'there was a problem while loading..';

# count the appearance of words in a particular document according
# to a certain topic or dictionary.
sub count_in {
     my $dict = $_[1];
     my $doc  = $_[0];

     my %count;			# per word
}

# ($login, $passwd) = split(/:/); very nice
# count words in a document
sub countwords {
     my $doc = $_[0];
     my $count = 0;
     my $ERR = -1;

     print "\n".$doc unless $quiet;

     # perl has a cool built-in feature of dealing with files
     # -s: returns the files size in bytes.
     return $ERR unless -s $doc;
     open my $in, '<', $doc or die $ERR_MSG;

     while (<$in>) {
	  my ($line) = $_;	# local variable
	  unless ('#' eq substr $line, 0, 1) { # ignore comments
	       chomp $line;
	       foreach my $str (split /\s+/, $line) {
		    $count++;
	       }
	  }
     }

     # never forget to close the opened file
     close $in;

     return $count;
}

print "\n", countwords $main_args[0];

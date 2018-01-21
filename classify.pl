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

my $verbose;
my $debug;
my $help;
my $topics;
my $dicts;
my @main_args;

sub handleoptions () {
     my $help = 0;		# handled locally
     my $ident = 0;		# handled locally
     my $man = 0;		# handled locally

     # Process options.
     if (@ARGV > 0) {
	  GetOptions('verbose|v' => \$verbose, 'help|?'	 => \$help,
		     'debug'	 => \$debug  , 'dict|d'	 => \$dicts,
		     'topic|t'   => \$topics);
     }

     print "hell yeah!" if ($verbose and $debug);
     print @main_args = @ARGV;
}

handleoptions();

# list of repos
# my @repos = (
# 	     '/home/arfed/Workspace/doc-class/docs',
# 	     '/home/arfed/Workspace/doc-class/results',
# 	     '/home/arfed/Workspace/doc-class/dicts',
# 	     '/home/arfed/Workspace/doc-class/topic'
# 	    );

# # topics
# my @topic = (
# 	     File::Spec->catfile($repos[3], 'philosophy.txt'),
# 	     File::Spec->catfile($repos[3], 'sport.txt'),
# 	     File::Spec->catfile($repos[3], 'economy.txt'),
# 	     File::Spec->catfile($repos[3], 'IT.txt'),
# 	     File::Spec->catfile($repos[3], 'computerscience.txt'),
# 	    );

# # dictionaries
# my @dict = (
# 	    my $positive = File::Spec->catfile($repos[2], 'positive.txt'),
# 	    my $negative = File::Spec->catfile($repos[2], 'negative.txt'),
# 	    my $advanced = File::Spec->catfile($repos[2], 'advanced.txt')
# 	   );

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
sub count_ {
     my $doc = $_[0];
     my $count = 0;
     my $ERR = -1;

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

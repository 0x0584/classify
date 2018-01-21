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

package classify;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			       pragmas
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# standard library
use strict;
use warnings;
use diagnostics;
use Getopt::Long;
use feature q{say};		# this is fucking awesome!

use topic;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			     sub routines
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

my @main_args = ();		# array of passed files as aguments
my @topics = ();		# array of topics
my @dicts = ();			# array of ditionaries
my @input = ();			# array of ditionaries
my $quiet = "";			# no unnecessary output
my $help = "";			# show a basic help

my $ERR_MSG = 'there was a problem while loading..';
my $HELP_MSG = "usage: $0 foo.txt [OPTIONS..]\n".
"\nOPTIONS:\n\t+ [-d=1..]\n\t+ [-t=1..]\n\t+ [-i=1..]\n";

sub handleargs {
     # Process options.
     if (@ARGV > 0) {
	  GetOptions('quiet|q' => \$quiet,
		     'help|?'  => \$help,
		     'dict|d=s{1,}'  => \@dicts,
		     'topic|t=s{1,}' => \@topics,
		     'input|i=s{1,}' => \@input
		    );
	  die ($HELP_MSG) if $help;

	  # merging just in case of sending files without
	  # specifing -i or --input
	  @main_args = (@input, @ARGV);

	  unless ($quiet) {
	       say "not super quiet $quiet";
	       say "dicts:\t @dicts";
	       say "topics:\t @topics";
	       say "main args:\t @main_args";
	       say "\t\t\t--------------";
	  }
     }
     else {
	  die ('no document was specified!'."\n"
	       .'use --help or -? for more information');
     }
}



# count the appearance of words in a particular document according
# to a certain topic or dictionary.
sub countin {
     my $doc  = $_[0];
     my $dict = $_[1];
     my $doc_count = countwords $_[0];

     my %count;			# per word
}

# ($login, $passwd) = split(/:/); very nice

# count the number words in a document
sub countwords {
     my $doc = $_[0];
     my $count = -1;

     # say "\nin doc:\t".$doc unless $quiet;

     open my $fin, '<', $doc or (print "'$doc'\t: ".$!."\n" and goto RET);

     while (<$fin>) {
	  my ($line) = $_;		       # local variable
	  unless ('#' eq substr $line, 0, 1) { # ignore comments
	       chomp $line;
	       foreach my $str (split /\s+/, $line) {
		    $count++;
	       }
	  }
     }

     # never forget to close the opened file
     close $fin;

     say "are you sure that '$doc' is a text file?"
     unless $count > 0 || $quiet;
     # perl has a cool built-in feature of dealing with files
     # -s: returns the files size in bytes.
 RET:
     return $count unless -s $doc;
}

# sub  {
     
# }
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			      main stuff
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

handleargs;			# get all the args

# 0.0 number of words in the documents
for my $i (@main_args) {
     if (countwords($i) != -1) {
	  print "'$i'\t: ".countwords($i)." word(s)\n"
     }
}


# now, compute the coccurence of each word of a particular topic
# and the whole document. indeed, something like the following:
#
# 0. compute word appearance:
#
# suppose that scalar(@doc) => 781
# words {a_i, b_i, ..} are from dictionaries {0 .. i}
#
# example dictionary_0:
#
# word a_0: 70/781 (*)
# word e_0: 68/781
# word d_0: 63/781
# word c_0: 51/781
# word b_0: 43/781
# ...
# word n_0: m/781
#
# the `word a_0` from dictioanry_0 appear 0.09% in the whole document
#
# 1. after collecting the appearances, find the most likey one among
# them. (for the moment, choose just one)
#

my $this = (
     1,2,4,5,7,4,1,4,1
    );

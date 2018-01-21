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

use strict;
use warnings;
use diagnostics;
use Getopt::Long;
use feature q{say};		# this is fucking awesome!

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			     sub routines
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

my @main_args = undef;
my $topics = "";
my $dicts = "";
my $quiet = undef;
my $help = undef;

sub handleoptions {
     # Process options.
     if (@ARGV > 0) {
	  GetOptions('quiet|q' => \$quiet, 'help|?'  => \$help,
		     'dict=s'  => \$dicts, 'topic=s' => \$topics);
	  @main_args = @ARGV;
	  unless ($quiet) {
	       say "not super quiet";
	       say "dicts:\t".$dicts;
	       say "topics:\t".$topics;
	       say "main args:@main_args";
	       say "\t\t\t--------------";
	  }
     } else {
	  die ('no document was specified!'."\n"
	       .'use --help or -? for more information');
     }
}


my $ERR_MSG = 'there was a problem while loading..';

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
     my $count = 0;
     my $ERR = -1;	       # return value in case there's an error

     say "\nin doc:\t".$doc unless $quiet;

     # perl has a cool built-in feature of dealing with files
     # -s: returns the files size in bytes.
     return $ERR unless -s $doc;

     open my $fin, '<', $doc or die $!;

     while (<$fin>) {
	  my ($line) = $_;	# local variable
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
     return $count;
}


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			      main stuff
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

handleoptions;			# get all the options

for my $i (@main_args) {
     print "word count: ".countwords ($i)." word(s) in '".$i."'\n";
}


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

# use topic;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			     sub routines
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

my @main_args = ();		# array of passed files as aguments
my @topics = ();		# array of topics
my @dicts = ();			# array of ditionaries
my @input = ();			# array of ditionaries
my $quiet = "";			# no unnecessary output
my $help = "";			# show a basic help

my %MSG = (
  ERR  => 'there was a problem while loading..',
  # #
  HELP => "usage: $0 foo.txt [OPTIONS..]\n".
  "\nOPTIONS:\n\t+ [-d=1..]\n\t+ [-t=1..]\n\t+ [-i=1..]\n",
  # #
  NO_DOC => 'no document was specified!'."\n".
  'use --help or -? for more information'
 );

sub handleargs {
  # Process options.
  if (@ARGV > 0) {
    GetOptions(
      'quiet|q' => \$quiet,
      'help|?'  => \$help,
      'dict|d=s{1,}'  => \@dicts,
      'topic|t=s{1,}' => \@topics,
      'input|i=s{1,}' => \@input
     );

    die ($MSG{'HELP'}) if $help;

    # merging just in case of sending files without
    # specifing -i or --input
    @main_args = (@input, @ARGV);

    unless ($quiet) {
      say "not super quiet $quiet";
      say "\ndicts:\t".join "\n\t", @dicts;
      say "\ntopics:\t".join "\n\t", @topics;
      say "\nargs:\t".join "\n\t", @main_args;
      say "\n\t\t--------------\n";
    }
  } else {
    die ($MSG{'NO_DOC'});
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

sub to_array {
  my $doc = $_[0];
  my @array;

  # this is silly but, i'll figure it out later
  goto FAILURE unless -s $doc;

  open my $in, '<', $doc or (print "'$doc'\t: ".$!."\n" and goto FAILURE);

  while (<$in>) {
    unless ('#' eq substr $_, 0, 1) { # ignore comments
      chomp $_;
      push @array, (split /\s+/, $_);
    }
  }

  close $in;

  return @array;
 FAILURE:
  return undef;
}

# ($login, $passwd) = split(/:/); very nice

# count the number words in a document
sub countwords {
  my $doc = $_[0];
  my $count = -1;

  if (my @tmp = to_array ($doc)) {
    $count = scalar @tmp;
  }

  say "is '$doc' a regular text file?" unless $count > 0 || $quiet;
  # perl has a cool built-in feature of dealing with files
  # -s: returns the files size in bytes.
 RET:
  return $count;
}

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

# ==================================================================
# now, compute the coccurence of each word of a particular topic
# and the whole document. indeed, something like the following:
#
# 0. compute word appearance, for example suppose that:
#
#   + scalar(@doc) => 781
#   + words_i {a_i, b_i, ..} are from dictionaries {0 .. i}
#
# let's take example dictionary_0, we would have
#
# word a_0: 520/781 (*)
# word e_0: 78/781
# word d_0: 83/781
# word c_0: 51/781
# word b_0: 43/781
# ...
# word n_0: m/781
#
# the `word a_0` from dictioanry_0 appears 66.60% of the time
# within the document. now, \sum{words_i} is the weight of each topic
#
# 1. after collecting the appearances, find the most likey one among
# them. (for the moment, choose just one)
# ==================================================================
#

# @description this take a document and show the occurence of words in
# topics and also its langauge level and whether it's a positive or
# a negative one.
#
# @param document
# @param list of topics
# @param list of dictionaires
#
# @return array (or hashmap) of something i don't know for the moment.
sub doc_analysis (\$\@\@) {
  my $doc_ref = shift;
  my $dicts_ref = shift;
  my $topics_ref = shift;

  # words appearance
  my %stats = undef;

  # 1. get words statistics, foreach doc
  # 1.1. figure topics
  # for my $t (@$topics_ref) {
  #   open my $tin, '<', $t or die ($MSG{'ERR'});

  #   while (<$tin>) {
  #
  #   }

  #   close $tin;
  # }
  # 1.2. figure language level

  # 2. sort the results
  # 3. pick the highest one while indicating it's language level
}

my @bar = to_array $dicts[0];

# print "@bar";

print countwords $main_args[0];

# for my $d (@main_args) {
#   print docanalysis $d, @dicts, @topics;
# }

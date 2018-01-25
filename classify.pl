#!/usr/bin/perl
#===============================================================================
#
#         FILE: classify.pl
#
#        USAGE: ./classify.pl [-q?] [-d foo.txt] [-t bar.txt] [-i in.txt]
#
#  DESCRIPTION: This is a `text-mining project, I work on it for two main
#		reasons. Fisrt, becaused i want to learn perl; and the sec-
#		ond one because it looks like an interesting project; to me.
#
#		The main purpose is to classify based on topic, language
#		level and perhaps whether the document contains a postive
#		or negative words the most.
#
#      OPTIONS: -d --dict	a dictionary as text file
#		-t --topic	a topic as a text file
#		-i --input	a document to be analyzed
#		-q --quiet	no unnecessary output
#		-? --help	show some help text
#		[debug flags]
#		-g --debug	show extra debug information (see -s)
#		-s --sleep	set `sleep` timer, goes along with debug
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: you may need to check your files encoding, this was tested on
#		text files which contains only ASCII character.
#       AUTHOR: Anas Rchid (0x0584) <rchid.anas@gmail.com>
# ORGANIZATION: ---
#      VERSION: 1.0
#      CREATED: Sat. Jan 20, 2018
#     REVISION: ---
#===============================================================================

# TODO: find a way to get a relative amount of files
# CREATED: 01/20/2018

# TODO: generate docs
# CREATED: 01/21/2018

#===============================================================================
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
#===============================================================================

package classify;

#===============================================================================
#			       pragmas
#===============================================================================
use strict;
use warnings;
use diagnostics;
use Getopt::Long;
# use feature q{say};		# this is fucking awesome!
# use topic;

#===============================================================================
#			     global vars
#===============================================================================
our @main_args = ();		# array of passed files as aguments
our @topics = ();		# array of topics
our @dicts = ();			# array of ditionaries
our @input = ();			# array of ditionaries
our $quiet = "";			# no unnecessary output
our $help = "";			# show a basic help
our $debug = 0;
our $sleep_timer = 1;

our %MSG = (
    ERR  => 'there was a problem while loading..',
    # #
    HELP => "usage: $0 foo.txt [OPTIONS..]\n".
    "\nOPTIONS:\n\t+ [-d=1..]\n\t+ [-t=1..]\n\t+ [-i=1..]\n",
    # #
    NO_DOC => 'no document was specified!'."\n".
    'use --help or -? for more information',
    LINE => "\n\t\t--------------\n\n"
);

#===============================================================================
#			     sub routines
#===============================================================================

# @description  handles the command line arguments, which are specified in the
#		header of this file. or just use the `-?|--help` flag to see
#		the list of available arguments
sub handle_args () {
    # Process options.
    if (@ARGV > 0) {
	GetOptions (
	    'quiet|q' => \$quiet,
	    'help|?'  => \$help,
	    'sleep|s=s{1,1}' => \$sleep_timer,
	    'dict|d=s{1,}'  => \@dicts,
	    'topic|t=s{1,}' => \@topics,
	    'input|i=s{1,}' => \@input,
	    'debug|g'  => \$debug,
	);

	die ($MSG{'HELP'}) if $help;

	# merging just in case of sending files without
	# specifing -i or --input
	@main_args = (@input, @ARGV);

	unless ($quiet) {
	    print "not super quiet $quiet\n";
	    print "\ndicts:\t", (join "\n\t", @dicts), "\n";
	    print "\ntopics:\t", (join "\n\t", @topics),"\n";
	    print "\nargs:\t", (join "\n\t", @main_args), "\n";
	    print $MSG{LINE};

	    sleep $sleep_timer if $debug;
	}
    } else {
	die ($MSG{'NO_DOC'});
    }
}

# @description  takes a file 'foo.txt' which contains a set of words
# 		and returns it as an array
# @param	document, a regular ASCII file
# @return	array of words
#
# @todo		also skip special characters like :;,?!$
#		=> check perl's regexps
sub to_array {
    my $doc = $_[0];
    my @array;

    # this is silly but, i'll figure it out later
    if (-s $doc) {
	open my $in, '<', $doc or (print "'$doc'\t: .$!\n" and goto FAILURE);

	while (<$in>) {
	    # ignore lines that start with a '#' as it is a standard
	    # way to indicate a commented line.
	    unless ('#' eq substr $_, 0, 1) {
		chomp $_;
		push @array, (split /\s+/, $_);
	    }
	}

	close $in;
    } else {
	goto FAILURE;
    }
    return @array;
  FAILURE:
    return undef;
}

# @description  this function returns a hash-map that contains each word and
#		it's number of occurrences in the document.
# @param	document as array of words
# @return	hashmap of each word and it's count
sub word_freq {
    my %count;
    while (my $w = shift @_) {
	++$count{$w};
    }
    return \%count;
}

# write advanced word-compare function
sub word_cmp {
    my ($w0, $w1) = (shift, shift);
    ...;
}

sub sort_rule ($$) {
    $_[1] cmp $_[0];
}

# @description	this take a document and show the occurence of words in
#		topics and also its langauge level and whether it's a
#		positive or a negative one.
# @param	document
# @param	array of topics
# @param	array of dictionaires
# @return	array (or hashmap) of something i don't know for the moment.
# @todo		find what words are the most frequented in a topic
sub doc_analysis (\$\@\@) {
    my $do_ref = shift;		# file path
    my $di_ref = shift;		# array of dictionaries
    my $t_ref = shift;		# array of topics
    # getting the frequency of words in the current doc
    my ($do_stats, %t_stats, %di_stats) = word_freq to_array $$do_ref;

    print "\tdoc: $$do_ref\n\n" if $debug;

    # 1. get words statistics
    for my $word (to_array $$do_ref) {
      CHECK: next unless $word;
      TOPICS:
	for my $topic (@$t_ref) {
	    my $count = 0;
	    for my $tword (to_array $topic) {
	        $count += $$do_stats{$word} if $word eq lc $tword;
    	    }
	    $t_stats{$topic} += $count;
    	}

      DICTS:
	for my $dict (@$di_ref) {
	    my $count = 0;
	    for my $dword (to_array $dict) {
    		$count += $$do_stats{$word} if $word eq lc $dword;
    	    }
	    $di_stats{$dict} += $count;
    	}
    }

    # this is temporary, you have to figure out the return value
    unless ($quiet or !$debug) {
	for my $key (keys %t_stats) {
	    print "$key - ", $t_stats{$key}, "\n";
	}
	print "\n\n";
	for my $key (keys %di_stats) {
	    print "$key - ", $di_stats{$key}, "\n";
	}
    }

    # 2. sort the results and pick the highest one
    return (sort { $t_stats{$b} <=> $t_stats{$a} } keys %t_stats)[0];
}

#===============================================================================
#			      main stuff
#===============================================================================
handle_args;			# get all the args

# 0.0 number of words in the documents
for my $doc (@main_args) {
    print "'$doc'\t: ", (scalar to_array $doc), " word(s)\n"
}

sleep $sleep_timer if $debug;
print $MSG{LINE};

for my $d (@main_args) {
    print "\n$d: => ", (doc_analysis $d, @dicts, @topics);
    print $MSG{LINE};
    sleep $sleep_timer if $debug;
}

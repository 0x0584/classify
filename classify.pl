#!/usr/bin/perl
#===============================================================================
#
#         FILE: classify.pl
# REQUIREMENTS: ---
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
#       AUTHOR: Anas Rchid (0x0584) <rchid.anas@gmail.com>
#
#      OPTIONS: -d --dict	a dictionary as text file
#		-t --topic	a topic as a text file
#		-i --input	a document to be analyzed
#		-q --quiet	no unnecessary output
#		-? --help	show some help text
#		[debug flags]
#		-g --debug	show extra debug information (see -s)
#		-s --sleep	set `sleep` timer, goes along with debug
#
#         BUGS: no word-root comparison (philosophy vs philosopher)
#        NOTES: you may need to check your files encoding, this was tested on
#		text files which contains only ASCII character.
#      VERSION: 1.0
#      CREATED: Sat. Jan 20, 2018
#     REVISION: Fri. Jan 26, 2018
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
our $quiet = 0;			# no unnecessary output
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
sub to_array {
    my $doc = $_[0];
    my @array;

    # this is silly but, i'll figure it out later
    # NOTE: `later` here means, as always, never..
    if (-s $doc) {
	open my $in, '<', $doc or (print "'$doc'\t: .$!\n" and goto FAILURE);

	while (<$in>) {
	    # this is better, perl is a hell of a language!
	    push @array, grep /\p{L}/i, split /\s+/, $_ unless /^#/;
	}

	s/^\P{L}+// or s/\P{L}+$// for @array; # remove any :punct:

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
    my @doc_words = to_array $$do_ref;
    # getting the frequency of words in the current doc
    my ($do_stats, %t_stats, %di_stats) = word_freq @doc_words;

    print "\tdoc: $$do_ref\n\n" if $debug;

    # 1. get words statistics
    for my $word (@doc_words) {
	next unless $word;

      TOPICS:
	for my $topic (@$t_ref) {
	    my $count = 0;
	    for (to_array $topic) {
		$count += $$do_stats{$word} if $_ and lc $word eq lc $_;
    	    }
	    $t_stats{$topic} += ((($count) *= 100) /= @doc_words);
    	}

      DICTS:
	for my $dict (@$di_ref) {
	    my $count = 0;
	    for (to_array $dict) {
		$count += $$do_stats{$word} if $_ and lc $word eq lc $_;
    	    }
	    $di_stats{$dict} += ((($count) *= 100) /= @doc_words);
    	}
    }

    # 2. sort the results and pick the highest one
    return ($do_stats, \%t_stats, \%di_stats);
}

sub show_analysis {
    my ($do_s, $t_s, $di_s) = (shift, shift, shift);
    my %do;

    goto FINAL if $quiet;

    # group words by their occurrence
    $do{$$do_s{$_}} .= ($_.("/")) for keys %$do_s;

    print "word statistics:\n----------------\n";
    printf "%-4s [%s]\n", $_,  $do{$_} for sort {
	$b <=> $a
    } keys %do;

    print "\ntopic statistics:\n-----------------\n";
    print "$_ ", (sprintf "%6s", sprintf("%.2f", $$t_s{$_})). "%\n" for sort {
	$$t_s{$b} <=> $$t_s{$a}
    } keys %$t_s;

  FINAL:
    print "dictionary statistics:\n----------------------\n";
    print "$_ ", (sprintf "%6s", sprintf "%.2f", $$di_s{$_}), "%\n" for sort {
	$$di_s{$b} <=> $$di_s{$a}
    } keys %$di_s;

    my $key = (sort {$$t_s{$b} <=> $$t_s{$a}} keys %$t_s)[0];
    print "\n\t=> $key (", (sprintf "%.2f", $$t_s{$key}), "%)\n";
}

#===============================================================================
#			      main stuff
#===============================================================================
handle_args;			# get all the args

# 0.0 number of words in the documents
for my $doc (@main_args) {
    # my @arr = to_array $doc;
    print "'$doc'\t: ", (scalar to_array $doc), " word(s)\n"
}

sleep $sleep_timer if $debug;
print $MSG{LINE};

for my $doc (@main_args) {
    my @analysis = doc_analysis $doc, @dicts, @topics;

    print "\t'$doc:' \n\n";
    print "\ncontent:[", (join " ", to_array $doc) ,"]\n\n" if $debug;

    show_analysis @analysis;

    sleep $sleep_timer if $debug and !$quiet;
    print $MSG{LINE};
}

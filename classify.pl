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
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
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

package classify;

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			       pragmas
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# standard library
use strict;
use warnings;
use diagnostics;
use Getopt::Long;
# use feature q{say};		# this is fucking awesome!

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
my $debug = 0;

my %MSG = (
    ERR  => 'there was a problem while loading..',
    # #
    HELP => "usage: $0 foo.txt [OPTIONS..]\n".
    "\nOPTIONS:\n\t+ [-d=1..]\n\t+ [-t=1..]\n\t+ [-i=1..]\n",
    # #
    NO_DOC => 'no document was specified!'."\n".
    'use --help or -? for more information',
    LINE => "\n\t\t--------------\n\n"
);

sub handle_args () {
    # Process options.
    if (@ARGV > 0) {
	GetOptions (
	    'quiet|q' => \$quiet,
	    'help|?'  => \$help,
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

	    # sleep 1;
	}
    } else {
	die ($MSG{'NO_DOC'});
    }
}

# count the appearance of words in a particular document according
# to a certain topic or dictionary.
# sub countin {
#     my $doc  = $_[0];
#     my $dict = $_[1];
#     my $doc_count = countwords $_[0];

#     my %count;			# per word
# }

# @description  takes a file 'foo.txt' which contains a set of words
#		and returns it as an array
# @param	document, a regular ASCII file
# @return	array of words
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

# ($login, $passwd) = split(/:/); very nice

# count the number words in a document
sub count_words {
    return scalar to_array $_[0];
}

# this function returns a hash-map that contains each word and it's number
# of occurrences in the document.
sub word_freq {
    my %count;

    while (my $w = shift @_) {
	++$count{$w};
    }

    return \%count;
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

# @description	this take a document and show the occurence of words in
#		topics and also its langauge level and whether it's a
#		positive or a negative one.
# @param	document
# @param	array of topics
# @param	array of dictionaires
# @return	array (or hashmap) of something i don't know for the moment.
sub doc_analysis (\$\@\@) {
    my $do_ref = shift;		# file path
    my $di_ref = shift;		# array of dictionaries
    my $t_ref = shift;		# array of topics
    # getting the frequency of words in the current doc
    my ($do_stats, %t_stats, %di_stats) = word_freq to_array $$do_ref;

    # print "@doc_words $docref\n";
    # print to_array $$do_ref;
    # 1. get words statistics
    for my $word (to_array $$do_ref) {
      CHECK:
	unless ($word) {
	    if ($debug) {
		print ("!: $word\n");
		sleep 1;
	    }
	    next;
	}


      TOPICS:
	for my $topic (@$t_ref) {
	    my $count = 0;
	    for my $tword (to_array $topic) {
	        $count += $$do_stats{$word} if $word eq $tword;
    	    }
	    $t_stats{$topic} += $count;
    	}

      DICTS:
	for my $dict (@$di_ref) {
	    my $count = 0;
	    for my $dword (to_array $dict) {
    		$count += $$do_stats{$word} if $word eq $dword;
    	    }
	    $di_stats{$dict} += $count;
    	}
    }

    unless ($quiet) {
	for my $key (keys %t_stats) {
	    print "$key - ", $t_stats{$key}, "\n";
	}
	print $MSG{LINE};
	# sleep 1;
    }

    # for my $ht (@topic_stats) {
    # 	for my $key (keys %$ht) {
    # 	    print "$key - ", $$ht{$key}, "\n";
    # 	}
    # }

    # # 1.2. figure language level
    # for my $d (@$dicts_ref) {
    # 	push @dict_stats, word_freq to_array $d;
    # }

    # 2. sort the results
    # 3. pick the highest one while indicating it's language level
    
}
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# #			      main stuff
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

handle_args;			# get all the args

# 0.0 number of words in the documents
for my $i (@main_args) {
    print "'$i'\t: ", count_words($i), " word(s)\n"
}
print $MSG{LINE};

for my $d (@main_args) {
    doc_analysis $d, @dicts, @topics;
}

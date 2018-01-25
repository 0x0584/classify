#!/usr/bin/perl
#===============================================================================
#
#         FILE: foo.pl
#
#        USAGE: ./foo.pl
#
#  DESCRIPTION: testing some stuff..
#
#       AUTHOR: Anas Rchid (0x0584) <rchid.anas@gmail.com>
#      VERSION: 1.0
#      CREATED: 01/22/2018
#     MODIFIED: 01/24/2018
#     REVISION: ---
#===============================================================================
my $false = undef;
my $true = !$false;

# sub word_freq {
#     my %count;

#     while (my $w = shift @_) {
# 	 ++$count{$w};
#     }

#     return \%count;
# }

# my $r_hash = word_freq qw/
# 			     I am Anas
# 			     I have Some Cool things
# 			     those things are
# 			     one of many things
# 			     of my things
# 			 /;
# print $$r_hash{things}, "\n";
# my @harr = (
#     word_freq qw/have have cool test/,
#     word_freq qw/shit shoot shall/,
#     word_freq qw/nice hell hall hold hul/
# );

# for my $h (@harr) {
#     my ($key, $val) = each %$h;
#     print "$key - $val\n"
# }

# a problem down here
# VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
# my @arr;

# sub foo {
#     return @_;
# }

# sub bar {
#     my %h;
#     print "@_\n";
#     for my $b (@_) {
# 	print "$b - ", ++$h{$b}, "\n";
#     }

#     return \%h;
# }

# push @arr, bar foo (1,1,4,5,7,7,7,8,4,5,1,1,2,4,2);
# push @arr, bar foo (2,2);

# print "@arr\n+++\n";
# print "this: $arr[0]{4}\n";

# for my $h (@arr) {
#     print "$h\n----\n";

#     for my $key (keys %$h) {
#     	print "$key -> ", %$h{$key}, "\n";
#     	print "\n", %$h{1};
#     }

#     print "\n****\n";
# }
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# sub max {
#   my $foo = shift @_;
#   foreach (@_) {
#       $foo = $_ if $_ > $foo;
#   }
#   return $foo;
# }

# print "this is a text";
# print max ();
# print max (1..6, 8, 1, (reverse 5..10));

# my ($foo, $bar) = (0xff);
# print "$foo - $bar";

# my ($foo, $bar, $baz) = 7;

# sub ss {
#     $foo = 11;
# }

# $bar = ss;			# same as using '&'
# $baz = &ss;			# same as calling without '&'

# print "$foo $bar $baz";

# my @strs = qw! test shit fool cool !;
# my ($foo, $bar) = @strs;

# print "@strs\n$foo\n$bar\n";
# print scalar @strs;

# @strs = qw( sss sss sss );

# @strs = (
#     1, 2, 1,
#     2, 1, 2,
# );

# my @range = 1..1e3;

# my @foo = (@range, undef, @range);
# print scalar @foo;

# my @arr = qw! cool way to say something !;
# print "@arr\n";

# my ($last, $first) = (pop(@arr), shift(@arr));
# print "@arr\n";

# push @arr, 78;
# unshift @arr, 89;

# print "$last $first\n";
# print "@arr\n";

# splice @arr, 0, 3, qw! oh this is fucking awesome\! !;
# print "@arr\n";

# sub nary_print {		# from perldoc (on splice)
#     my $n = shift;
#     while (my @next_n = splice @_, 0, $n) {
#         print join(q! -- !, @next_n), "\n";
#     }
# }

# nary_print 3, qw/ this is cool to have fun wow /;
# my @text = qw/ this is a test /;
# print "@text\n";
# foreach my $word (@text) {
#     $word .= q/ -- /;
# }

# print "@text\n";

# foreach (@text) {
#     $_ .= q/ ** /;
# }

# print "@text\n";

# my @arr = reverse 1..6;
# print "@arr\n";

# my %hash = (
#     foo => "hah",
#     bar => "jkj"
# );

# print "aaa".$hash{'bar'};
# print $hash{foo};

# my %h = (
#     foo => "ssss",
#     bar => "ffff",
#     baz => "oooo"
# );

# my %hh = (
#     foo => "ssss",
#     bar => "ffff",
#     baz => "oooo"
# );

# print $h{foo};

# my @arr = (
#     \%h,
#     \%hh
# );

# print "@arr";
# print $arr[0]{bar};

# sub something (\@\@) {
#     my $ref0 = shift;
#     my $ref1 = shift;

#     print @$ref0;		# dereference array
#     print @$ref1;
# }

# my @arr0 = (5,1,2,2,1,4);
# my @arr1 = (2,2,2,2,2);

# something @arr0, @arr1;

# use List::MoreUtils qw(zip);
# use Data::Dumper qw(Dumper);

# my @a1 = ("Vinay", "Raj", "harry");
# my @a2 = ("dude", "rock");

# my @merged = zip(@a1, @a2);

# print Dumper(\@merged);

# print (scalar undef);

# my %s;
# my %ss = {
#     s=>"sss",
#     b=>11
# };

# for my $foo (1,2,44,5,4,2,2,1,4,1,2) {
#     $s{$foo}++;
# }

# # for my $bar (keys %s) {
# #   print $bar." - ".$s{$bar}."\n";
# # }

# my @arr = (%s, %ss);

# for my $f (@arr) {
#     for my $s (keys %$f) {
# 	print "$s - ".$f->{$s}."\n";
#     }
# }

# my @arr = (
#     {
# 	off => "kkk",
# 	on => "xxx"
#     },
#     {
# 	foo => "ssss",
# 	bar => "xxx"
#     }
# );

# print "sss";

# print "$arr[0]{off}";

# my @arr0;
# my @arr;

# my %hash0 = {
#     foo => "vvvv",
#     bar => "ssss"
# };
# my %hash1 = {
#     here => "oh! i am anas",
#     there => "here's the best things"
# };

# push @arr, %hash0;
# push @arr, %hash1;

# push @arr0, \%hash0;
# push @arr0, \%hash1;

# print "@arr\n";
# print $arr[1]{'here'};

# for my $h (@arr) {
#     for my $key (keys %$h) {
# 	print %$h{$key}."\t";
#     }
# }

# print "@arr0\n";
# print $arr0[1]{'here'};


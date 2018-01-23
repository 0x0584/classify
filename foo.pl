#!/usr/bin/perl
#
#			  AUTHOR: ANAS RCHID
#		     DESCRIPTION: testing some stuff..
#
#   CREATED: 01/22/2018
#   MODIFIED: 01/22/2018
#

# sub something (\@\@) {
#   my $ref0 = shift;
#   my $ref1 = shift;

#   print @$ref0;			# dereference array
#   print @$ref1;
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

my %s;
my %ss = {
  s=>"sss",
  b=>11
 };

for my $foo (1,2,44,5,4,2,2,1,4,1,2) {
  $s{$foo}++;
}

# for my $bar (keys %s) {
#   print $bar." - ".$s{$bar}."\n";
# }

my @arr = (%s, %ss);

for my $f (@arr) {
  for my $s (keys %$f) {
    print "$s - ".$f->{$s}."\n";
  }
}



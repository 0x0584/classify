#!/usr/bin/perl
#
#			  AUTHOR: ANAS RCHID
#		     DESCRIPTION: testing some stuff..
#
#   CREATED: 01/22/2018
#   MODIFIED: 01/22/2018
#

sub something (\@\@) {
  my $ref0 = shift;
  my $ref1 = shift;

  print @$ref0;			# dereference array
  print @$ref1;
}

my @arr0 = (5,1,2,2,1,4);
my @arr1 = (2,2,2,2,2);

something @arr0, @arr1;

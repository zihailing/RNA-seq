#!/usr/bin/perl 
use strict; use warnings; 
use FileHandle;

my($infile) = @ARGV;

my $in = FileHandle -> new("< $infile");
while(<$in>){
	chomp;
	$_ =~ /mean=(.{7}).+stdev=(.{7})/;
	printf ("%.2f\t", $1);
	printf ("%.2f\n", $2);
}

#!/usr/bin/perl
use strict; use warnings;
use FileHandle;

my($file1, $file2) = @ARGV;
die"Please input <file1> <file2>!" if(@ARGV!=2);

my(%hash1, %hash2);

my $in1 = FileHandle->new("< $file1");
my $in2 = FileHandle->new("< $file2");

while(<$in1>){
	chomp;
	$_ =~ /(\S+)\t(.+)/;
	$hash1{$1} = $2;
}

while(<$in2>){
	chomp;
	$_ =~ /(\S+)\t(.+)/;
	$hash2{$1} = $2;
}

foreach my $key (keys %hash2){
	if(exists $hash1{$key}){
		print "$key\t$hash2{$key}\t$hash1{$key}\n";
	}
	else{
		print "$key\t$hash2{$key}\t##\n";
	}
}

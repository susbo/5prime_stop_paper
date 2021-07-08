#!/usr/bin/perl -w

use strict;

my @files = `ls out/*.fa`;

my @bases = ("A","C","G","T");
my @keys;
foreach my $a (@bases) { foreach my $b (@bases) { foreach my $c (@bases) { push @keys, "$a$b$c"; }}}

foreach my $key (@keys) {
	printf "\t$key";
}
printf "\n";

foreach my $file (@files) {
	chomp $file;

	my %counts;

	open IN,$file;
	my $header;
	while (my $row = <IN>) {
		my $seq = "";
		chomp $row;
		while ($row =~ /^[^>]/) {
			$seq = $seq.$row;
			$row = <IN>;
			last if $row//"" eq "";
			chomp $row;
		}
	   if ($seq ne "") {
			# Frame 0
			my @codons = $seq =~ /.{3}/g;
			foreach my $c (@codons) {
				$counts{$c}++;
			}
			# Frame 1
			$seq = "N".$seq;
			@codons = $seq =~ /.{3}/g;
			foreach my $c (@codons) {
				$counts{$c}++;
			}
			# Frame 2
			$seq = "N".$seq;
			@codons = $seq =~ /.{3}/g;
			foreach my $c (@codons) {
				$counts{$c}++;
			}
	   }
 	  $header = $row;
	}
	my $name = $file;
	$name =~ s/out\///;
	$name =~ s/\.fa//;
	printf "$name";
	foreach my $key (@keys) {
		printf "\t".($counts{$key}//0);
	}
	printf "\n";
	close IN;
}

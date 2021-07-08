#!/usr/bin/perl -w

# This script will download all files listed in libraries.txt
# which represent unknown reads (i.e., piRNAs) in each ovary or 
# testis library in the piRNA cluster database.
#
# Please note that this will download around 17.14 GB of raw data 
# that will require 4.97 GB once compressed.

use strict;

open IN,"libraries.txt";

mkdir "fasta_unknown";
mkdir "info_unknown";
while (my $row = <IN>) {
	chomp $row;
	my @line = split "\t",$row;
	my $url = $line[0];
	$url =~ m/data\/(.+)\/(.+)\/UNITAS.+_(SRR\d+).fasta.trimmed.sam/;
	my ($species, $source, $srr) = ($1,$2,$3);
	printf "wget %s -O fasta_unknown/$species.$source.$srr.fa\n",$url;
	if (! -e "fasta_unknown/$species.$source.$srr.fa.gz") {
		`wget $url -O fasta_unknown/$species.$source.$srr.fa`;
		`dos2unix fasta_unknown/$species.$source.$srr.fa`;
		`gzip fasta_unknown/$species.$source.$srr.fa`;
	}
	if (! -e "info_unknown/$species.$source.$srr.txt") {
		$url =~ s/\/fasta\//\/info\//;
		$url =~ s/no-annotation.fas/no-annotation.info/;
		`wget $url -O info_unknown/$species.$source.$srr.txt`;
	}
}

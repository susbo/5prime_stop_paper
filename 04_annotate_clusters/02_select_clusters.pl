#!/usr/bin/perl -w
# Do some basic filtering to select clusters to use for codon counting
use strict;

my $path="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/summary_uniq";

my @files = `ls $path | grep -v filter`;

mkdir "$path/filter";
mkdir "$path/filter/bed";

foreach my $file (@files) {
	chomp $file;
	open IN,"$path/$file" or die "Cannot open $path/$file\n";
	open OUT,">$path/filter/$file" or die "Cannot open $path/filter/$file\n";
	<IN>;
	while (<IN>) {
		my @line = split "\t";
		next if $line[1]<100; # Require >=100 reads
		next if $line[6]<0.8; # Require >= 80% on one strand
		my $u1 = $line[11]; $u1 = $line[21] if $line[4] eq "-";
		next if $u1 < 0.4; # Require 1U >= 40%
		printf OUT "$line[0]\t$line[1]\t$line[3]\t$line[6]\t$u1\n";
	}
	close OUT;
	close IN;
	# Create strand-specific bed files for subsampling step later
	# Using dummy coordinates for each cluster to make sure we keep all reads for the selected clusters
	`cat $path/filter/$file | cut -f1,3 | awk '\$2=="+"' | awk -v OFS="\\t" '{print \$1,1,10000000,"1","1",\$2}' > $path/filter/bed/plus.$file`;
	`cat $path/filter/$file | cut -f1,3 | awk '\$2=="-"' | awk -v OFS="\\t" '{print \$1,1,10000000,"1","1",\$2}' > $path/filter/bed/minus.$file`;
}

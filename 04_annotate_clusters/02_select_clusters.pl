#!/usr/bin/perl -w
# Do some basic filtering to select clusters to use for codon counting
use strict;

my $path="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/summary_uniq";

my @files = `ls $path`;
#$ head Acyrthosiphon_pisum.ovary.SRR5614367.txt
#Name    N       rpm     Strand  +       -       ratio   1A+     1C+     1G+     1T+     ratio   10A+    10C+    10G+    10T+    ratio   1A-     1C-     1G-     1T-     ratio   10A-    10C-    10G-    10T-    ratio
#Apis_0001       52124   2624.41 +       51862   262     0.99    7857    2633    803     40564   0.78    16530   9698    8611    17023   0.32    111     22      8       121     0.46    96      29      47      90      0.37
#Apis_0004       30795   1550.51 -       1142    29653   0.96    203     47      41      851     0.75    325     184     347     286     0.28    4069    1218    364     23999   0.81    13167   4818    3889    7779    0.44
#Apis_0005       7532    379.23  +       6296    1236    0.84    926     277     108     4985    0.79    2579    1243    1081    1393    0.41    206     51      7       972     0.79    240     116     232     648     0.19
#Apis_0002       5394    271.58  -       764     4630    0.86    122     111     13      518     0.68    189     137     160     278     0.25    697     205     74      3653    0.79    1369    986     775     1500    0.3
#Apis_0003       4901    246.76  +       4563    338     0.93    661     227     60      3615    0.79    1178    1057    924     1404    0.26    86      23      9       220     0.65    141     26      91      80      0.42

mkdir "$path/filter";

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
}

#!/usr/bin/perl -w
#
use strict;

my $prefix = "/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment";

open IN,"samtools view $prefix/$ARGV[0].bam |";

my $total = 0;
my %counts;
my %bases;
my %bases10;
my %strand; # Plus, Minus

while (my $row = <IN>) {
	my @line = split "\t",$row;
	my ($count,$cluster,$flag,$seq,$qual) = ($line[0],$line[2],$line[1],$line[9],$line[4]);
	if (($flag & 0x10) && $qual >= 40) { # Minus
		$bases{$cluster}{complement(substr(reverse($seq),0,1))}[1] += $count;
		$bases10{$cluster}{complement(substr(reverse($seq),10,1))}[1] += $count;
		$counts{$cluster} += $count;
		$strand{$cluster}[1] += $count;
	} elsif ($qual >= 40) { # Plus
		$bases{$cluster}{substr($seq,0,1)}[0] += $count;
		$bases10{$cluster}{substr($seq,10,1)}[0] += $count;
		$counts{$cluster} += $count;
		$strand{$cluster}[0] += $count;
	}
	$total += $count;
}
close IN;

printf "Name\tN\trpm\tStrand\t+\t-\tratio\t1A+\t1C+\t1G+\t1T+\tratio\t10A+\t10C+\t10G+\t10T+\tratio\t1A-\t1C-\t1G-\t1T-\tratio\t10A-\t10C-\t10G-\t10T-\tratio\n";
foreach my $key (sort {$counts{$b} <=> $counts{$a}} keys %counts) {
	printf "$key";
	my $rpm = ($counts{$key}//0)/$total*1e6;
	printf "\t".($counts{$key}//0)."\t".round($rpm,2);

	my ($s,$s_ratio) = ("+",($strand{$key}[0]//0)/$counts{$key});
	if (($strand{$key}[1]//0) > ($strand{$key}[0]//0)) { ($s,$s_ratio) = ("-",$strand{$key}[1]/$counts{$key}); }
	printf "\t$s\t".($strand{$key}[0]//0)."\t".($strand{$key}[1]//0)."\t".(round($s_ratio,2));

	# + strand
	printf "\t".($bases{$key}{"A"}[0]//0)."\t".($bases{$key}{"C"}[0]//0)."\t".($bases{$key}{"G"}[0]//0)."\t".($bases{$key}{"T"}[0]//0);
	my $T_ratio = ($bases{$key}{"T"}[0]//0)/(($strand{$key}[0]//0)||1);	
	printf "\t".round($T_ratio,2);

	printf "\t".($bases10{$key}{"A"}[0]//0)."\t".($bases10{$key}{"C"}[0]//0)."\t".($bases10{$key}{"G"}[0]//0)."\t".($bases10{$key}{"T"}[0]//0);
	my $A_ratio = ($bases10{$key}{"A"}[0]//0)/(($strand{$key}[0]//0)||1);	
	printf "\t".round($A_ratio,2);

	# - strand
	printf "\t".($bases{$key}{"A"}[1]//0)."\t".($bases{$key}{"C"}[1]//0)."\t".($bases{$key}{"G"}[1]//0)."\t".($bases{$key}{"T"}[1]//0);
	$T_ratio = ($bases{$key}{"T"}[1]//0)/(($strand{$key}[1]//0)||1);	
	printf "\t".round($T_ratio,2);

	printf "\t".($bases10{$key}{"A"}[1]//0)."\t".($bases10{$key}{"C"}[1]//0)."\t".($bases10{$key}{"G"}[1]//0)."\t".($bases10{$key}{"T"}[1]//0);
	$A_ratio = ($bases10{$key}{"A"}[1]//0)/(($strand{$key}[1]//0)||1);	
	printf "\t".round($A_ratio,2);

	printf "\n";
}

sub round {
	return int($_[0]*10**$_[1]+0.5)/10**$_[1];
}

sub complement {
   return "A" if $_[0] eq "T";
   return "C" if $_[0] eq "G";
   return "G" if $_[0] eq "C";
   return "T" if $_[0] eq "A";
   return "N";
}


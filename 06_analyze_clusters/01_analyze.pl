#!/usr/bin/perl -w
# Do some basic filtering to select clusters to use for codon counting
use strict;

my $path="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/summary_uniq/filter";

my @files = `ls $path | grep -v reads`;
#Acyrthosiphon_pisum.ovary.SRR5614367.txt

#Amel_0036       2265057 -       1       0.5
#Amel_0023       2169343 +       0.99    0.91

mkdir "out";

foreach my $file (@files) {
	chomp $file;
	printf "File: $file\n";
	my @info = split "\\.",$file;
	my $species = $info[0];
	printf "Species: $species\n";
	my $outfile = `echo $file | sed -e 's/.txt/.fa/'`;
	printf "Outfile: $outfile\n";

	open OUT,">out/$outfile";
	open IN,"$path/$file" or die "Cannot open $path/$file\n";
	while (<IN>) {
		my @line = split "\t";
		open my $cmd, '-|', "samtools faidx /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/references/$species/clusters.fa $line[0]";
		my ($header,$seq) = ("","");
		while (my $row = <$cmd>) {
			chomp $row;
			if ($row =~ /^>/) {
				$header = $row;
			} else {
				$seq .= $row;
			}
		}
		close $cmd;
		$seq = compl($seq) if $line[2] eq "-";
		printf OUT "$header\n$seq\n";
	}
	close OUT;
	close IN;
}	

sub compl {
	my $seq = reverse $_[0];
	$seq =~ s/A/X/g;
	$seq =~ s/T/A/g;
	$seq =~ s/X/T/g;
	$seq =~ s/C/X/g;
	$seq =~ s/G/C/g;
	$seq =~ s/X/G/g;
	return $seq;
}

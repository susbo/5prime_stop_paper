#!/usr/bin/perl -w
# Do some basic filtering to select clusters to use for codon counting
use strict;

my $path="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/summary_uniq/filter";
my $bams="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment";

my @files = `ls $path`;
#Acyrthosiphon_pisum.ovary.SRR5614367.txt
#
#Amel_0036       2265057 -       1       0.5
#Amel_0023       2169343 +       0.99    0.91
#Amel_0009       1153835 -       0.83    0.87
#Amel_0035       1086170 +       1       0.89
#Amel_0004       753802  +       1       0.86

mkdir "$path/reads";

foreach my $file (@files) {
	my %selected;
	chomp $file;

	open IN,"$path/$file" or die "Cannot open $path/$file\n";
	while (<IN>) {
		my @line = split "\t";
		$selected{$line[0]} = $line[2];
	}
	close IN;

	open OUT,">$path/reads/$file" or die "Cannot open $path/reads/$file\n";

	my $bam = `echo $file | sed -e 's/.txt/.bam/'`;
	open IN,"samtools view $bams/$bam |" or die "Cannot open BAM file: $bams/$bam\n";
	while (<IN>) {
		chomp;
		my @line = split "\t";
		last if $line[2] eq "*"; # Unmapped reads => end of file
		next unless defined($selected{$line[2]}); # Not selected cluster
		next if $selected{$line[2]} eq "+" && $line[1] & 0x16; # Minus read on plus cluster
		next if $selected{$line[2]} eq "-" && !($line[1] & 0x16); # Plus read in minus cluster
		next if length($line[9]) < 23;
		next if length($line[9]) > 32;
		my $seq = $line[9];
		$seq = compl($seq) if $line[1] & 0x16;
		printf OUT "$line[0]\t$seq\n";
	}
	close IN;
	close OUT;
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

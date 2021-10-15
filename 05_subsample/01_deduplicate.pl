#!/usr/bin/perl -w
#
use strict;

my $out = "/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment";
mkdir "$out/capped";

my $cap = 100;

my @files=`ls $out/*.bam`;

foreach my $file (@files) {
	chomp $file;
	my @tmp = split "/",$file;
	my $name = $tmp[$#tmp];
	$name =~ s/.bam//;

	my $bed = "$out/summary_uniq/filter/bed/plus.$name.txt";

#	open OUT,">$out/capped/$name.sense.txt";
	open OUT,">$out/capped/$name.txt";
	open IN,"samtools view -F0x10 -L $bed $file |"; # Plus strand

	my %positions; # Keep all hits in memory for all positions
	while (my $row = <IN>) {
		my @line = split "\t",$row;
		my ($count,$chr,$position,$seq) = ($line[0],$line[2],$line[3]-1,$line[9]);
		for ( 1 .. $count ) { push @{ $positions{"$chr:$position"} },$seq; }
	}

	# Go though all positions
	foreach my $key (keys %positions) {
		my @a = @{ $positions{$key} };
#printf "position: $key, length: @a\n";
		my $seq;
  		for ( 1 .. min($cap,scalar @a) ) { # Print at most cap sequences (or as many as exists)
			$seq = splice @a, rand @a, 1; # Pick a random one and do some filtering
			my $length = length($seq);
			next if $length<23 || $length>32;
			next if $seq =~ /N/;
#			$seq = substr($seq,0,20);
			printf OUT "$seq\n";
		}
#		exit if $key eq (keys %positions)[4];
	}
	close IN;
	close OUT;
	
	$bed =~ s/plus/minus/;

#	open OUT,">$out/capped/$name.antisense.txt";
	open OUT,">>$out/capped/$name.txt";
	open IN,"samtools view -f0x10 -L $bed $file |"; # Minus strand

	%positions = (); # Keep all hits in memory for all positions
	while (my $row = <IN>) {
		my @line = split "\t",$row;
		my ($count,$chr,$position,$seq) = ($line[0],$line[2],$line[3]-1+length($line[9]),$line[9]); # Use endpoint as position for reverse strand
		$seq = reverse $seq;
		$seq =~ tr/ACGT/TGCA/;
		for ( 1 .. $count ) { push @{ $positions{"$chr:$position"} },$seq; }
	}

	# Go though all positions
	foreach my $key (keys %positions) {
		my @a = @{ $positions{$key} };
		my $seq;
  		for ( 1 .. min($cap,scalar @a) ) { # Print at most cap sequences (or as many as exists)
			$seq = splice @a, rand @a, 1; # Pick a random one and do some filtering
			my $length = length($seq);
			next if $length<23 || $length>32;
			next if $seq =~ /N/;
#			$seq = substr($seq,0,20);
			printf OUT "$seq\n";
		}
#		exit if $key eq (keys %positions)[4];
	}
	close IN;
	close OUT;
}

sub min {
	return $_[0] < $_[1] ? $_[0] : $_[1];
}

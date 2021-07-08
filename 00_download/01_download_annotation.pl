#!/usr/bin/perl -w

# This script will download all files listed in urls.txt
# which represent cluster coordinates (gtf), cluster sequence (fasta) 
# and individual piRNA species (fasta) for each of the 51 species
# represented in the database.
#
# Please note that this will download around 101 MB of data that will
# requre 40 MB once compressed.

use strict;

open IN,"urls.txt";

mkdir "piRNAclusters";
while (my $row = <IN>) {
	chomp $row;
	my @line = split "\t",$row;
	my $url = $line[0];
	my $species;
	if ($url =~ m/data\/(.+)\/piRNAclusters.gtf/) {
		$species = $1;
		printf "wget %s -O piRNAclusters/$species.gtf\n",$url;
		if (! -e "piRNAclusters/$species.gtf") {
			`wget $url -O piRNAclusters/$species.gtf`;
			`dos2unix piRNAclusters/$species.gtf`;
		}
	} elsif ($url =~ m/data\/FASTA\/(.+).piRNAclusters.fasta/) {
		$species = $1;
		$species =~ s/mississipi/mississippi/; # Correct spelling mistake!
		printf "wget %s -O piRNAclusters/$species.fa\n",$url;
		if (! -e "piRNAclusters/$species.fa.gz") {
			`wget $url -O piRNAclusters/$species.fa`;
			`dos2unix piRNAclusters/$species.fa`;
			`gzip piRNAclusters/$species.fa`;
		}
	}
}

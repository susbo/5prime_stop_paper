#!/bin/bash

prefix="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb"

mkdir -p $prefix/201012_align_libraries
mkdir -p $prefix/201012_align_libraries/references

fastas=`ls $prefix/annotation/piRNAclusters/*.fa.gz`
for fasta in $fastas
do
	echo $fasta
	species=`basename $fasta .fa.gz`
	echo $species
	mkdir -p $prefix/201012_align_libraries/references/$species
	mkdir -p $prefix/201012_align_libraries/references/$species/bowtie
	zcat $fasta > $prefix/201012_align_libraries/references/$species/clusters.fa
	ln -s $prefix/201012_align_libraries/references/$species/clusters.fa $prefix/201012_align_libraries/references/$species/bowtie/clusters.fa
	bowtie-build $prefix/201012_align_libraries/references/$species/clusters.fa $prefix/201012_align_libraries/references/$species/bowtie/clusters
	samtools faidx $prefix/201012_align_libraries/references/$species/clusters.fa
done

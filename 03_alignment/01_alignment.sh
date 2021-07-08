#!/bin/bash

prefix="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries"
mkdir -p $prefix/alignment
mkdir -p log

files=`ls /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/pirna_unknown/fasta_unknown/*.gz`
for file in $files
do
	name=`basename $file .fa.gz`
	sbatch -n 20 -N 1 --mem 60G -o log/$name -e log/$name alignment.template $name
done

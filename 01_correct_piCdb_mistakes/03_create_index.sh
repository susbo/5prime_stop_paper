#!/bin/bash
#SBATCH -o logs/03.log -e logs/03.log

rm /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/NCBI_genomes/*.gz

for file in /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/NCBI_genomes/*.bgz
do 
	samtools faidx $file &
done

wait

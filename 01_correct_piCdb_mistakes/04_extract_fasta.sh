#!/bin/bash
#SBATCH -o logs/04.log -e logs/04.log

files=`ls /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/NCBI_genomes/*.bgz`

for file in $files
do
	echo $file 
	name=`basename $file .fa.bgz`
	echo $name
	rm /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/annotation/piRNAclusters/$name.fa.gz
	gtf="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb/annotation/piRNAclusters/$name.gtf"
	cat $gtf | awk -v OFS="" '{print $1,":",$4,"-",$5}' > regions.txt
	while IFS= read -r line
	do
		samtools-1.6 faidx $file $line | gzip -c >> /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/annotation/piRNAclusters/$name.fa.gz
	done < regions.txt
done

rm regions.txt

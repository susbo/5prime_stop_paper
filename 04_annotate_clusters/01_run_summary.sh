#!/bin/bash

mkdir -p /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/summary_uniq

files=`ls /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/*.bam`
count=0
for file in $files
do
	name=`basename $file .bam`
	perl summary_uniq.pl $name > /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/summary_uniq/$name.txt &
	count=$((count+1))
	if [ $count -ge 20 ]; then
		wait
		count=0
	fi
done

wait

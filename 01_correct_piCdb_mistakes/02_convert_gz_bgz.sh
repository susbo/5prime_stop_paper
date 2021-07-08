#!/bin/bash

export MODULEPATH=/home/software/modules/linux-centos7-haswell
module load htslib-1.9-gcc-9.2.0-7vk4zru

for file in /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/NCBI_genomes/*.gz
do 
	echo $file
	new=`echo $file | sed -e 's/.fa.gz/.fa.bgz/'`
	zcat $file | bgzip -c > $new &
	rm $file
done

wait

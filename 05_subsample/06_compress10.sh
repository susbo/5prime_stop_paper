#!/usr/bin/perl -w
# Create compressed files with sequence and count

mkdir -p /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/capped_10/compressed/

files=`ls /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/capped_10/*.txt`

for file in $files
do
	name=`basename $file`
	cat $file | sort | uniq -c | awk -v OFS="\t" '{print $1,$2}' | gzip -c > /mnt/scratcha/ghlab/sus/public_data/201002_piCdb/201012_align_libraries/alignment/capped_10/compressed/$name.gz
done

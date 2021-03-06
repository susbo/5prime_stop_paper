# Analysis of the piRNA cluster database

## Summary

This repositority contains the code that was used to download, process and analyze the piRNA cluster database (https://www.smallrnagroup.uni-mainz.de/piRNAclusterDB).

The processing was done using the following steps:

* **00_download**
	* 01_download_annotation.pl
	* 02_download_libraries.pl
* **01_correct_piCdb_mistakes**
	* 01_download_reference_genomes.sh
	* 02_convert_gz_bgz_sh
	* 03_create_index.sh
	* 04_extract_fasta.sh
* **02_create_reference**
	* 01_create_reference.sh
* **03_alignment**
	* 01_alignment.sh
* **04_annotate_clusters**
	* 01_run_summary.sh
	* 02_select_clusters.pl
* **05_subsample**
	* 01_deduplicate100.pl
	* 02_compress100.sh
	* 03_deduplicate1.pl
	* 04_compress1.sh
	* 05_deduplicate10.pl
	* 06_compress10.sh
* **06_select_reads**
	* 01_select_reads.pl
* **07_analyze_clusters**
	* 01_analyze.pl
	* 02_count_codons.pl

The steps must be run in the outlined order. Some of the steps are further explained below.

Please note that this is a comprehensive description of what was done rather than a full pipeline to reproduce the results. In order to re-run the pipeline, minor edits would be required, such as updating paths in some of the scripts. Furthermore, the scripts assume that jobs can be submitted to a cluster using slurm, this may need editing depending on the local environment.

## Processing

### 00_download

This step downloads all required data from the piRNA cluster database.

* **01_download_annotation.pl**: Download the cluster annotation and sequence data. This will download around 100 MB of data, which will require 40 MB in local storage space once completed and compressed. The script will download the files to the current directory as "piRNAclusters" and you will have to make sure that this directory is the "piRNAclusters" folder in the subsequent steps.

* **02_download_libraries.pl**: Download the sequencing libraries. **_WARNING: This will download around 17.14 GB of data, which will require 4.97 GB in local storage space once completed and compressed._** The script will download the files to the current directory as "pirna_unknown" and you will have to make sure that this directory is the "pirna_unknown" folder in the subsequent steps.

### 01_correct_piCdb_mistakes

This step re-creates 12 cluster fasta files that were empty in the piRNA cluster database.

* **01_download_reference_genomes.sh**: Download reference genomes. **_WARNING: This step will download 5 GB of data._**
* **02_convert_gz_bgz.sh**: Convert genomes to bgz format to allow processing of compressed files.
* **03_create_index.sh**: Create indices using samtools faidx.
* **04_extract_fasta.sh**: Extract sequence of cluster regions.

### 02_create_reference

This step creates a bowtie index for each cluster fasta.

* **01_create_reference.sh**: Create folder structure and bowtie indices.

### 03_alignment

This step aligns each library to the corresponding cluster index.

* **01_alignment.sh**: Align each library to a cluster fasta.

### 04_annotate_clusters

This step identifies clusters that were expressed in the analyzed libraries (ovary or testis).

* **01_run_summary.sh**: Summarize the number of reads mapping to each cluster strand as well as the 1U and 10A bias. 
* **02_select_clusters.pl**: Select expressed piRNA clusters based on previous summary.

### 05_subsample

This step subsamples reads originating from the same genomic 5' end position.

* **01_deduplicate100.pl**: Select at most 100 reads per 5' end position within selected clusters (only reads 24-31nt reported).
* **02_compress100.sh**: Create compressed file with sequence and multiplicity for reads selected in 01.
* **03_deduplicate1.pl**: Select at most 1 read per 5' end position within selected clusters (only reads 24-31nt reported).
* **04_compress1.sh**: reate compressed file with sequence and multiplicity for reads selected in 03.
* **05_deduplicate10.pl**: Select at most 10 reads per 5' end position within selected clusters (only reads 24-31nt reported).
* **06_compress10.sh**: reate compressed file with sequence and multiplicity for reads selected in 05.

### 06_select_reads

This step selects piRNAs mapping to the selected piRNA clusters.

* **01_select_reads.pl**: Retrieve 24-31 nt reads mapping to selected clusters.

### 07_analyze_clusters

This step extracts cluster composition data for downstream analysis.

* **01_analyze.pl**: Retrieve sequence of selected piRNA clusters.
* **02_count_codons.pl**: Count codons in clusters per species and library.

## Authors

* **Susanne Bornel??v** - [susbo](https://github.com/susbo)

## Citation

Please cite the following paper if you are using our pipeline:

An evolutionarily conserved stop codon enrichment at the 5??? ends of mammalian piRNAs
Susanne Bornel??v, Benjamin Czech, Gregory J Hannon
bioRxiv 2021.10.27.464999; doi: https://doi.org/10.1101/2021.10.27.464999

Please also refer to instructions on how to cite the piRNA cluster database:
https://www.smallrnagroup.uni-mainz.de/piRNAclusterDB/

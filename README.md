# 5prime_stop_paper
This repositority contains the code that was used to download, process and analyze the piRNA cluster database.

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
	* alignment.sh
* **04_annotate_clusters**
	* 01_run_summary.sh
	* 02_select_clusters.pl
* **05_select_reads**
	* 01_select_reads.pl
* **06_analyze_clusters**
	* 01_analyze.pl
	* 02_count_codons.pl
	* 03_count_GC.pl

The steps must be run in the outlined order. Some of the steps are further explained below.

This is a description of what was done rather than a full pipeline to reproduce the results. In order to re-run the pipeline, minor edits would be required, such as updating paths in some of the scripts. Furthermore, the scripts assume that jobs can be submitted to a cluster using slurm, this may need editing depending on the local environment.

## Processing

### 00_download - Download the required data from the piRNA cluster database

* **01_download_annotation.pl**: Download the cluster annotation and sequence data. This will download around 100 MB of data, which will require 40 MB in local storage space once completed and compressed. The script will download the files to the current directory as "piRNAclusters" and you will have to make sure that this directory is the "piRNAclusters" folder in the subsequent steps.

* **02_download_libraries.pl**: Download the sequencing libraries. **_WARNING: This will download around 17.14 GB of data, which will require 4.97 GB in local storage space once completed and compressed._** The script will download the files to the current directory as "pirna_unknown" and you will have to make sure that this directory is the "pirna_unknown" folder in the subsequent steps.

### 01_correct_piCdb_mistakes

* **01_download_reference_genomes.sh**
* **02_convert_gz_bgz.sh**
* **03_create_index.sh**
* **04_extract_fasta.sh**

### 02_create_reference

* **01_create_reference.sh**

### 03_alignment

* **alignment.sh**

### 04_annotate_clusters

* **01_run_summary.sh**
* **02_select_clusters.pl**

### 05_select_reads

* **01_select_reads.pl**

### 06_analyze_clusters

* **01_analyze.pl**
* **02_count_codons.pl**
* **03_count_GC.pl**




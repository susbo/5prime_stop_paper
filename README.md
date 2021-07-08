# 5prime_stop_paper
This repositority contains the code used to download, process and analyze the piRNA cluster database.

The processing was done using the following steps:

* 00_download
	* 01_download_annotation.pl
	* 02_download_libraries.pl
* 01_correct_piCdb_mistakes
* 02_create_reference
* 03_alignment
* 04_annotate_clusters
* 05_select_reads
* 06_analyze_clusters

The steps must be run in the outlined order. Some of the steps are further explained below.

This is a description of what was done rather than a full pipeline to reproduce the results. In order to re-run the pipeline, minor edits would be required, such as updating paths in some of the scripts. Furthermore, the scripts assume that jobs can be submitted to a cluster using slurm, this may need editing depending on the local environment.

## Processing

### 00_download - Download the required data

1. Run `00_download/01_download_annotation.pl` to download the cluster data. This will download around 100 MB of data, which will require 40 MB in local storage space once completed and compressed. The script will download the files to the current directory as "piRNAclusters" and you will have to make sure that this directory is the "piRNAclusters" folder in the subsequent steps.

2. Run `00_download/02_download_libraries.pl` to download the cluster data. **WARNING: This will download around 17.14 GB of data, which will require 4.97 GB in local storage space once completed and compressed.** The script will download the files to the current directory as "pirna_unknown" and you will have to make sure that this directory is the "pirna_unknown" folder in the subsequent steps.

## Process and analyze data

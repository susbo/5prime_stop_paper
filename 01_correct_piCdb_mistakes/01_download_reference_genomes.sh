#!/bin/bash
# Correct missing cluster fastas in the piCdb

prefix="/mnt/scratcha/ghlab/sus/public_data/201002_piCdb"

mkdir -p $prefix/201012_align_libraries
mkdir -p $prefix/201012_align_libraries/NCBI_genomes

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/035/GCF_000002035.6_GRCz11/GCF_000002035.6_GRCz11_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Danio_rerio.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/004/665/GCF_000004665.1_Callithrix_jacchus-3.2/GCF_000004665.1_Callithrix_jacchus-3.2_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Callithrix_jacchus.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/895/GCF_000001895.5_Rnor_6.0/GCF_000001895.5_Rnor_6.0_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Rattus_norvegicus.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/308/155/GCF_000308155.1_EptFus1.0/GCF_000308155.1_EptFus1.0_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Eptesicus_fuscus.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/900/499/025/GCA_900499025.1_Paegeria_k64b2000_dplexOGS2/GCA_900499025.1_Paegeria_k64b2000_dplexOGS2_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Pararge_aegeria.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/297/895/GCF_000297895.1_oyster_v9/GCF_000297895.1_oyster_v9_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Crassostrea_gigas.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/671/375/GCF_000671375.1_Cexi_2.0/GCF_000671375.1_Cexi_2.0_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Centruroides_sculpturatus.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/590/095/GCF_003590095.1_tn1/GCF_003590095.1_tn1_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Trichoplusia_ni.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/330/985/GCF_000330985.1_DBM_FJ_V1.1/GCF_000330985.1_DBM_FJ_V1.1_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Plutella_xylostella.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/368/295/GCF_003368295.1_ASM336829v1/GCF_003368295.1_ASM336829v1_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Carassius_auratus.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/335/GCF_000002335.3_Tcas5.2/GCF_000002335.3_Tcas5.2_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Tribolium_castaneum.fa.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/181/375/GCA_000181375.1_ASM18137v1/GCA_000181375.1_ASM18137v1_genomic.fna.gz -O $prefix/201012_align_libraries/NCBI_genomes/Tupaia_belangeri.fa.gz

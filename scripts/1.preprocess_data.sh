#!/bin/bash
#SBATCH --job-name=download_data                # Job name
#SBATCH --partition=cpu                      # Partition Name
#SBATCH --mem=8G
#SBATCH --output=logs/download_data_%A_%a.log               # Standard output and error log
#SBATCH --error=logs/download_data_%A_%a.err
#SBATCH --mail-type=END,FAIL                 # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=mmatos@nygenome.org      # Where to send mail 

module load samtools
module load bedtools 

# merge and index bam files
##these bams are already filtered
samtools merge -f ~/chrombpnet_tutorial/data/downloads/merged_unsorted.bam ~/chrombpnet_tutorial/data/downloads/rep1.bam  ~/chrombpnet_tutorial/data/downloads/rep2.bam  ~/chrombpnet_tutorial/data/downloads/rep3.bam
samtools sort -@4 ~/chrombpnet_tutorial/data/downloads/merged_unsorted.bam -o ~/chrombpnet_tutorial/data/downloads/merged.bam
samtools index ~/chrombpnet_tutorial/data/downloads/merged.bam

#Ensure that the peak regions do not intersect with the blacklist regions  (extended by 1057 bp on both sides)
bedtools slop -i ~/chrombpnet_tutorial/data/downloads/blacklist.bed.gz -g ~/chrombpnet_tutorial/data/downloads/hg38.chrom.sizes -b 1057 > ~/chrombpnet_tutorial/data/downloads/temp.bed
bedtools intersect -v -a ~/chrombpnet_tutorial/data/downloads/overlap.bed.gz -b ~/chrombpnet_tutorial/data/downloads/temp.bed  > ~/chrombpnet_tutorial/data/peaks_no_blacklist.bed


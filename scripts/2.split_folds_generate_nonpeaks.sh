#!/bin/bash
#SBATCH --job-name=2.splitfolds              # Job name
#SBATCH --partition=gpu                      # Partition Name
#SBATCH --mem=8G
#SBATCH --gres=gpu
#SBATCH --output=logs/2.splitfolds_%A.log               # Standard output and error log
#SBATCH --error=logs/2.splitfolds_%A.err
#SBATCH --mail-type=END,FAIL                 # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=mmatos@nygenome.org      # Where to send mail 

module load chrombpnet
module load bedtools

head -n 24  ~/chrombpnet_tutorial/data/downloads/hg38.chrom.sizes >  ~/chrombpnet_tutorial/data/downloads/hg38.chrom.subset.sizes

mkdir ~/chrombpnet_tutorial/data/splits

chrombpnet prep splits \
-c ~/chrombpnet_tutorial/data/downloads/hg38.chrom.subset.sizes \
-tcr chr1 chr3 chr6 \
-vcr chr8 chr20 \
-op ~/chrombpnet_tutorial/data/splits/fold_0


chrombpnet prep nonpeaks \
-g ~/chrombpnet_tutorial/data/downloads/hg38.fa \
-p ~/chrombpnet_tutorial/data/peaks_no_blacklist.bed \
-c ~/chrombpnet_tutorial/data/downloads/hg38.chrom.sizes \
-fl ~/chrombpnet_tutorial/data/splits/fold_0.json \
-br ~/chrombpnet_tutorial/data/downloads/blacklist.bed.gz \
-o ~/chrombpnet_tutorial/data/output
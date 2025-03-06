#!/bin/bash
#SBATCH --job-name=3.bias_model                # Job name
#SBATCH --partition=gpu                      # Partition Name
#SBATCH --mem=50G
#SBATCH --gres=gpu
#SBATCH --output=logs/3.bias_model_%A.log               # Standard output and error log
#SBATCH --error=logs/3.bias_model_%A.err
#SBATCH --mail-type=END,FAIL                 # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=mmatos@nygenome.org      # Where to send mail 

source /usr/share/lmod/lmod/init/bash

#module load chrombpnet
#module load pyBigWig
#module load bedtools

module load chrombpnet cudnn/8.9.7.29-CUDA-12.3.0 bedtools # CUDA/11.7.0 

#export PYTHONPATH=/nfs/sw/easybuild/software/chrombpnet/1.0/lib/python3.10/site-packages:$PYTHONPATH
export PATH=$HOME/bin:$PATH


mkdir -p ~/chrombpnet_tutorial/bias_model_305/

chrombpnet bias pipeline \
-ibam ~/chrombpnet_tutorial/data/downloads/merged.bam \
-d "ATAC" \
-g ~/chrombpnet_tutorial/data/downloads/hg38.fa \
-c ~/chrombpnet_tutorial/data/downloads/hg38.chrom.sizes \
-p ~/chrombpnet_tutorial/data/peaks_no_blacklist.bed \
-n ~/chrombpnet_tutorial/data/output_negatives.bed \
-fl ~/chrombpnet_tutorial/data/splits/fold_0.json \
-b 0.5 \
-o ~/chrombpnet_tutorial/bias_model_305/ \
-fp k562 

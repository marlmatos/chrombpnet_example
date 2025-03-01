#!/bin/bash
#SBATCH --job-name=001_ciseQTLTensor-nfeatures                 # Job name
#SBATCH --partition=gpu                      # Partition Name
#SBATCH --mem=8G
#SBATCH --gres=gpu
#SBATCH --output=logs/022025_ciseQTLTensor_%A_%a.log               # Standard output and error log
#SBATCH --error=logs/022025_ciseQTLTensor_%A_%a.err
#SBATCH --mail-type=END,FAIL                 # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=mmatos@nygenome.org      # Where to send mail 

module load chrombpnet

mkdir -p ~/chrombpnet_tutorial/bias_model/

chrombpnet bias pipeline \\
        -ibam ~/chrombpnet_tutorial/data/downloads/merged.bam \\
        -d "ATAC" \\
        -g ~/chrombpnet_tutorial/data/downloads/hg38.fa \\
        -c ~/chrombpnet_tutorial/data/downloads/hg38.chrom.sizes \\
        -p ~/chrombpnet_tutorial/data/peaks_no_blacklist.bed \\
        -n ~/chrombpnet_tutorial/data/output_negatives.bed \\
        -fl ~/chrombpnet_tutorial/data/splits/fold_0.json \\
        -b 0.5 \\
        -o ~/chrombpnet_tutorial/bias_model/ \\
        -fp k562 \\
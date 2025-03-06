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
module load singularity

# Define full home path to replace tilde
HOME_DIR=/gpfs/commons/home/mmatos

# Define singularity image
singularity_image=$HOME_DIR/packages/chrombpnet_latest.sif

mkdir -p $HOME_DIR/chrombpnet_tutorial/bias_model_306_b04/

# Run singularity with environment isolation
singularity exec --nv \
  --env PYTHONNOUSERSITE=1 \
  --no-home \
  -B $HOME_DIR/chrombpnet_tutorial \
  -B $HOME_DIR/packages \
  $singularity_image \
  chrombpnet bias pipeline \
  -ibam $HOME_DIR/chrombpnet_tutorial/data/downloads/merged.bam \
  -d "ATAC" \
  -g $HOME_DIR/chrombpnet_tutorial/data/downloads/hg38.fa \
  -c $HOME_DIR/chrombpnet_tutorial/data/downloads/hg38.chrom.sizes \
  -p $HOME_DIR/chrombpnet_tutorial/data/peaks_no_blacklist.bed \
  -n $HOME_DIR/chrombpnet_tutorial/data/output_negatives.bed \
  -fl $HOME_DIR/chrombpnet_tutorial/data/splits/fold_0.json \
  -b 0.4 \
  -o $HOME_DIR/chrombpnet_tutorial/bias_model_306_b04/ \
  -fp k562
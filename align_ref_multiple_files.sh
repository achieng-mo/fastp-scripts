#!/bin/bash

# Set reference
reference="reference.fasta"

# Output directory
mkdir -p aligned_bam_files

# Loop through all R1 files
for R1 in *_R1_001.fastq; do
    # Extract sample name (remove _R1.fastq.gz)
    sample=$(basename "$R1" _R1_001.fastq)
    
    # Set file names
    R2="${sample}_R2_001.fastq"
    SAM="${sample}.sam"
    BAM="aligned_bam_files/${sample}.bam"

    echo "Aligning $sample..."

    # Align with BWA
    bwa mem "$reference" "$R1" "$R2" > "$SAM"

    # Convert SAM to BAM and sort
    samtools view -bS "$SAM" | samtools sort -o "$BAM"

    # Index BAM file (optional but useful)
    samtools index "$BAM"

    # Remove SAM to save space
    rm "$SAM"

    echo "Done with $sample"
done

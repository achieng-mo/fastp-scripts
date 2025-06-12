mkdir -p fastp_output fastp_reports

for r1 in *_R1_001.fastq; do
    sample=$(basename "$r1" _R1_001.fastq)
    r2="${sample}_R2_001.fastq"

    out_r1="fastp_output/${sample}_R1_001.trimmed.fastq"
    out_r2="fastp_output/${sample}_R2_001.trimmed.fastq"
    html_report="fastp_reports/${sample}.html"
    json_report="fastp_reports/${sample}.json"

    echo "Running fastp for $sample..."

    fastp \
        -i "$r1" \
        -I "$r2" \
        -o "$out_r1" \
        -O "$out_r2" \
        -h "$html_report" \
        -j "$json_report" \
        --detect_adapter_for_pe \
        --thread 4
done

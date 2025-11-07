#!/bin/bash
############# Task 5: Gene-density classification per chromosome

input_file="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"

echo -e "Chromosome\tGeneCount\tClass" > density_report.txt

chromosomes=($(grep -v "^#" "$input_file" | cut -f1 | sort | uniq))

# Loop through each chromosome and count genes
for chr in "${chromosomes[@]}"; do
  # Count number of 'gene' features on this chromosome
  gene_count=$(grep -v "^#" "$input_file" | awk -v c="$chr" '$1==c && $3=="gene"' | wc -l)

  # Classify density
  if [ "$gene_count" -gt 2000 ]; then
    class="High-density"
  else
    class="Low-density"
  fi

  echo -e "${chr}\t${gene_count}\t${class}" >> density_report.txt
done

echo "Report written to density_report.txt"


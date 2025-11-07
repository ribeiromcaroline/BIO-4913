#!/bin/bash
################## Task 2: Count how many genes are on each chromosomes

input_file="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"

# (ignore lines starting with #)
chromosomes=($(grep -v "^#" "$input_file" | cut -f1 | sort | uniq))

echo -e "Chromosome\tGeneCount"

for chr in "${chromosomes[@]}"
do
    # count genes for this chromosome
    count=$(grep -v "^#" "$input_file" | awk -v c="$chr" '$1==c && $3=="gene"' | wc -l)

    echo -e "$chr\t$count"
done


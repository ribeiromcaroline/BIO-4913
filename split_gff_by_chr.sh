#!/bin/bash
############### Task 3: Split the GFF file into separate files by chromosome

input_file="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"

grep -v "^#" "$input_file" | cut -f1 | sort | uniq > chromosome_list.txt

while read chr
do
    grep -v "^#" "$input_file" | awk -v c="$chr" '$1==c' > "${chr}.gff"

    echo "Wrote ${chr}.gff"
done < chromosome_list.txt


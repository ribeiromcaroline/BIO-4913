#!/bin/bash
############### Task 4: Summarize features per chromosome into chromosome_summary.txt

features=("gene" "mRNA" "exon")

echo -e "Chromosome\tgene\tmRNA\texon" > chromosome_summary.txt

for file in *.gff
do
    # Start building a line using the filename
    line="$file"

    # 1. Loop through feature types and count each one
    for f in "${features[@]}"
    do
        count=$(awk -v type="$f" '$3 == type {c++} END {print c+0}' "$file")
        line="$line\t$count"
    done

    # 2. Write this completed line into the summary file
    echo -e "$line" >> chromosome_summary.txt
done

echo "Summary written to chromosome_summary.txt"


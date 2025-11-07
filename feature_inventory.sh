#!/bin/bash


input_file="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"

total=$(grep -v "^#" "$input_file" | wc -l)

counts=$(grep -v "^#" "$input_file" | cut -f3 | sort | uniq -c)

gene=$(echo "$counts" | awk '$2=="gene"{print $1; f=1} END{if(!f) print 0}')
mrna=$(echo "$counts" | awk '$2=="mRNA"{print $1; f=1} END{if(!f) print 0}')
exon=$(echo "$counts" | awk '$2=="exon"{print $1; f=1} END{if(!f) print 0}')

echo "Total number of features: $total"
echo -e "gene:\t$gene"
echo -e "mRNA:\t$mrna"
echo -e "exon:\t$exon"


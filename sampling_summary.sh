#!/bin/bash

INPUT="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUTPUT="sampling_summary.txt"

sites=$(cut -d',' -f2 "$INPUT" | tail -n +2 | sort -u)
n_sites=$(echo "$sites" | wc -l)

echo -e "Number of sites:\t$n_sites" > "$OUTPUT"
echo -e "Site_Code\tN_Samples\tN_Males\tN_Females" >> "$OUTPUT"

for site in $sites; do
  total=$(awk -F',' -v s="$site" 'NR>1 && $2==s {c++} END{print c+0}' "$INPUT")
  males=$(awk -F',' -v s="$site" 'NR>1 && $2==s && $3=="M" {c++} END{print c+0}' "$INPUT")
  females=$(awk -F',' -v s="$site" 'NR>1 && $2==s && $3=="F" {c++} END{print c+0}' "$INPUT")
  echo -e "${site}\t${total}\t${males}\t${females}" >> "$OUTPUT"
done


#!/bin/bash

INPUT="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUT="largest_individual_report.txt"

male_line=$(grep ",M," "$INPUT" | cut -d',' -f2,4 | sort -t',' -k2,2nr | head -n1)
female_line=$(grep ",F," "$INPUT" | cut -d',' -f2,4 | sort -t',' -k2,2nr | head -n1)

male_site="${male_line%%,*}"
male_len="${male_line##*,}"

female_site="${female_line%%,*}"
female_len="${female_line##*,}"

if [ "$male_site" = "$female_site" ]; then same="YES"; else same="NO"; fi

{
  echo -e "Longest Male (mm):\t$male_len"
  echo -e "Male Site:\t$male_site"
  echo -e "Longest Female (mm):\t$female_len"
  echo -e "Female Site:\t$female_site"
  echo -e "Same site?:\t$same"
} > "$OUT"


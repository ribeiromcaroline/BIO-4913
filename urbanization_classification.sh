#!/bin/bash

INPUT="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUTPUT="urbanization_classification.txt"

echo -e "Site_Code\tClass" > "$OUTPUT"

sites=$(cut -d',' -f2 "$INPUT" | tail -n +2 | sort -u)

for site in $sites; do
    avg_ip=$(grep ",${site}," "$INPUT" | cut -d',' -f5 | awk -F',' '{sum+=$1; n++} END{if(n>0) print sum/n; else print 0}')
    avg_int=${avg_ip%.*}

    if [ "$avg_int" -lt 15 ]; then
        class="Rural"
    elif [ "$avg_int" -lt 50 ]; then
        class="Suburban"
    else
        class="Urban"
    fi

    echo -e "${site}\t${class}" >> "$OUTPUT"
done


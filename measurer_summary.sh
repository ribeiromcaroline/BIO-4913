#!/bin/bash

INPUT="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
MAP="urbanization_classification.txt"
OUT="Measurer_summary.txt"

declare -A CLASS
while IFS=$'\t' read -r site class; do
    [[ $site == "Site_Code" ]] && continue
    CLASS["$site"]="$class"
done < "$MAP"

readarray -t MEAS < <(cut -d',' -f1 "$INPUT" | tail -n +2 | sort -u)

echo -e "Measurer\t#Samples\t#Rural\t#Suburban\t#Urban" > "$OUT"

declare -A TOT RUR SUB URB
while IFS=',' read -r meas site sex length ip; do
    [[ $meas == "Measurer_Initials" ]] && continue
    cls=${CLASS["$site"]}
    ((TOT["$meas"]++))
    if [[ "$cls" == "Rural" ]]; then ((RUR["$meas"]++))
    elif [[ "$cls" == "Suburban" ]]; then ((SUB["$meas"]++))
    elif [[ "$cls" == "Urban" ]]; then ((URB["$meas"]++))
    fi
done < "$INPUT"

for m in "${MEAS[@]}"; do
    echo -e "${m}\t${TOT[$m]:-0}\t${RUR[$m]:-0}\t${SUB[$m]:-0}\t${URB[$m]:-0}" >> "$OUT"
done


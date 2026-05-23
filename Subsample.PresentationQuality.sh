#!/usr/bin/env bash

# Usage:
# ./script.sh <input_file> <output_prefix> [subsample_size]

input_file="$1"
output_prefix="$2"

# Default subsample size = half the number of lines in input_file, rounded up
if [ -n "$3" ]; then
    subsample_size="$3"
else
    total_lines=$(wc -l < "$input_file")
    subsample_size=$(( (total_lines + 1) / 2 ))
fi

for i in $(seq -w 1 100);
do
    seed=$(sed -n "${i}p" seeds.txt)

    mkdir "Subsample_$i"

    shuf --random-source=<(yes "$seed") \
         -n "$subsample_size" \
         "$input_file" \
         > "${output_prefix}${i}.tsv"

    Rscript TestSignificance.r "${output_prefix}${i}.tsv"

    mv Rplots.pdf Test_Table.tsv "${output_prefix}${i}.tsv" "Subsample_$i"
done

cat Subsample*/Test_Table.tsv | \
awk 'BEGIN { OFS="\t" }{print $2,$3}' | \
sort -u > Unique.txt

Uline=1
while read i;
do
    test $Uline -eq 1 && ((Uline=Uline+1)) && continue
    echo "$i"
    grep "$i" */Test_Table.tsv | wc -l
done < Unique.txt

UAline=1
while read i; do
  test $UAline -eq 1 && ((UAline=UAline+1)) && continue
  count=$(grep "$i" */Test_Table.tsv | wc -l)
  printf "%s\t%s\n" "${i//\"/}" "$count"
done < Unique.txt > Unique.Appearances.tsv

USline=1
while read i; do
  test $USline -eq 1 && ((USline=USline+1)) && continue
  count=$(grep "$i.*yes" */Test_Table.tsv | wc -l)
  printf "%s\t%s\n" "${i//\"/}" "$count"
done < Unique.txt > Unique.Significant.tsv


while read i; do
  count=$(grep "$i" */Test_Table.tsv | wc -l)
  printf "%s\t%s\n" "${i//\"/}" "$count"
done < Unique.txt > Unique.Appearances.tsv

while read i; do
  count=$(grep "$i.*yes" */Test_Table.tsv | wc -l)
  printf "%s\t%s\n" "${i//\"/}" "$count"
done < Unique.txt > Unique.Significant.tsv

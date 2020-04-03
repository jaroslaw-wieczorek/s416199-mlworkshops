wc -l wikiniews_results.tsv > liczba_wierszy.txt

# Split lines between hypothesis and reference 
cut -f2 wikiniews_results.tsv > hypothesis.txt
cut -f3 wikiniews_results.tsv > reference.txt

# Crate TRN files
awk 'BEGIN{FS=OFS="\t"}{print $0,"(sp1_"NR")"}' < hypothesis.txt > hypothesis.trn
awk 'BEGIN{FS=OFS="\t"}{print $0,"(sp1_"NR")"}' < reference.txt > reference.trn

# RUN SCLITE and return Scores
sclite -f 0 -r reference.trn trn -h hypothesis.trn trn -e utf-8 -i rm -o all stdout | grep 'Scores' > results

# Show last 10 lines 
cat results | tail -n 10
# Scores: (#C #S #D #I) 19 0 0 0 ...

cat results | awk 'BEGIN{OFS="\t"}{print $6, $7, $8, $9}' | awk '{ print ($2 + $3 + $4)/($2 + $3 + $1) }' | tail -n 10

# Show files
ls






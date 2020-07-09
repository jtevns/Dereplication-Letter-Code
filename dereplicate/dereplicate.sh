arrayid="$1"
group=$(sed "${arrayid}q;d" still_needed.txt)

cd ../Groups/$group
#python /home/jtevans/fluxm/dparks_genomes_comparisons/dereplicate/selectUniqueGenomes.py summaryTable.tsv ../../binstats.txt
rm -rf dRep_default
rm -rf dRep_gani99
rm -rf dRep_gani965
dRep dereplicate ./dRep_default -p 20 --genomeInfo ../../dRep_binstats.csv -g ./*.fna
dRep dereplicate ./dRep_gani99 --S_algorithm gANI -sa .99 -p 20 --genomeInfo ../../dRep_binstats.csv -g ./*.fna
dRep dereplicate ./dRep_gani965 --S_algorithm gANI -sa .965 -p 20 --genomeInfo ../../dRep_binstats.csv -g ./*.fna

arrayid="$1"
group=$(sed "${arrayid}q;d" job.conf)

average_nucleotide_identity.py -i Groups/$group -o Groups/${group}/pyani_anib -m ANIb --workers 20

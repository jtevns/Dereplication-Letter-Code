from Bio import SeqIO
import sys
import random 

FASTA = sys.argv[1]
GENOME_LEN = sys.argv[2]
COMPLETIONS = sys.argv[3].split(",")

contigs = dict()

with open(FASTA) as handle:
    for record in SeqIO.parse(handle,"fasta"):
        contigs[record.id] = record

keys = [x for x in contigs.keys()]

for completion in COMPLETIONS:
    sub_combined_len = 0
    sub_contigs = dict()
    len_wanted = int(GENOME_LEN) * (int(completion)/100)
    while sub_combined_len < len_wanted:
        tmp_contig = contigs[random.choice(keys)]
        if tmp_contig.id not in sub_contigs:
            sub_combined_len += len(tmp_contig.seq)
            sub_contigs[tmp_contig.id] = tmp_contig
    outfile = FASTA.split("/")[-1].split(".")[0] + "_" + completion + "%.fasta"
    SeqIO.write(sub_contigs.values(),outfile,"fasta")	

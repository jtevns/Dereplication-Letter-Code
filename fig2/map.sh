arrayid=$(($1+1))

index=$(sed "${arrayid}q;d" job.conf)
strat=$(echo $index | cut -f2 -d "/")
path_r1="../metaG_reads/SRR1702559/SRR1702559_1.fastq"
path_r2="../metaG_reads/SRR1702559/SRR1702559_2.fastq"
sample_num=${strat}_SRR1702559

mkdir ${strat}

bwa mem -M -t 36 ${index} ${path_r1} ${path_r2} >$strat/${sample_num}.sam

singularity exec /nfs/turbo/lsa-dudelabs/containers/Bioinformatics_Python3/checkm-bbtools.sif pileup.sh in=${strat}/${sample_num}.sam out=${strat}/${sample_num}.pileup

samtools view -S -b ${strat}/${sample_num}.sam > ${strat}/${sample_num}.bam
rm ${strat}/${sample_num}.sam

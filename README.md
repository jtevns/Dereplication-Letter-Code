### This Repository contains the code and scripts used for the dereplication of genomes in multiple published data sets. 

# The Dereplication process:
## 1. first the large genome sets were divided into groups based on MASH similarity distances
- For each data set, a Mash sketch was made that contained all genomes.
    - ``` mash sketch -o all_genomes_sketch *.fna```
- Once the sketch was created, each genome fasta file was compared to the sketch resulting in pairwise distances between each genome.
    - ``` for i in ncbi-genomes-2018-09-19/*.fna;do mash dist -p 40 all_genomes_compound.msh $i >> ./mash_pairwise_distances.txt;done ```
- Now that we had a distance measure between each genome, we could use hierarchical clustering via the GenGroups.ipynb jupyter notebook.
- This created a table that contained genome name and the group it belonged to
- The table was parsed and genomes moved to directories of their assigned groups.

## 2. Once each of the subgroups was generated, dereplication was run in them.
- All 3 dRep approaches were run at the same time using the dereplicate.sh script. This generated a directory of dereplicated bins for each approach
- Once the dRep runs were complete genomes were dereplicated using pyani ANI in a multistep process
    - pyani was run using the pyani.sh script to generate a blast base ANI and percent overlap value between each genome.
    - The ANI and overlap tables were combined
    - The combined table was then provided to custom code that can be found at https://github.com/jtevns/Pairwise_Dereplication where genomes that were 99% similar or greater across at least 75% of the sequence length were removed 

# Figure 2
## 1. Making the tree
- marker genes were found in each genome using phylosift search. Phylosift aligns a default set of marker genes to the contigs to find them . 
-genes were then individually aligned using phylosift align
-the resulting gene alignments were then concatenated for each genome
-the tree was produced using fasttree with parameters -nt and -gtr

## 2. Mapping to the genomes
- reads were downloaded from ncbi (no. SRR1702559)
- reads were mapped competitively to each dereplicated genome set using bwa mem
- the resulting bam files were parsed using bbtools pileup.sh to generate avg coverage per contig per genome in each dereplicated set

## 3. Bringing them togethor
- The tree was visualized using R code primarily with ggtree
- small bar plots were added to the tree with ggtree

# Table 2
- sub groups of similar genomes were generated 
- new MAGs were produced by simulating different copleteness thresholds by randomly picking contigs within a genome until the estimated length to achieve the threshold was met based on checkm results generated previously
- each simulated set was then dereplicated and counted.


## All scripts written can be found in the associated folders in this repo. dereplicate contains the general dereplication scripts used in multiple steps. The script used to actually dereplicate based on pyani results can be found here: https://github.com/jtevns/Pairwise_Dereplication

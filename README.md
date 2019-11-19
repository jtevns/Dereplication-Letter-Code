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

 